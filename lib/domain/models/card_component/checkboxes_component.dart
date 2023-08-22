part of 'card_component.dart';

class CheckboxesComponent extends CardComponent {
  final List<({String title, bool isChecked})> content;

  CheckboxesComponent(this.content);

  @override
  int get typeId => CheckboxesComponentAdapter.id;
}

class CheckboxesComponentAdapter extends TypeAdapter<CheckboxesComponent> {
  @override
  int get typeId => id;

  static int id = 5;

  @override
  CheckboxesComponent read(BinaryReader reader) {
    return CheckboxesComponent(List.generate(
      reader.readUint32(),
      (index) {
        return (
          title: reader.readString(),
          isChecked: reader.readBool(),
        );
      },
    ));
  }

  @override
  void write(BinaryWriter writer, CheckboxesComponent obj) {
    writer.writeUint32(obj.content.length);

    return obj.content.forEach((entry) {
      writer.writeString(entry.title);
      writer.writeBool(entry.isChecked);
    });
  }
}
