import 'package:my_notes/domain/models/folder.dart';

abstract class FoldersDataSource {
  Future<void> createFolder(Folder folder);

  Future<List<Folder>> getFolders();
}
