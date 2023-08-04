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
        title: Text('Tasks'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settingsScreen'),
          ),
        ],
      ),
      body: Consumer2<TaskListProvider, SettingsProvider>(
        builder: (context, taskList, settings, child) {
          var tasks = settings.showDoneTasks
              ? taskList.tasks
              : taskList.tasks.where((task) => !task['done']).toList();
          return Padding(
            padding: const EdgeInsets.only(top: 10),
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
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
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
                        ),
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
