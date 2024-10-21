import 'package:flutter/material.dart';

// Entry point of the app.
void main() => runApp(MyApp());

// Root of the application. It returns the MaterialApp widget, which provides basic structure and design for the app.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Container Layout',  // Title of the app
      home: ContainerLayout(),    // The home screen widget to display
    );
  }
}

// This widget defines the layout structure using various containers within rows and columns.
class ContainerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold provides the basic layout structure for the screen, including the app bar and the body.
      appBar: AppBar(
        title: Text('Container Layout'),  // AppBar title
      ),
      // Body contains a Center widget that centers a column of widgets vertically.
      body: Center(
        // Column widget arranges its children vertically.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centers column's children vertically
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround, // Space out the containers horizontally
              crossAxisAlignment: CrossAxisAlignment.center,     // Align containers to the center vertically
              children: <Widget>[
                // Red container with width 100 and height 100
                Container(
                  width: 100.0,
                  height: 100.0,
                  color: Colors.red,
                ),
                // Green container with width 150 and height 150
                Container(
                  width: 150.0,
                  height: 150.0,
                  color: Colors.green,
                ),
              ],
            ),
            SizedBox(height: 20.0),  // Adds spacing between the rows

            // Second row of containers
            Row(
              mainAxisAlignment: MainAxisAlignment.center,  // Centers the row's children horizontally
              children: <Widget>[
                // Blue container with width 80 and height 80
                Container(
                  width: 80.0,
                  height: 80.0,
                  color: Colors.blue,
                ),
                SizedBox(width: 20.0),  // Adds horizontal spacing between containers
                // Orange container with width 120 and height 120
                Container(
                  width: 120.0,
                  height: 120.0,
                  color: Colors.orange,
                ),
                SizedBox(width: 20.0),  // Adds more horizontal spacing
                // Purple container with width 60 and height 60
                Container(
                  width: 60.0,
                  height: 60.0,
                  color: Colors.purple,
                ),
              ],
            ),
            SizedBox(height: 20.0),  // Adds spacing between the second row and the bottom container

            // Single yellow container at the bottom
            Container(
              width: 200.0,  // Width of the container
              height: 100.0,  // Height of the container
              color: Colors.yellow,  // Background color of the container
            ),
          ],
        ),
      ),
    );
  }
}
