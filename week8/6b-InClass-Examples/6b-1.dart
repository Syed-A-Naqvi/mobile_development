import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';  // Import SQFlite for database functionality
import 'package:path/path.dart';        // Import Path to help with file paths

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQFlite Example',
      home: DatabaseDemo(),
    );
  }
}

class DatabaseDemo extends StatefulWidget {
  @override
  _DatabaseDemoState createState() => _DatabaseDemoState();
}

class _DatabaseDemoState extends State<DatabaseDemo> {
  late Database database; // Declaring the database variable

  @override
  void initState() {
    super.initState();
    _initDatabase(); // Initialize the database when the app starts
  }

  // Method to initialize and create the database
  Future<void> _initDatabase() async {
    // Getting the path to store the database file
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'mydatabase.db'); // Joining the path with the database name

    // Opening the database and creating the 'people' table if it doesn't exist
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // SQL query to create the 'people' table
        await db.execute("CREATE TABLE people(id INTEGER PRIMARY KEY, name TEXT)");
      },
    );
  }

  // Method to insert a person into the 'people' table
  Future<void> _insertPerson(String name) async {
    await database.insert(
      'people', // Table name
      {'name': name}, // Data to insert (map: columnName -> value)
    );
    setState(() {}); // Refresh the UI after insertion
  }

  // Method to retrieve all people from the database
  Future<List<Map<String, dynamic>>> _getPeople() async {
    return await database.query('people'); // Query the 'people' table
  }

  // Method to retrieve people from the database with certain conditions
  // Future<List<Map<String, dynamic>>> _getPeople() async {
  //   // Query the 'people' table with specific conditions
  //   return await database.query(
  //       'people',                      // Table name
  //       columns: ['id', 'name'],        // Columns to retrieve
  //       where: 'name LIKE ?',           // WHERE clause to match names starting with 'Person'
  //       whereArgs: ['Person%'],         // Arguments for the WHERE clause
  //       orderBy: 'id DESC',             // Order by 'id' in descending order
  //       limit: 5                        // Limit the results to 5 people
  //   );
  // }

  // Method to delete a person from the database using their ID
  Future<void> _deletePerson(int id) async {
    await database.delete(
      'people', // Table name
      where: 'id = ?', // WHERE clause
      whereArgs: [id], // Arguments for the WHERE clause
    );
    setState(() {}); // Refresh the UI after deletion
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SQFlite Example')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _getPeople(), // Fetching people from the database
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator(); // Show loading indicator while fetching data
          }

          // Display the list of people in the UI
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              var person = snapshot.data![index]; // Getting the current person from the list
              return ListTile(
                title: Text(person['name']), // Displaying the name
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _deletePerson(person['id']); // Deleting the person when delete icon is pressed
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _insertPerson('Person ${DateTime.now()}'); // Insert a new person with a timestamp as the name
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
