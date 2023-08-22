import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_notes/presentation/pages/home_page/widgets/workspaces_view/widgets/workspaces_data_view.dart';
import 'package:my_notes/presentation/pages/home_page/widgets/workspaces_view/widgets/workspaces_loading_view.dart';
import 'package:my_notes/presentation/state_management/workspace_cubit/workspace_cubit.dart';
import 'package:my_notes/presentation/state_management/workspace_cubit/workspace_state.dart';

class WorkspacesWidget extends StatelessWidget {
  const WorkspacesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150.0,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 1.0),
        color: Theme.of(context).colorScheme.surface.withOpacity(0.7),
        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
        child: BlocBuilder<WorkspacesCubit, WorkspacesState>(
          builder: (context, state) => switch (state) {
            WorkspacesDataState(selectedFolder: var f, selectedWorkspace: var w) =>
              WorkspacesDataView(workspaces: f.workspaces, selectedWorkspace: w),
            WorkspacesLoadingState() => const WorkspacesLoadingView(),
          },
        ),
      ),
    );
  }
}
