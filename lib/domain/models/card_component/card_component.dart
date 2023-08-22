import 'package:hive/hive.dart';

part 'header_component.dart';

part 'bullet_points_component.dart';

part 'checkboxes_component.dart';

sealed

class CardComponent {
  int get typeId;
}

class CardComponentAdapter extends TypeAdapter<CardComponent> {
  final List<TypeAdapter> adapters;

  CardComponentAdapter({required this.adapters});

  @override
  CardComponent read(BinaryReader reader) {
    final id = reader.readUint32();

    final adapter = adapters.singleWhere((adapter) => adapter.typeId == id);

    return adapter.read(reader);
  }

  @override
  int get typeId => 33;

  @override
  void write(BinaryWriter writer, CardComponent obj) {
    writer.writeUint32(obj.typeId);

    final adapter = adapters.singleWhere((adapter) => adapter.typeId == obj.typeId);
    adapter.write(writer, obj);
  }
}