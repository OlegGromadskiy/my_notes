part of 'card_component.dart';

class BulletPointsComponent implements CardComponent{
  final List<String> content;


  BulletPointsComponent(this.content);

  @override
  int get typeId => BulletPointsComponentAdapter.id;
}

class BulletPointsComponentAdapter extends TypeAdapter<BulletPointsComponent>{
  @override
  int get typeId => id;

  static int id = 6;

  @override
  BulletPointsComponent read(BinaryReader reader) {
    return BulletPointsComponent(reader.readStringList());
  }

  @override
  void write(BinaryWriter writer, BulletPointsComponent obj) {
    writer.writeStringList(obj.content);
  }
}