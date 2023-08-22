import 'package:hive/hive.dart';

mixin HiveId<T> on TypeAdapter<T> {
  static int _id = 0;

  static int get id => _id++;

  @override
  final typeId = id;
}
