import 'package:flutter/material.dart';
import 'presentation/map_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: const Color.fromARGB(255, 156, 169, 244),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          circularTrackColor: Color.fromARGB(255, 3, 208, 116),
          color: Color.fromARGB(255, 79, 61, 199),
        ),
      ),
      title: 'Map Test Task',
      home: const MapScreen(title: 'Map Test Task'),
    );
  }
}
