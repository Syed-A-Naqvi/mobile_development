import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    //**** [Ali] Top Widget - your application - home page - grid structure
    return Scaffold(
      //****[Ali] appBar : top section
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary, //colors.red,
        title: Text(widget.title),
      ),
      //****[Ali] body : you can add your widget here - Similar to calling functions
      body: ListViewExample(),
      //****
    );
  }
}

class ListViewExample extends StatelessWidget {
  // List of colors to be used for the containers
  final List<Color> colours = [Colors.red, Colors.green, Colors.blue];
  // List of texts to be displayed inside the containers
  final List<String> texts = ['Item 1', 'Item 2', 'Item 3'];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      // Adds padding around the ListView
      padding: const EdgeInsets.all(8.0),
      // Number of items in the list
      itemCount: 3,
      // This function builds each item in the list
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50, // Each container has a fixed height of 50
          color: colours[index], // The color of the container comes from the `colours` list
          child: Center(
            // The text inside the container is centered
            child: Text(
              texts[index], // Text comes from the `texts` list
              style: TextStyle(color: Colors.white), // Text color is white for visibility
            ),
          ),
        );
      },
      // Builds a separator (a Divider) between each item
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
