import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

class WorkspaceScrollbars extends StatefulWidget {
  final Widget child;
  final Color scrollBarsColor;
  final TransformationController controller;

  const WorkspaceScrollbars({
    Key? key,
    required this.child,
    required this.controller,
    required this.scrollBarsColor,
  }) : super(key: key);

  @override
  State<WorkspaceScrollbars> createState() => _WorkspaceScrollbarsState();
}

class _WorkspaceScrollbarsState extends State<WorkspaceScrollbars> with TickerProviderStateMixin {
  final hoverNotifier = ValueNotifier(false);
  final mouseMovementNotifier = ValueNotifier(Offset.zero);

  late final ScrollbarSubPainter vertical;
  late final ScrollbarSubPainter horizontal;
  late final horizontalAnimation = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 333),
  );
  late final verticalAnimation = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 333),
  );

  ScrollbarSubPainter? selectedSubPainter;
  final tapOffsetNotifier = ValueNotifier(Offset.zero);

  @override
  void initState() {
    super.initState();

    vertical = ScrollbarSubPainter(
      controller: verticalAnimation,
      thumbnailColor: widget.scrollBarsColor,
      mouseMovementNotifier: mouseMovementNotifier,
      rectBuilder: (left, top) => Rect.fromLTWH(top, left, kScrollbarThickness, kScrollbarLength),
    )..interactions.forEach(
        (element) => _handleInteraction(
          verticalAnimation,
          element,
        ),
      );

    horizontal = ScrollbarSubPainter(
      controller: horizontalAnimation,
      thumbnailColor: widget.scrollBarsColor,
      mouseMovementNotifier: mouseMovementNotifier,
      rectBuilder: (left, top) => Rect.fromLTWH(left, top, kScrollbarLength, kScrollbarThickness),
    )..interactions.forEach(
        (element) => _handleInteraction(
          horizontalAnimation,
          element,
        ),
      );
  }

  @override
  void dispose() {
    super.dispose();

    [mouseMovementNotifier, hoverNotifier].forEach(
      (element) {
        element.dispose();
      },
    );
    [horizontalAnimation, verticalAnimation].forEach(
      (element) {
        element.dispose();
      },
    );

    vertical.controller.dispose();
    horizontal.controller.dispose();
  }

  void _handleInteraction(AnimationController controller, HoverStatus status) {
    switch (status) {
      case HoverStatus.hovered:
        hoverNotifier.value = true;
        controller.forward();
      case HoverStatus.unhovered:
        hoverNotifier.value = false;
        controller.reverse();
    }
  }

  void _onPanUpdate(DragUpdateDetails details) {
    final newTransformation = widget.controller.value.clone();

    if (horizontal == selectedSubPainter) {
      newTransformation.setTranslationRaw(
        -clampDouble(
          (widget.controller.value.row0.w - details.delta.dx * 10000 / context.size!.width) * -1,
          0,
          10000 - context.size!.width,
        ),
        widget.controller.value.row1.w,
        widget.controller.value.row2.w,
      );
    } else {
      newTransformation.setTranslationRaw(
        widget.controller.value.row0.w,
        -clampDouble(
          (widget.controller.value.row1.w - details.delta.dy * 10000 / context.size!.height) * -1,
          0,
          10000 - context.size!.height,
        ),
        widget.controller.value.row2.w,
      );
    }
    widget.controller.value = newTransformation;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        if (horizontal.hoverStatus == HoverStatus.hovered) {
          selectedSubPainter = horizontal;
        } else if (vertical.hoverStatus == HoverStatus.hovered) {
          selectedSubPainter = vertical;
        }

        if (selectedSubPainter != null) {
          tapOffsetNotifier.value = details.localPosition - selectedSubPainter!.rect.topLeft;
        }
      },
      onPanUpdate: _onPanUpdate,
      child: MouseRegion(
        onHover: (event) => mouseMovementNotifier.value = event.localPosition,
        child: CustomPaint(
          foregroundPainter: _WorkspaceScrollbarsPainter(
            vertical: vertical,
            horizontal: horizontal,
            controller: widget.controller,
            tapOffsetNotifier: tapOffsetNotifier,
            mouseMovementNotifier: mouseMovementNotifier,
          ),
          child: AnimatedBuilder(
            animation: hoverNotifier,
            builder: (context, child) {
              return IgnorePointer(
                ignoring: hoverNotifier.value,
                child: child,
              );
            },
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

const kScrollbarThickness = 10.0;
const kScrollbarLength = 100.0;

class _WorkspaceScrollbarsPainter extends CustomPainter {
  final ScrollbarSubPainter vertical;
  final ScrollbarSubPainter horizontal;

  final TransformationController controller;
  final ValueNotifier<Offset> tapOffsetNotifier;
  final ValueNotifier<Offset> mouseMovementNotifier;

  _WorkspaceScrollbarsPainter({
    required this.vertical,
    required this.horizontal,
    required this.controller,
    required this.tapOffsetNotifier,
    required this.mouseMovementNotifier,
  }) : super(
          repaint: Listenable.merge([
            controller,
            mouseMovementNotifier,
            vertical.controller,
            horizontal.controller,
          ]),
        );

  @override
  void paint(Canvas canvas, Size size) {
    vertical.draw(canvas, size.height, size.width, controller.value.row1.w);
    horizontal.draw(canvas, size.width, size.height, controller.value.row0.w);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

enum HoverStatus {
  hovered,
  unhovered,
}

class ScrollbarSubPainter {
  final Color thumbnailColor;
  final AnimationController controller;
  final Rect Function(double, double) rectBuilder;
  final ValueNotifier<Offset> mouseMovementNotifier;

  final interactionsController = StreamController<HoverStatus>.broadcast();
  late final interactions = interactionsController.stream.distinct();

  HoverStatus hoverStatus = HoverStatus.unhovered;
  Rect rect = Rect.zero;

  ScrollbarSubPainter({
    required this.controller,
    required this.rectBuilder,
    required this.thumbnailColor,
    required this.mouseMovementNotifier,
  });

  void draw(
    Canvas canvas,
    double mainAxisLength,
    double crossAxisLength,
    double viewPortOffset,
  ) {
    const startPadding = 4.0;
    const endPadding = 12.0;

    final allowedSpace = (mainAxisLength - startPadding - endPadding - kScrollbarLength);
    final factor = allowedSpace / (10000 - mainAxisLength);
    final offset = factor * -viewPortOffset;

    rect = rectBuilder(startPadding + offset, crossAxisLength - kScrollbarThickness - 4.0);

    Paint paint = Paint()
      ..color = Color.lerp(
        thumbnailColor.withOpacity(0.3),
        thumbnailColor.withOpacity(0.6),
        controller.value,
      )!;

    if (rect.contains(mouseMovementNotifier.value)) {
      hoverStatus = HoverStatus.hovered;
      interactionsController.add(HoverStatus.hovered);
    } else {
      interactionsController.add(HoverStatus.unhovered);
      hoverStatus = HoverStatus.unhovered;
    }

    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(8.0)),
      paint,
    );
  }
}
