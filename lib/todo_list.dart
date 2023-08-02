import 'package:flutter/material.dart';
import 'package:plan_task/hive_service.dart';

class TodoList extends ChangeNotifier {
  List _tasks = [];

  TodoList() {
    _loadTasks();
  }

  List get tasks => _tasks;

  void addTask(String title) {
    _tasks.add({'title': title, 'done': false});
    HiveService.saveTasks(_tasks);
    notifyListeners();
  }

  void toggleDone(int index) {
    _tasks[index]['done'] = !_tasks[index]['done'];
    HiveService.saveTasks(_tasks);
    notifyListeners();
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
    HiveService.saveTasks(_tasks);
    notifyListeners();
  }

  void _loadTasks() {
    _tasks = HiveService.loadTasks() ?? [];
    notifyListeners();
  }
}
