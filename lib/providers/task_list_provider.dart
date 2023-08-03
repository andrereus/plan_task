import 'package:flutter/material.dart';
import 'package:plan_task/services/hive_service.dart';

// State Management / Provider
// Provides state and functions to UI from a single place
// Interacts with HiveService for persistence and notifies listeners on changes

class TaskListProvider extends ChangeNotifier {
  final HiveService hiveService = HiveService();

  // Consider using a Model and TypeAdapter for a production apps
  List _tasks = [];

  TaskListProvider() {
    _loadTasks();
  }

  List get tasks => List.unmodifiable(_tasks);

  void addTask(String title) {
    _tasks.add({'title': title, 'done': false});
    hiveService.saveTasks(_tasks);
    notifyListeners();
  }

  void toggleDone(Map task) {
    task['done'] = !task['done'];
    hiveService.saveTasks(_tasks);
    notifyListeners();
  }

  void deleteTask(Map task) {
    _tasks.remove(task);
    hiveService.saveTasks(_tasks);
    notifyListeners();
  }

  void _loadTasks() {
    _tasks = hiveService.loadTasks() ?? [];
    notifyListeners();
  }
}
