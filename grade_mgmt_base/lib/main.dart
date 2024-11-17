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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey[900]!),
        useMaterial3: true,
      ),
      home: const ListGrades(title: 'Grade Management System'),
    );
  }
}
