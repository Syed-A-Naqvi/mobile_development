import 'package:flutter/material.dart';
import 'grade.dart';

class GradeForm extends StatefulWidget {
  final Grade? grade; // Optional grade parameter for editing

  const GradeForm({super.key, this.grade});

  @override
  State<GradeForm> createState() => _GradeFormState();
}

class _GradeFormState extends State<GradeForm> {
  final _sidController = TextEditingController();
  final _gradeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.grade != null) {
      // Populate the controllers with existing data if editing
      _sidController.text = widget.grade!.sid;
      _gradeController.text = widget.grade!.grade;
    }
  }

  @override
  void dispose() {
    _sidController.dispose();
    _gradeController.dispose();
    super.dispose();
  }

  void _saveGrade() {
    // Create a Grade object with the entered data
    final sid = _sidController.text;
    final grade = _gradeController.text;
    if (sid.isNotEmpty && grade.isNotEmpty) {
      Navigator.pop(context, Grade(sid: sid, grade: grade, id: widget.grade?.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(widget.grade == null ? 'Add Grade' : 'Edit Grade'),
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
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.primary),
              ),
              onPressed: _saveGrade,
              child: Text(
                'Save',
                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
