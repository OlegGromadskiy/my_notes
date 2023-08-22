import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_notes/domain/models/workspace.dart';
import 'package:my_notes/presentation/pages/home_page/widgets/workspace_widget/widgets/workspace_card.dart';
import 'package:my_notes/presentation/pages/home_page/widgets/workspace_widget/widgets/workspace_scrollbars.dart';
import 'package:my_notes/presentation/pages/home_page/widgets/workspace_widget/workspace_widget.dart';
import 'package:my_notes/presentation/state_management/current_workspace_cubit/current_workspace_cubit.dart';

import '../../../../../state_management/workspace_cubit/workspace_cubit.dart';

class WorkspaceSelectedView extends StatefulWidget {
  final Workspace workspace;

  const WorkspaceSelectedView({
    Key? key,
    required this.workspace,
  }) : super(key: key);

  @override
  State<WorkspaceSelectedView> createState() => _WorkspaceSelectedViewState();
}

class _WorkspaceSelectedViewState extends State<WorkspaceSelectedView> {
  final controller = TransformationController();

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
  }

  bool isIntersected(Rect rect, Size size) {
    return (Offset(controller.value.row0.w, controller.value.row1.w) * -1 & size).overlaps(rect);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onDoubleTapDown: (details) {
            context.read<CurrentWorkspaceCubit>().createCard(
                  details.localPosition.translate(
                    -controller.value.row0.w,
                    -controller.value.row1.w,
                  ),
                ).then((value) => context.read<WorkspacesCubit>().save());
          },
          child: WorkspaceScrollbars(
            scrollBarsColor: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
            controller: controller,
            child: InteractiveViewer(
              scaleEnabled: false,
              transformationController: controller,
              constrained: false,
              child: SizedBox(
                height: 10000,
                width: 10000,
                child: Stack(
                  children: [
                    const Positioned.fill(
                      child: RepaintBoundary(
                        child: CustomPaint(
                          painter: WorkSpacePainter(),
                        ),
                      ),
                    ),
                    ...widget.workspace.cards.map((card) {
                      return WorkspaceCardWidget(model: card);
                    }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
