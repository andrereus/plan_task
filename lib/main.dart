// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sizer/sizer.dart';

void main() async {
  // (Not using sqflite because it only works on mobile and this app is required to work with local storage on the web)

  // Originally started implementing Isar, the so called "successor" to Hive
  // Reverted back in Git and decided to use Hive instead
  // Isar seems not mature right now (documentation on the website and GitHub does not match)
  // Documentation is too limited and tutorials that are a few months old partly already have outdated syntax

  await Hive.initFlutter();
  await Hive.openBox("todoBox");

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "PlanTask",
          theme: ThemeData(
            useMaterial3: true,
          ),
          home: Scaffold(
            body: Center(
              child: Text('Hello World!'),
            ),
          ),
        );
      },
    );
  }
}
