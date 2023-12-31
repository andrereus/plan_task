import 'package:hive_flutter/hive_flutter.dart';

// Not using sqflite because it only works on mobile, but not with local storage on the web
// Originally started implementing Isar, the so called "successor" to Hive, reverted back in Git and decided to use Hive
// Isar seems not mature right now (documentation too limited, website and GitHub does not match and outdated syntax in tutorials)

// HiveService contains everything needed for the interaction with Hive
// Separation of concerns - can be easily swapped with a different service (database, http, ...)

class HiveService {
  late final Box _box;

  // Private constructor
  HiveService._privateConstructor();

  // Singleton instance
  // To make sure the HiveService only gets initialized once
  // Not particularly necessary with the current implementation, but is more safe for further use
  static final HiveService _instance = HiveService._privateConstructor();

  // Factory constructor
  factory HiveService() {
    return _instance;
  }

  // Initialize Hive
  Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox("planTaskBox");
  }

  void saveTasks(List tasks) {
    _box.put('tasks', tasks);
  }

  List? loadTasks() {
    return _box.get('tasks') as List?;
  }

  void saveShowDoneTasks(bool value) {
    _box.put('showDoneTasks', value);
  }

  bool? loadShowDoneTasks() {
    return _box.get('showDoneTasks') as bool?;
  }
}
