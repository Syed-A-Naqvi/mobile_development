import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';  // Import SQFlite for database functionality
import 'package:path/path.dart';        // Import Path to help with file paths

// Model class to represent a Person with an id and name
class Person {
  Person({this.id, this.name});

  int? id;
  String? name;

  // Converts a Map object to a Person instance
  Person.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];    // Assign 'id' from map to the 'id' field
    this.name = map['name'];  // Assign 'name' from map to the 'name' field
  }

  // Converts the Person instance into a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': this.id,       // Returns a map with 'id'
      'name': this.name,   // Returns a map with 'name'
    };
  }
}

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

  // Method to insert a Person object into the 'people' table
  Future<void> _insertPerson(Person person) async {
    await database.insert(
      'people',  // Table name
      person.toMap(),  // Converts the Person object to a Map
      conflictAlgorithm: ConflictAlgorithm.replace,  // Replace existing data if a conflict arises
    );
    setState(() {}); // Refresh the UI after insertion
  }

  // Method to update a Person object in the 'people' table
  Future<void> _updatePerson(Person person) async {
    await database.update(
      'people',  // Table name
      person.toMap(),  // Converts the Person object to a Map
      where: "id = ?",  // Which row to update
      whereArgs: [person.id],  // Argument for WHERE clause
    );
    setState(() {});  // Refresh the UI after update
  }

  // Method to delete a person from the database using their ID
  Future<void> _deletePerson(int id) async {
    await database.delete(
      'people', // Table name
      where: 'id = ?', // WHERE clause
      whereArgs: [id], // Arguments for the WHERE clause
    );
    setState(() {}); // Refresh the UI after deletion
  }

  // Method to read rows from the 'people' table
  Future<List<Person>> _getPeople() async {
    // Query the 'people' table and get the result as a list of maps
    final List<Map<String, dynamic>> maps = await database.query('people');

    // Create a list of Person objects from the list of maps
    List<Person> people = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        people.add(Person.fromMap(maps[i]));
      }
    }

    return people; // Return the list of Person objects
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SQFlite Example')),
      body: FutureBuilder<List<Person>>(
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
                title: Text(person.name!), // Displaying the name
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        var updatedPerson = Person(id: person.id, name: 'Updated Person ${DateTime.now()}');
                        _updatePerson(updatedPerson); // Updating the person
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _deletePerson(person.id!); // Deleting the person when delete icon is pressed
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var newPerson = Person(name: 'Person ${DateTime.now()}'); // Create a new person with a timestamped name
          _insertPerson(newPerson);  // Insert the new person into the database
        },
        child: Icon(Icons.add), // Icon for the FloatingActionButton
      ),
    );
  }
}
