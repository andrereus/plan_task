import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  late final Box _box;

  // Private constructor
  HiveService._privateConstructor();

  // Singleton instance
  static final HiveService _instance = HiveService._privateConstructor();

  // Factory constructor
  factory HiveService() {
    return _instance;
  }

  Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox("taskBox");
  }

  void saveTasks(List tasks) {
    _box.put('tasks', tasks);
  }

  List? loadTasks() {
    return _box.get('tasks') as List?;
  }
}
