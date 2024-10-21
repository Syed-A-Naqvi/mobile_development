import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Snackbar Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Create a SnackBar with content and an action
            final snackbar = SnackBar(
              content: Text('Event Deleted'),
              action: SnackBarAction(
                label: 'Undo',
                onPressed: () {
                  // Undo the action when the user taps 'Undo'
                  print('Undo action');
                },
              ),
            );
            // Show the SnackBar
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          },
          child: Text('Show Snackbar'),
        ),
      ),
    );
  }
}
