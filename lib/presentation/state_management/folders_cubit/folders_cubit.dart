import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_notes/domain/models/folder.dart';
import 'package:my_notes/domain/repos/folders_repo.dart';
import 'package:my_notes/presentation/state_management/folders_cubit/folders_state.dart';
import 'package:my_notes/utils/extensions/when.dart';

class FoldersCubit extends Cubit<FoldersState> {
  final FoldersRepo repo;

  FoldersCubit(this.repo) : super(FoldersLoadingState());

  Future<void> loadFolders() async {
    final folders = await repo.getFolders();

    emit(
      FoldersDataState(
        folders: folders,
        selectedFolder: folders.isEmpty ? null : folders.first,
      ),
    );
  }

  Future<void> selectFolder(Folder folder) async {
    state.when<FoldersDataState>((state) {
      emit(
        FoldersDataState(
          folders: state.folders,
          selectedFolder: folder,
        ),
      );
    });
  }

  Future<void> createFolder(String title) async {
    final newFolder = Folder(
      title: title,
      workspaces: [],
    );

    await repo.createFolder(newFolder);

    state.when<FoldersDataState>((state) {
      emit(
        FoldersDataState(
          folders: [...state.folders, newFolder],
          selectedFolder: newFolder,
        ),
      );
    });
  }
}
