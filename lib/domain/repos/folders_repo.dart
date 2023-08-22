import 'package:my_notes/domain/models/folder.dart';

abstract class FoldersRepo{
  Future<List<Folder>> getFolders();
  Future<void> createFolder(Folder folder);
}