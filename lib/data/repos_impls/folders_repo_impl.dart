import 'package:my_notes/data/data_sources/folders_data_sources/folders_data_source.dart';
import 'package:my_notes/domain/models/folder.dart';
import 'package:my_notes/domain/repos/folders_repo.dart';

class FoldersRepoImpl extends FoldersRepo {
  final FoldersDataSource dataSource;

  FoldersRepoImpl(this.dataSource);

  @override
  Future<void> createFolder(Folder folder) {
    return dataSource.createFolder(folder);
  }

  @override
  Future<List<Folder>> getFolders() {
    return dataSource.getFolders();
  }
}