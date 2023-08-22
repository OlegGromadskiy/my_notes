import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_notes/domain/models/workspace_card.dart';
import 'package:my_notes/presentation/pages/home_page/widgets/workspace_widget/widgets/component_selector_dialog.dart';
import 'package:my_notes/presentation/pages/home_page/widgets/workspace_widget/widgets/resize_handle.dart';
import 'package:my_notes/presentation/state_management/workspace_cubit/workspace_cubit.dart';

import '../../../../../../domain/models/card_component/card_component.dart';
import 'card_component_widget/card_component_widget.dart';

class WorkspaceCardWidget extends StatefulWidget {
  final WorkspaceCard model;

  const WorkspaceCardWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<WorkspaceCardWidget> createState() => _WorkspaceCardWidgetState();
}

class _WorkspaceCardWidgetState extends State<WorkspaceCardWidget> {
  late final rectNotifier = ValueNotifier(widget.model.rect);
  bool isDragStarted = false;

  void handleDrag(DragUpdateDetails details) {
    if (!isDragStarted) {
      return;
    }

    Offset offset = details.delta;

    var temp = rectNotifier.value.translate(offset.dx, offset.dy);

    temp = Rect.fromLTWH(
      clamp(temp.left, max: 9980 - temp.width),
      clamp(temp.top, max: 9980 - temp.height),
      temp.width,
      temp.height,
    );

    rectNotifier.value = temp;
  }

  double roundTo20(double value) {
    if (value % 20 >= 10) {
      return (value - value % 20) + 20;
    } else {
      return (value - value % 20);
    }
  }

  double clamp(double value, {double min = 20, double max = 9980}) => clampDouble(value, min, max);

  void resizeEnded() {
    isDragStarted = false;

    rectNotifier.value = Rect.fromLTWH(
      roundTo20(rectNotifier.value.left),
      roundTo20(rectNotifier.value.top),
      roundTo20(rectNotifier.value.width),
      roundTo20(rectNotifier.value.height),
    );
    context.read<WorkspacesCubit>().save();
  }

  void _showDialog(TapUpDetails details) {
    showDialog<CardComponent>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      builder: (context) {
        return Stack(
          children: [
            Positioned(
              left: details.globalPosition.dx,
              top: details.globalPosition.dy,
              child: const ComponentSelectorDialog(),
            ),
          ],
        );
      },
    ).then((value) {
      if (value == null) {
        return;
      }

      widget.model.cardComponents.add(value);
      context.read<WorkspacesCubit>().save();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: rectNotifier,
      builder: (context, child) {
        return Positioned(
          left: rectNotifier.value.left,
          top: rectNotifier.value.top,
          width: rectNotifier.value.width,
          height: rectNotifier.value.height,
          child: child!,
        );
      },
      child: GestureDetector(
        onPanUpdate: handleDrag,
        onPanCancel: resizeEnded,
        onTapDown: (details) => isDragStarted = true,
        onTapUp: (details) => isDragStarted = false,
        onPanEnd: (_) => resizeEnded(),
        child: Stack(
          children: [
            Positioned.fill(
              child: Card(
                margin: EdgeInsets.zero,
                elevation: 4.0,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Theme.of(context).colorScheme.onPrimaryContainer),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...widget.model.cardComponents.map((e) {
                          return CardComponentWidget(component: e);
                        }),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTapUp: (details) => _showDialog(details),
                            child: const FractionallySizedBox(
                              widthFactor: 1.0,
                              child: Center(
                                child: Icon(Icons.add),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ResizeHandle.left(
              onDragEnd: resizeEnded,
              onDrag: (Offset value) {
                final oldRect = rectNotifier.value;

                rectNotifier.value = Rect.fromLTWH(
                  clamp(oldRect.left + value.dx),
                  clamp(oldRect.top),
                  clamp(oldRect.width - (clamp(oldRect.left + value.dx) - oldRect.left)),
                  clamp(oldRect.height),
                );
              },
            ),
            ResizeHandle.top(
              onDragEnd: resizeEnded,
              onDrag: (Offset value) {
                final oldRect = rectNotifier.value;

                rectNotifier.value = Rect.fromLTWH(
                  clamp(oldRect.left),
                  clamp(oldRect.top + value.dy),
                  clamp(oldRect.width),
                  clamp(oldRect.height - (clamp(oldRect.top + value.dy) - oldRect.top)),
                );
              },
            ),
            ResizeHandle.right(
              onDragEnd: resizeEnded,
              onDrag: (Offset value) {
                final oldRect = rectNotifier.value;

                rectNotifier.value = Rect.fromLTWH(
                  clamp(oldRect.left),
                  clamp(oldRect.top),
                  clamp(oldRect.width + value.dx),
                  clamp(oldRect.height),
                );
              },
            ),
            ResizeHandle.bottom(
              onDragEnd: resizeEnded,
              onDrag: (Offset value) {
                final oldRect = rectNotifier.value;

                rectNotifier.value = Rect.fromLTWH(
                  clamp(oldRect.left),
                  clamp(oldRect.top),
                  clamp(oldRect.width),
                  clamp(oldRect.height + value.dy),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
