import 'package:flutter/material.dart';
import 'post_data.dart';
import 'post.dart';
import 'post_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: const MyHomePage(title: 'Social Charts'),
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

  late List<Post> _data;

  @override
  void initState(){
    super.initState();
    _data = Post.generateData();
  }

  void _refreshData() {
    debugPrint("new random List<Post> assigned to this._data and passed to the PostData Widget, page refreshed.");
    this._data = Post.generateData();
    setState(() {});
  }

  void _showChart() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8, // Restrict dialog height
              maxWidth: MediaQuery.of(context).size.width * 0.9,  // Restrict dialog width
            ),
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Enable horizontal scrolling
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical, // Enable vertical scrolling
                child: PostChart(data: this._data),
              ),
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: this._refreshData,
            icon: const Icon(Icons.refresh_rounded)
          ),
          IconButton(
            onPressed: _showChart,
            icon: const Icon(Icons.bar_chart_rounded)
          ),
          const SizedBox(width: 20,),
        ],
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(widget.title),
      ),
      body: PostData(data: this._data,),
    );
  }
}
