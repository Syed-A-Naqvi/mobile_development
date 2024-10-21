import 'package:flutter/material.dart';

// The main entry point of the app
void main() => runApp(MyApp());

// Root of the application that returns the MaterialApp
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // MaterialApp provides the basic structure of the app with Material Design
    return MaterialApp(
      title: 'Padding, Align, and Expanded Example',  // Title of the app
      home: PaddingAlignExpandedExample(),  // The home screen widget to be displayed
    );
  }
}

// The main widget that demonstrates examples of Padding, Align, and Expanded
class PaddingAlignExpandedExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scaffold provides the basic structure for the app, including the app bar and body
    return Scaffold(
      appBar: AppBar(
        title: Text('Padding, Align, and Expanded Example'),  // Title displayed in the AppBar
      ),
      // Body of the screen that uses a Column to vertically arrange widgets
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,  // Center the content vertically
        children: <Widget>[

          // Example 1: Padding
          Padding(
            // Adds padding of 150 pixels around all sides of the container
            padding: EdgeInsets.all(150.0),
            child: Container(
              color: Colors.red,  // Background color of the container
              width: 100.0,  // Width of the container
              height: 50.0,  // Height of the container
              // Centers the text inside the container
              child: Center(
                child: Text('Padding'),  // Text displayed in the center
              ),
            ),
          ),

          // SizedBox adds vertical spacing of 20 pixels between the Padding and Align examples
          SizedBox(height: 20.0),

          // Example 2: Align
          Align(
            // Align the container to the bottom-right of its parent (the column)
            alignment: Alignment.bottomRight,
            child: Container(
              color: Colors.green,  // Background color of the container
              width: 100.0,  // Width of the container
              height: 50.0,  // Height of the container
              child: Center(
                child: Text('Align'),  // Text displayed in the center
              ),
            ),
          ),

          // Adds vertical spacing between the Align and Expanded examples
          SizedBox(height: 20.0),

          // Example 3: Expanded inside a Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,  // Center the row horizontally
            children: <Widget>[
              // First Expanded widget (2/3 of the width of the row)
              Expanded(
                flex: 2,  // This widget will take 2/3 of the available width
                child: Container(
                  color: Colors.blue,  // Background color
                  height: 50.0,  // Fixed height of the container
                  child: Center(
                    child: Text('Expanded (2/3)'),  // Centered text
                  ),
                ),
              ),

              // Adds horizontal spacing between the two Expanded widgets
              SizedBox(width: 20.0),

              // Second Expanded widget (1/3 of the width of the row)
              Expanded(
                flex: 1,  // This widget will take 1/3 of the available width
                child: Container(
                  color: Colors.orange,  // Background color
                  height: 150.0,  // Fixed height of the container
                  child: Center(
                    child: Text('Expanded (1/3)'),  // Centered text
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
