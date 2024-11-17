import 'package:flutter/material.dart';
import 'list_grades.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grade Management System',
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: const Color.fromARGB(255, 207, 83, 0), // Primary color
          primaryContainer: const Color.fromARGB(255, 207, 83, 0), // Primary container color
          secondary:  const Color(0xFF0B192C), // Secondary color
          secondaryContainer:const Color(0xFF1E3E62), // Secondary container color
          surface: const Color.fromARGB(255, 33, 33, 33), // Surface color
          onPrimary: Colors.white, // Text color on primary color
          onSecondary: Colors.white, // Text color on secondary color
          onSurface: Colors.white, // Text color on surface
          error: Colors.red[700]!, // Error color
          onError: Colors.white, // Text color on error
        ),
        useMaterial3: true,
      ),
      home: const ListGrades(title: 'Grade Management System'),
    );
  }
}
