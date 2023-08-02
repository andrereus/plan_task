import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static final _box = Hive.box('taskBox');

  static void saveTasks(List tasks) {
    _box.put('tasks', tasks);
  }

  static List? loadTasks() {
    return _box.get('tasks') as List?;
  }
}
