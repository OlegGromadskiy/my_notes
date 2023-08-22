import 'package:hive/hive.dart';
import 'package:my_notes/domain/models/workspace_card.dart';
import 'package:my_notes/utils/mixins/hive_id.dart';

class Workspace with HiveObjectMixin {
  final String title;
  final List<WorkspaceCard> cards;

  Workspace({
    required this.title,
    required this.cards,
  });
}

class WorkspaceAdapter extends TypeAdapter<Workspace>{
  @override
  Workspace read(BinaryReader reader) {
    return Workspace(
      title: reader.readString(),
      cards: reader.readList().cast<WorkspaceCard>(),
    );
  }

  @override
  void write(BinaryWriter writer, Workspace obj) {
    writer.writeString(obj.title);
    writer.writeList(obj.cards);
  }

  @override
  int get typeId => 2;
}
