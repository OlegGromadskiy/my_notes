import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_notes/application/application.dart';
import 'package:my_notes/domain/models/card_component/card_component.dart';
import 'package:my_notes/domain/models/folder.dart';
import 'package:my_notes/domain/models/workspace.dart';
import 'package:my_notes/domain/models/workspace_card.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  runApp(const Application());
}

Future<void> initHive() async{
  final dir = await getApplicationDocumentsDirectory();

  Hive.init('${dir.path}/storage');

  Hive.registerAdapter(FolderAdapter());
  Hive.registerAdapter(WorkspaceAdapter());
  Hive.registerAdapter(WorkspaceCardAdapter());
  Hive.registerAdapter(HeaderComponentAdapter());
  Hive.registerAdapter(CheckboxesComponentAdapter());
  Hive.registerAdapter(BulletPointsComponentAdapter());

  await Hive.openBox<Folder>('folders');
}