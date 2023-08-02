import 'package:flutter/material.dart';
import 'package:plan_task/services/hive_service.dart';

// State Management / Provider
// Provides state and functions to UI in a single place
// Interacts with HiveService for persistance and notifies listeners on changes

class TaskList extends ChangeNotifier {
  final HiveService hiveService = HiveService();

  // Consider using a Model and TypeAdapter for a production apps
  List _tasks = [];

  TaskList() {
    _init();
  }

  Future<void> _init() async {
    await hiveService.init();
    _loadTasks();
  }

  List get tasks => List.unmodifiable(_tasks);

  void addTask(String title) {
    _tasks.add({'title': title, 'done': false});
    hiveService.saveTasks(_tasks);
    notifyListeners();
  }

  void toggleDone(int index) {
    _tasks[index]['done'] = !_tasks[index]['done'];
    hiveService.saveTasks(_tasks);
    notifyListeners();
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
    hiveService.saveTasks(_tasks);
    notifyListeners();
  }

  void _loadTasks() {
    _tasks = hiveService.loadTasks() ?? [];
    notifyListeners();
  }
}
