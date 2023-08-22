import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_notes/presentation/pages/home_page/widgets/workspace_widget/widgets/workspace_not_selected_view.dart';
import 'package:my_notes/presentation/pages/home_page/widgets/workspace_widget/widgets/workspace_selected_view.dart';
import 'package:my_notes/presentation/state_management/current_workspace_cubit/current_workspace_cubit.dart';
import 'package:my_notes/presentation/state_management/current_workspace_cubit/current_workspace_state.dart';

class WorkspaceWidget extends StatelessWidget {
  const WorkspaceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<CurrentWorkspaceCubit, CurrentWorkspaceState>(
        builder: (context, state) => switch (state) {
          CurrentWorkspaceSelectedState(selectedWorkspace: var s) =>
            WorkspaceSelectedView(workspace: s),
          CurrentWorkspaceNotSelectedState() => const WorkspaceNotSelectedView(),
        },
      ),
    );
  }
}

class WorkSpacePainter extends CustomPainter {
  const WorkSpacePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = Colors.white.withOpacity(0.2);
    var offset = const Offset(20.0, 20.0);

    while (offset.dy < size.height) {
      if (offset.dx + 1 >= size.width) {
        offset = Offset(20.0, offset.dy + 20.0);
      }

      canvas.drawCircle(offset, 1.0, p);

      offset = offset.translate(20.0, 0.0);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
