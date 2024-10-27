import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';  // Import SQFlite for database functionality
import 'package:path/path.dart';        // Import Path to help with file paths

// Model class to represent a User with an id, username, and password
class User {
  int? id;
  String? username;
  String? password;

  User({this.id, this.username, this.password});

  // Converts a Map object to a User instance // [1]
  User.fromMap(Map<String, dynamic> map) {

  }

  // Converts the User instance into a Map object //[2]
  Map<String, dynamic> toMap() {
    return {

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
      title: 'User Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserDatabaseDemo(),
    );
  }
}

class UserDatabaseDemo extends StatefulWidget {
  @override
  _UserDatabaseDemoState createState() => _UserDatabaseDemoState();
}

class _UserDatabaseDemoState extends State<UserDatabaseDemo> {
  late Database database;

  @override
  void initState() {
    super.initState();
    _initDatabase(); // Initialize the database when the app starts
  }

  // Method to initialize and create the database ---- [3] //'userdatabase.db'
  Future<void> _initDatabase() async {

  }

  // Method to insert a User object into the 'users' table [4]
  Future<void> _insertUser(User user) async {

  }

  // Method to update a User object in the 'users' table [5]
  Future<void> _updateUser(User user) async {
    await database.update(

    );
    setState(() {});  // Refresh the UI after update
  }

  // Method to delete a user from the 'users' table using their ID [6]
  Future<void> _deleteUser(int id) async {

  }

  // Method to read rows from the 'users' table [7]
  Future<List<User>> _getUsers() async {

  }

  // Controllers for the TextFields
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Management')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(labelText: 'Username'),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,  // Hide password
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    var newUser = User(
                        username: _usernameController.text,
                        password: _passwordController.text
                    );  // Create a new user
                    _insertUser(newUser);  // Insert the new user into the database
                    _usernameController.clear();  // Clear input fields
                    _passwordController.clear();
                  },
                  child: Text('Add User'),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<User>>(
              future: _getUsers(),  // Fetching users from the database
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());  // Show loading indicator while fetching data
                }

                if (snapshot.data!.isEmpty) {
                  return Center(child: Text('No users found'));  // Display message if no users are found
                }

                // Display the list of users in the UI
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    var user = snapshot.data![index];  // Getting the current user from the list
                    return ListTile(
                      title: Text(user.username!),  // Displaying the username
                      subtitle: Text(user.password!),  // Displaying the password
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              var updatedUser = User(id: user.id, username: 'Updated User', password: 'Updated Password');
                              _updateUser(updatedUser);  // Updating the user
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              _deleteUser(user.id!);  // Deleting the user when delete icon is pressed
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
