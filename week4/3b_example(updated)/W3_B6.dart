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
      body: GridView.count(
        // Disable scrolling for this GridView if inside another scrollable widget
        primary: false,
        padding: const EdgeInsets.all(20),
        // Spacing between the columns
        crossAxisSpacing: 5.0,
        // Spacing between the rows
        mainAxisSpacing: 5.0,
        // Number of columns in the grid
        crossAxisCount: 2,
        // List of widgets to display in the grid
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[100],
            child: const Text('Entry 1'),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[200],
            child: const Text('Entry 2'),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[300],
            child: const Text('Entry 3'),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[400],
            child: const Text('Entry 4'),
          ),
        ],
      ),
    

      //****
    );
  }
}
