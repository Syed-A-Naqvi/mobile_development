import 'package:flutter/material.dart';
import 'main.dart';
import 'package:grades_database/grade_form.dart';

class ListGrades extends StatefulWidget{
  @override
  _ListGradeState createState() => _ListGradeState();
}

class _ListGradeState extends State<ListGrades> {

  int? _selectedIndex;
  List<Grade> grades = []; // Placeholder for grades

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Grades'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _editGrade,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _deleteGrade,
          )
        ],
      ),
      body: ListView.builder(
        itemCount: grades.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
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

  void _addGrade() {
    print("Add Grade");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GradeForm()),
    );
  }

  void _editGrade() {
    print("Edit Grade");
  }

  void _deleteGrade() {
    print("Delete Grade");
  }
}