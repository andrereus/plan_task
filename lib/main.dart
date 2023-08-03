// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:plan_task/providers/task_list.dart';
import 'package:plan_task/screens/add_task_screen.dart';
import 'package:plan_task/screens/tasks_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() async {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskList(),
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          routes: {
            '/taskScreen': (context) {
              return const TaskScreen();
            },
            '/addTaskScreen': (context) {
              return const AddTaskScreen();
            }
          },
          debugShowCheckedModeBanner: false,
          title: "PlanTask",
          theme: ThemeData(
            useMaterial3: true,
          ),
          home: TaskScreen(),
        );
      },
    );
  }
}
