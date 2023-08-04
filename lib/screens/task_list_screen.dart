// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:plan_task/providers/settings_provider.dart';
import 'package:plan_task/providers/task_list_provider.dart';
import 'package:provider/provider.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PlanTask'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.pushNamed(context, '/settingsScreen');
              },
            ),
          ),
        ],
      ),
      // Consumer2 for using two providers (maximum Consumer7, alternative are watchers)
      body: Consumer2<TaskListProvider, SettingsProvider>(
        builder: (context, taskList, settings, child) {
          // Filter task list based on setting showDoneTasks
          var tasks = settings.showDoneTasks
              ? taskList.tasks
              : taskList.tasks.where((task) => !task['done']).toList();
          return Padding(
            padding: const EdgeInsets.only(top: 10),
            // Using separated ListView to add Dividers between tasks
            // See separatorBuilder below
            child: ListView.separated(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tasks[index]['title']),
                  leading: Checkbox(
                    value: tasks[index]['done'],
                    onChanged: (value) {
                      taskList.toggleDone(tasks[index]);
                    },
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      // Making sure Deletion is confirmed
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Confirm Deletion'),
                            content: Text('Delete "${tasks[index]['title']}"?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  taskList.deleteTask(tasks[index]);
                                  Navigator.of(context).pop();
                                },
                                child: Text('Delete'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.delete_outline),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  thickness: 0.2,
                );
              },
            ),
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
