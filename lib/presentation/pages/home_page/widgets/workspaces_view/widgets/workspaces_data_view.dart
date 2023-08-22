import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_notes/domain/models/workspace.dart';
import 'package:my_notes/presentation/pages/home_page/widgets/explorer_item.dart';
import 'package:my_notes/presentation/state_management/workspace_cubit/workspace_cubit.dart';

class WorkspacesDataView extends StatelessWidget {
  final List<Workspace> workspaces;
  final Workspace? selectedWorkspace;

  const WorkspacesDataView({
    Key? key,
    required this.workspaces,
    required this.selectedWorkspace,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: workspaces.length,
            itemBuilder: (context, index) {
              final workspace = workspaces[index];

              return ExplorerItem(
                title: workspace.title,
                isSelected: workspace == selectedWorkspace,
                onTap: () => context.read<WorkspacesCubit>().selectWorkspace(workspace),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: FractionallySizedBox(
            widthFactor: 1.0,
            child: OutlinedButton(
              onPressed: () => context.read<WorkspacesCubit>().createWorkspace(),
              child: const Text('+'),
            ),
          ),
        ),
      ],
    );
  }
}
