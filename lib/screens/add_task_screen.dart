// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:plan_task/providers/task_list_provider.dart';
import 'package:provider/provider.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Intentionally not using Sizer to avoid making sizes depend on screen size
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Task"),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "Title",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 20,
              ),
            ),
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                Provider.of<TaskListProvider>(context, listen: false)
                    .addTask(_controller.text);
                _controller.clear();
                Navigator.pop(context);
              }
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }
}
