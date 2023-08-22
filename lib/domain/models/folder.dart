import 'package:hive/hive.dart';
import 'package:my_notes/domain/models/workspace.dart';

import '../../utils/mixins/hive_id.dart';

class Folder with HiveObjectMixin {
  final String title;
  final List<Workspace> workspaces;

  Folder({
    required this.title,
    required this.workspaces,
  });
}

class FolderAdapter extends TypeAdapter<Folder> {
  @override
  Folder read(BinaryReader reader) {
    return Folder(
      title: reader.readString(),
      workspaces: reader.readList().cast<Workspace>(),
    );
  }

  @override
  void write(BinaryWriter writer, Folder obj) {
    writer.writeString(obj.title);
    writer.writeList(obj.workspaces);
  }

  @override
  int get typeId => 1;
}
