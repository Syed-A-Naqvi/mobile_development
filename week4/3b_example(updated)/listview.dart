import 'package:flutter/material.dart';

// The main entry point of the app
void main() => runApp(MyApp());

// Root of the application
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // MaterialApp provides the basic structure and design (Material UI)
    return MaterialApp(
      title: 'ListView Example',  // Title of the app
      home: ListViewExample(),    // Home screen widget
    );
  }
}

// The ListViewExample widget is responsible for displaying the main screen
class ListViewExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scaffold provides the layout structure with an app bar and body
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView Example'),  // Title of the app bar
      ),
      // The body of the screen contains a ListView widget
      body: ListView(
        // List.generate creates 20 list items using a loop
        children: List.generate(
          20,  // Generate 20 items in the ListView 0 -19
              (index) => ListTile(
            leading: Icon(Icons.star),   // An icon on the left side of each item
            title: Text('Item $index'),  // The main title of each item (dynamic text)
            subtitle: Text('Subtitle for Item $index'),  // Subtitle for each item
            trailing: Icon(Icons.arrow_forward),  // Icon on the right side of each item
            // What happens when an item is tapped
            onTap: () {
              // When tapped, show a dialog with details about the tapped item
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  // AlertDialog shows a pop-up dialog when an item is clicked
                  return AlertDialog(
                    title: Text('Item $index Tapped'),  // Displays which item was tapped
                    actions: <Widget>[
                      // A button inside the dialog to close it
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();  // Close the dialog when pressed
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
