import 'package:flutter/material.dart';
import 'package:plan_task/providers/settings_provider.dart';
import 'package:plan_task/providers/task_list_provider.dart';
import 'package:plan_task/screens/add_task_screen.dart';
import 'package:plan_task/screens/settings_screen.dart';
import 'package:plan_task/screens/task_list_screen.dart';
import 'package:plan_task/services/hive_service.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

// Project info: Again used Git for version control
// Minimized project with "flutter clean" to remove build artifacts before zip and upload
// (General info: When using "flutter clean" it's necessary to run "flutter pub get" afterwards)

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
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Integrate Sizer just in case sizes in percent, based on screen size, are needed
    // Intentionally avoiding it until necessary, to make sizes not depend on screen size too much
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          // Set up routes for navigation
          routes: {
            '/taskScreen': (context) => const TaskListScreen(),
            '/addTaskScreen': (context) => const AddTaskScreen(),
            '/settingsScreen': (context) => const SettingsScreen(),
          },
          debugShowCheckedModeBanner: false,
          title: "PlanTask",
          // Generate ColorScheme based on color blue instead of the default color in Material Design 3
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          home: const TaskListScreen(),
        );
      },
    );
  }
}
