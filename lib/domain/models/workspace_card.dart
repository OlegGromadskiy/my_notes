import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_notes/domain/models/card_component/card_component.dart';

class WorkspaceCard {
  final Rect rect;
  final List<CardComponent> cardComponents;

  WorkspaceCard({
    required this.rect,
    required this.cardComponents,
  });
}

class WorkspaceCardAdapter extends TypeAdapter<WorkspaceCard> {
  @override
  int get typeId => 3;

  @override
  WorkspaceCard read(BinaryReader reader) {
    return WorkspaceCard(
      rect: Rect.fromLTWH(
        reader.readDouble(),
        reader.readDouble(),
        reader.readDouble(),
        reader.readDouble(),
      ),
      cardComponents: reader.readList().cast<CardComponent>(),
    );
  }

  @override
  void write(BinaryWriter writer, WorkspaceCard obj) {
    writer.writeDouble(obj.rect.left);
    writer.writeDouble(obj.rect.top);
    writer.writeDouble(obj.rect.width);
    writer.writeDouble(obj.rect.height);

    writer.writeList(obj.cardComponents);
  }
}
