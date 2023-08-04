// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:plan_task/providers/settings_provider.dart';
import 'package:plan_task/providers/task_list_provider.dart';
import 'package:plan_task/screens/add_task_screen.dart';
import 'package:plan_task/screens/settings_screen.dart';
import 'package:plan_task/screens/task_list_screen.dart';
import 'package:plan_task/services/hive_service.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() async {
  // Initialize Hive database
  final hiveService = HiveService();
  await hiveService.init();

  runApp(
    // Integrate providers / state management
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskListProvider()),
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
    // Integrate Sizer in case sizes in percent based on screen size are needed
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          // Set up routes for navigation
          routes: {
            '/taskScreen': (context) => TaskListScreen(),
            '/addTaskScreen': (context) => AddTaskScreen(),
            '/settingsScreen': (context) => SettingsScreen(),
          },
          debugShowCheckedModeBanner: false,
          title: "PlanTask",
          // Generate ColorScheme based on color blue instead of
          // the default color of Material Design 3
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          home: TaskListScreen(),
        );
      },
    );
  }
}
