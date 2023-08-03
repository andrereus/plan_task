// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:plan_task/providers/settings_provider.dart';
import 'package:plan_task/providers/task_list.dart';
import 'package:provider/provider.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settingsScreen'),
          ),
        ],
      ),
      body: Consumer2<TaskList, SettingsProvider>(
        builder: (context, taskList, settings, child) {
          var tasks = settings.showDoneTasks
              ? taskList.tasks
              : taskList.tasks.where((task) => !task['done']).toList();
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(tasks[index]['title']),
                leading: Checkbox(
                  value: tasks[index]['done'],
                  onChanged: (value) {
                    taskList.toggleDone(index);
                  },
                ),
                trailing: IconButton(
                  onPressed: () {
                    taskList.deleteTask(index);
                  },
                  icon: Icon(Icons.delete_outline),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addTaskScreen');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
