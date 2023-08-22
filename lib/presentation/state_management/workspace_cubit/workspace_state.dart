import 'package:my_notes/domain/models/folder.dart';
import 'package:my_notes/domain/models/workspace.dart';

sealed class WorkspacesState {}

class WorkspacesLoadingState extends WorkspacesState {}

class WorkspacesDataState extends WorkspacesState {
  final Folder selectedFolder;
  final Workspace? selectedWorkspace;

  WorkspacesDataState({
    required this.selectedFolder,
    this.selectedWorkspace,
  });
}
