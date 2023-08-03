// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
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
      ),
      body: Consumer<TaskList>(
        builder: (context, taskList, child) {
          return ListView.builder(
            itemCount: taskList.tasks.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(taskList.tasks[index]['title']),
                leading: Checkbox(
                  value: taskList.tasks[index]['done'],
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
