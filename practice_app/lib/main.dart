import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

// Scaffold(
//         appBar: AppBar(title: const Text("WordPair Generator"),),
//         body: Center(
//           child: Text(wordPair.asPascalCase,
//             style: const TextStyle(
//             color: Color.fromARGB(255, 255, 255, 255),
//             fontWeight: FontWeight.bold),
//           )
//         )
//       )

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    final wordPair = WordPair.random();

    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.amber[600]),
        scaffoldBackgroundColor: const Color.fromARGB(255, 41, 41, 41)),
      home: RandomWords());
  }
}

class RandomWords extends StatefulWidget {
  
  @override
  State<RandomWords> createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  

}