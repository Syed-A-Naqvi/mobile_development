import 'package:flutter/material.dart';
import 'grades_model.dart';
import 'grade.dart';
import 'grade_form.dart';

class ListGrades extends StatefulWidget {
  
  final String title;
  const ListGrades({super.key, required this.title});

  @override
  State<ListGrades> createState() => _ListGradesState();
}

class _ListGradesState extends State<ListGrades> {
  final GradesModel _gradesModel = GradesModel(); // Database access
  List<Grade> grades = []; // Holds the grades to render
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    _loadGrades(); // Load grades from the database when the page loads
  }

  void _loadGrades() async {
    grades = await _gradesModel.getAllGrades(); // Fetch grades from the database
    setState(() {}); // Update UI with the loaded grades
  }

  // Add a new grade by navigating to GradeForm
  void _addGrade() async {
    final newGrade = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GradeForm()),
    );

    if (newGrade != null && newGrade is Grade) {
      await _gradesModel.insertGrade(newGrade);
      _loadGrades(); // Reload grades after adding
    }
  }

  // Edit the selected grade by navigating to GradeForm with existing data
  void _editGrade() async {
    if (_selectedIndex != null && grades.isNotEmpty) {
      final editedGrade = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GradeForm(grade: grades[_selectedIndex!]),
        ),
      );

      if (editedGrade != null && editedGrade is Grade) {
        await _gradesModel.updateGrade(editedGrade);
        _loadGrades(); // Reload grades after editing
      }
    }
  }

  void _deleteGrade() async {
    if (_selectedIndex != null && grades.isNotEmpty) {
      await _gradesModel.deleteGradeById(grades[_selectedIndex!].id!);
      _loadGrades(); // Reload grades after deletion
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _editGrade,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _deleteGrade,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: grades.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = (_selectedIndex == index) ? null : index;
              });
            },
            child: Container(
              color: _selectedIndex == index ? Colors.blue : Colors.transparent,
              child: ListTile(
                title: Text(grades[index].sid),
                subtitle: Text(grades[index].grade),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addGrade,
        child: const Icon(Icons.add),
      ),
    );
  }
}
