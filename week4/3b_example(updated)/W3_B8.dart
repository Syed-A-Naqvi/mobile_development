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
    // DefaultTabController manages the state of the TabBar and TabBarView
    return DefaultTabController(
      length: 2,  // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Tabbed App'),  // Title of the app bar
          bottom: TabBar(
            isScrollable: true,  // Allows the TabBar to scroll if there are many tabs
            tabs: <Tab>[
              Tab(text: 'Tab 1', icon: Icon(Icons.add)),  // First tab with text and icon
              Tab(text: 'Tab 2', icon: Icon(Icons.remove)),  // Second tab with text and icon
            ],
          ),
        ),
        // TabBarView displays the content corresponding to the selected tab
        body: TabBarView(
          children: <Widget>[
            Center(child: Text('Content 1')),  // Content for Tab 1
            Center(child: Text('Content 2')),  // Content for Tab 2
          ],
        ),
      ),
    );
  }
}
