// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:plan_task/providers/settings_provider.dart';
import 'package:plan_task/providers/task_list.dart';
import 'package:plan_task/screens/add_task_screen.dart';
import 'package:plan_task/screens/settings_screen.dart';
import 'package:plan_task/screens/tasks_screen.dart';
import 'package:plan_task/services/hive_service.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() async {
  final hiveService = HiveService();
  await hiveService.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskList()),
        ChangeNotifierProvider(create: (context) => SettingsProvider()),
      ],
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
              return const TasksScreen();
            },
            '/addTaskScreen': (context) {
              return const AddTaskScreen();
            },
            '/settingsScreen': (context) {
              return const SettingsScreen();
            },
          },
          debugShowCheckedModeBanner: false,
          title: "PlanTask",
          theme: ThemeData(
            useMaterial3: true,
          ),
          home: TasksScreen(),
        );
      },
    );
  }
}
