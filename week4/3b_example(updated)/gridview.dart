import 'package:flutter/material.dart';

// The main entry point of the Flutter app
void main() {
  runApp(MyApp()); // Runs the MyApp widget as the root of the application
}

// Root of the application
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // MaterialApp provides the basic structure and design (Material UI) for the app
    return MaterialApp(
      title: 'GridView Example',  // Title of the app
      home: GridViewExample(),    // Defines the home screen widget
    );
  }
}

// This widget displays the main screen with the grid layout
class GridViewExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scaffold provides the layout structure with an app bar and a body
    return Scaffold(
      appBar: AppBar(
        title: Text('GridView Example'),  // Title displayed in the app bar
      ),
      // Padding wraps around the GridView to add padding on the sides
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),  // Adds horizontal padding
        // GridView.builder creates a grid with a dynamically generated number of items
        child: GridView.builder(
          // SliverGridDelegateWithFixedCrossAxisCount defines the grid's layout (fixed number of columns)
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,       // Number of columns in the grid (4 columns)
            crossAxisSpacing: 16.0,  // Horizontal spacing between grid items
            mainAxisSpacing: 16.0,   // Vertical spacing between grid items
          ),
          itemCount: 50,  // Number of items in the grid (50 items)
          // itemBuilder generates the content for each grid item based on its index
          itemBuilder: (BuildContext context, int index) {
            // Choose a color from Colors.primaries based on the index
            final color = Colors.primaries[index % Colors.primaries.length];

            // Each grid item is represented by a container with a background color and centered text
            return Container(
              color: color,  // The background color of each grid item
              child: Center(
                child: Text(
                  'Item $index',  // The label of each grid item
                  style: TextStyle(color: Colors.white),  // Text style (white color)
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
