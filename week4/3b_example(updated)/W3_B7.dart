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
      body: CustomScrollView(
        slivers: <Widget>[
          // A simple SliverAppBar that acts as a scrollable header.
          SliverAppBar(
            title: Text('SliverAppBar'),
            floating: true, // Allows the AppBar to float when scrolling
            expandedHeight: 100, // Expanded height when fully visible
          ),

          // A simple SliverList using a static list of items.
          SliverList(
            delegate: SliverChildListDelegate([
              ListTile(
                leading: Icon(Icons.map),
                title: Text('Map'),
              ),
              ListTile(
                leading: Icon(Icons.photo_album),
                title: Text('Album'),
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text('Phone'),
              ),
            ]),
          ),

          // A simple SliverGrid with fixed-size grid items.
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,  // Number of columns
            ),
            delegate: SliverChildListDelegate([
              Container(color: Colors.red, height: 150),
              Container(color: Colors.green, height: 150),
              Container(color: Colors.blue, height: 150),
              Container(color: Colors.yellow, height: 150),
            ]),
          ),
        ],
      ),

      //****
    );
  }
}
