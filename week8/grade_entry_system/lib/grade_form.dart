import 'package:flutter/material.dart';
import 'package:grades_database/list_grades.dart';
import 'package:grades_database/main.dart';

class GradeForm extends StatefulWidget {
  @override
  _GradeFormState createState() => _GradeFormState();
}

class _GradeFormState extends State<GradeForm> {
  final TextEditingController _sidController = TextEditingController();
  final TextEditingController _gradeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Grade'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _sidController,
              decoration: const InputDecoration(labelText: 'Student ID'),
            ),
            TextField(
              controller: _gradeController,
              decoration: const InputDecoration(labelText: 'Grade'),
            ),
            const SizedBox(height: 20),
            FloatingActionButton(
              onPressed: _saveGrade,
              child: const Icon(Icons.save),
            ),
          ],
        ),
      ),
    );
  }

  void _saveGrade() {
    // Implement saving logic
    print("Save Grade: ${_sidController.text}, ${_gradeController.text}");
    Navigator.pop(context);
  }
}
