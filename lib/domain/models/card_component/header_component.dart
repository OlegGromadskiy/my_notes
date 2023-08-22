part of 'card_component.dart';

class HeaderComponent extends CardComponent {
  final String content;
  final double fontSize;

  HeaderComponent({
    required this.content,
    required this.fontSize,
  });

  @override
  int get typeId => HeaderComponentAdapter.id;
}

class HeaderComponentAdapter extends TypeAdapter<HeaderComponent> {
  @override
  int get typeId => id;
  static int id = 4;

  @override
  HeaderComponent read(BinaryReader reader) {
    return HeaderComponent(
      content: reader.readString(),
      fontSize: reader.readDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, HeaderComponent obj) {
    writer.writeString(obj.content);
    writer.writeDouble(obj.fontSize);
  }
}
