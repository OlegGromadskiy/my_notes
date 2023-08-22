import 'package:my_notes/domain/models/folder.dart';

sealed class FoldersState {}

class FoldersLoadingState extends FoldersState {}

class FoldersDataState extends FoldersState {
  final List<Folder> folders;
  final Folder? selectedFolder;

  FoldersDataState({
    required this.folders,
    this.selectedFolder,
  });
}
