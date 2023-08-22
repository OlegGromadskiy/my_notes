import 'package:hive/hive.dart';
import 'package:my_notes/data/data_sources/folders_data_sources/folders_data_source.dart';
import 'package:my_notes/domain/models/folder.dart';

class HiveFoldersDataSource extends FoldersDataSource{
  final Box<Folder> box;

  HiveFoldersDataSource(this.box);

  @override
  Future<void> createFolder(Folder folder) async {
    await box.add(folder);
  }

  @override
  Future<List<Folder>> getFolders() async {
    return  box.values.toList();
  }
}