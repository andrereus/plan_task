// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() {
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
