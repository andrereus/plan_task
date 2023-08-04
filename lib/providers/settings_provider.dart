import 'package:flutter/material.dart';
import 'package:plan_task/services/hive_service.dart';

class SettingsProvider extends ChangeNotifier {
  final HiveService hiveService = HiveService();

  bool _showDoneTasks = true;

  SettingsProvider() {
    _loadShowDoneTasks();
  }

  // Already not modifiable
  bool get showDoneTasks => _showDoneTasks;

  void toggleShowDoneTasks() {
    _showDoneTasks = !_showDoneTasks;
    hiveService.saveShowDoneTasksSetting(_showDoneTasks);
    notifyListeners();
  }

  void _loadShowDoneTasks() {
    _showDoneTasks = hiveService.loadShowDoneTasksSetting() ?? true;
    notifyListeners();
  }
}
