import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_notes/domain/models/folder.dart';
import 'package:my_notes/domain/models/workspace.dart';
import 'package:my_notes/presentation/state_management/workspace_cubit/workspace_state.dart';
import 'package:my_notes/utils/extensions/when.dart';

class WorkspacesCubit extends Cubit<WorkspacesState> {
  WorkspacesCubit() : super(WorkspacesLoadingState());

  Future<void> createWorkspace() async {
    state.when<WorkspacesDataState>((state) {
      state.selectedFolder.workspaces.add(
        Workspace(
          title: 'workspace ${DateTime.now()}',
          cards: [],
        ),
      );

      state.selectedFolder.save();

      emit(WorkspacesDataState(
        selectedFolder: state.selectedFolder,
        selectedWorkspace: state.selectedFolder.workspaces.first,
      ));
    });
  }

  Future<void> updateFolder(Folder folder) async {
    emit(WorkspacesDataState(
      selectedFolder: folder,
      selectedWorkspace: folder.workspaces.isNotEmpty ? folder.workspaces.first : null,
    ));
  }

  Future<void> save() async {
    state.when<WorkspacesDataState>((state) {
      state.selectedFolder.save();
      emit(
        WorkspacesDataState(
          selectedFolder: state.selectedFolder,
          selectedWorkspace: state.selectedWorkspace,
        ),
      );
    });
  }

  Future<void> selectWorkspace(Workspace workspace) async {
    state.when<WorkspacesDataState>((state) {
      emit(WorkspacesDataState(
        selectedFolder: state.selectedFolder,
        selectedWorkspace: workspace,
      ));
    });
  }
}
