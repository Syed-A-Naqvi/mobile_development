
import 'package:cloud_firestore/cloud_firestore.dart';
import 'grade.dart';


class GradesModel {

  // Firestore instance pointing to the "grades" collection
  final CollectionReference _gradesCollection = FirebaseFirestore.instance.collection('grades');
  // Singleton instance
  static final GradesModel _instance = GradesModel._internal();
  factory GradesModel() => _instance;
  GradesModel._internal();

  // Initialize the Firestore collection reference instead of SQLite database
  Future<CollectionReference> get _database async {
    return _gradesCollection;
  }

  // Insert a new grade
  Future<int> insertGrade(Grade grade) async {
    CollectionReference db = await _database;

    try {
      await db.add(grade.toMap());
      return 1; // Return 1 as a success indicator (similar to row ID in SQLite)
    } catch (e) {
      return 0; // Return 0 on failure
    }
  }

  // Update an existing grade
  Future<int> updateGrade(Grade grade) async {
    CollectionReference db = await _database;

    try {
      await db.doc(grade.id).update(grade.toMap());
      return 1; // Return 1 as a success indicator
    } catch (e) {
      return 0; // Return 0 on failure
    }
  }

  // Delete a grade by id
  Future<int> deleteGradeById(String id) async {
    CollectionReference db = await _database;

    try {
      await db.doc(id).delete();
      return 1; // Return 1 as a success indicator
    } catch (e) {
      return 0; // Return 0 on failure
    }
  }
  // Retrieve all grades from the database
  Future<List<Grade>> getAllGrades({QuerySnapshot? latest}) async {
    CollectionReference db = await _database;

    try {
      QuerySnapshot snapshot = latest ?? await db.get();
      return snapshot.docs.map((doc) {
        // Map each document to a Grade instance
        return Grade.fromMap(doc.data() as Map<String, dynamic>)..id = doc.id;
      }).toList();
    } catch (e) {
      return []; // Return empty list on failure
    }
  }

  // Listen for real-time updates
  void listenForChanges(Function(List<Grade>) onChange) async {
    CollectionReference db = await _database;
    
    db.snapshots().listen((snapshot) async {
      List<Grade> grades = await getAllGrades(latest: snapshot);
      onChange(grades);
    });
  }

}