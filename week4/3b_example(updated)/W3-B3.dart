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
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              children: [
                Text('Column Example (No Scrolling)'),
                Container(
                  color: Colors.green,
                  height: 200,
                  width: double.infinity,
                ),
                Container(
                  color: Colors.blue,
                  height: 200,
                  width: double.infinity,
                ),
                Container(
                  color: Colors.red,
                  height: 200,
                  width: double.infinity,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Text('ListView Example (With Scrolling)'),
                Container(
                  color: Colors.green,
                  height: 200,
                  width: double.infinity,
                ),
                Container(
                  color: Colors.blue,
                  height: 200,
                  width: double.infinity,
                ),
                Container(
                  color: Colors.red,
                  height: 200,
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ],
      ),
    );

  }
}
