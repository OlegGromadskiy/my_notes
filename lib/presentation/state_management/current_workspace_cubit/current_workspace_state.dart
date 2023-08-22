import 'package:my_notes/domain/models/workspace.dart';

sealed class CurrentWorkspaceState {}

class CurrentWorkspaceNotSelectedState extends CurrentWorkspaceState {}

class CurrentWorkspaceSelectedState extends CurrentWorkspaceState {
  final Workspace selectedWorkspace;

  CurrentWorkspaceSelectedState(this.selectedWorkspace);
}
