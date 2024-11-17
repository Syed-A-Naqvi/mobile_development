import 'package:sqflite/sqflite.dart';  // Import SQFlite for database functionality
import 'package:path/path.dart';        // Import Path to help with file paths
import 'grade.dart';

// Grade(sid: "100000000", grade: "A"),
//                         Grade(sid: "100000001", grade: "B"),
//                         Grade(sid: "100000002", grade: "C"),
//                         Grade(sid: "100000003", grade: "D"),
//                         Grade(sid: "100000004", grade: "E"),

class GradesModel {

  Database? _database;

  // Singleton instance
  static final GradesModel _instance = GradesModel._internal();
  factory GradesModel() => _instance;
  GradesModel._internal();

  // Async getter to initialize the database only when accessed
  Future<Database> get database async {
    if (_database == null) {
      var dbPath = await getDatabasesPath();
      String path = join(dbPath, 'grades.db');
      _database = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          await db.execute("CREATE TABLE grades(id INTEGER PRIMARY KEY, sid TEXT, grade TEXT)");
          // Insert initial values
          await db.insert('grades', {'sid': '100000000', 'grade': 'A'});
          await db.insert('grades', {'sid': '100000001', 'grade': 'B'});
          await db.insert('grades', {'sid': '100000002', 'grade': 'C'});
          await db.insert('grades', {'sid': '100000003', 'grade': 'D'});
          await db.insert('grades', {'sid': '100000004', 'grade': 'E'});
        },
      );
    }
    return _database!;
  }

  // Insert a new grade
  Future<int> insertGrade(Grade grade) async {
    final db = await database;
    return await db.insert(
      'grades',
      grade.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Update an existing grade
  Future<int> updateGrade(Grade grade) async {
    final db = await database;
    return await db.update(
      'grades',
      grade.toMap(),
      where: "id = ?",
      whereArgs: [grade.id],
    );
  }

  // Delete a grade by id
  Future<int> deleteGradeById(int id) async {
    final db = await database;
    return await db.delete(
      'grades',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Retrieve all grades from the database
  Future<List<Grade>> getAllGrades() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('grades');
    return List.generate(maps.length, (i) {
      return Grade.fromMap(maps[i]);
    });
  }
}