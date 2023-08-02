// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:plan_task/todo_list.dart';
import 'package:provider/provider.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todos')),
      body: Consumer<TodoList>(
        builder: (context, todoList, child) => ListView.builder(
          itemCount: todoList.tasks.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(todoList.tasks[index]['title']),
            trailing: Checkbox(
              value: todoList.tasks[index]['done'],
              onChanged: (value) => todoList.toggleDone(index),
            ),
            onTap: () => todoList.deleteTask(index),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(controller: _controller),
        actions: [
          ElevatedButton(
            onPressed: () {
              Provider.of<TodoList>(context, listen: false)
                  .addTask(_controller.text);
              _controller.clear();
              Navigator.pop(context);
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }
}
