import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResizeHandle extends StatelessWidget {
  final VoidCallback onDragEnd;
  final SystemMouseCursor cursor;
  final ValueChanged<Offset> onDrag;
  final Widget Function({required Widget child}) positionBuilder;

  const ResizeHandle.top({
    Key? key,
    required this.onDrag, required this.onDragEnd,
  })  : cursor = SystemMouseCursors.resizeUp,
        positionBuilder = _top,
        super(key: key);

  const ResizeHandle.bottom({
    Key? key,
    required this.onDrag, required this.onDragEnd,
  })  : cursor = SystemMouseCursors.resizeDown,
        positionBuilder = _bottom,
        super(key: key);

  const ResizeHandle.right({
    Key? key,
    required this.onDrag, required this.onDragEnd,
  })  : cursor = SystemMouseCursors.resizeRight,
        positionBuilder = _right,
        super(key: key);

  const ResizeHandle.left({
    Key? key,
    required this.onDrag, required this.onDragEnd,
  })  : cursor = SystemMouseCursors.resizeLeft,
        positionBuilder = _left,
        super(key: key);

  static Widget _top({required Widget child}) {
    return Positioned(right: 0.0, left: 0.0, height: 8.0, top: 0.0, child: child);
  }

  static Widget _bottom({required Widget child}) {
    return Positioned(right: 0.0, left: 0.0, height: 8.0, bottom: 0.0, child: child);
  }

  static Widget _right({required Widget child}) {
    return Positioned(right: 0.0, width: 8.0, top: 0.0, bottom: 0.0, child: child);
  }

  static Widget _left({required Widget child}) {
    return Positioned(left: 0.0, width: 8.0, top: 0.0, bottom: 0.0, child: child);
  }

  @override
  Widget build(BuildContext context) {
    return positionBuilder(
      child: GestureDetector(
        onPanCancel: () => onDragEnd(),
        onPanUpdate: (details) => onDrag(details.delta),
        onPanEnd: (_) => onDragEnd(),
        child: MouseRegion(
          cursor: cursor,
          child: Container(
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
