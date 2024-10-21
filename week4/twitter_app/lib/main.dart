import 'package:flutter/material.dart';
import 'tweet_widget.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Twitter Application',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          dynamicSchemeVariant: DynamicSchemeVariant.content),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Lab 03 and 04 extension'),
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

  List<TweetWidget> feed = [];

    // Function to move a tweet to the first position
  void moveTweetToTop(TweetWidget tweet) {
    setState(() {
    feed.remove(tweet);  // Remove the tweet
    feed.insert(0, tweet);  // Insert it at the first position
    });
  }

  @override
  void initState() {
    super.initState();
    feed = [
      TweetWidget(
        "Fish",
        "killawalle",
        "Killer whales, also known as orcas, are apex predators. They have no natural predators and can take down whales far bigger than themselves.",
        "https://cdn.pixabay.com/photo/2023/06/18/21/46/killer-whale-8072814_1280.jpg",
        120,
        45,
        300,
        moveTweetToTop,
      ),
      TweetWidget(
        "Bijli",
        "reactamon",
        "Scientists have made a significant breakthrough in fusion reaction, bringing us closer to a clean and virtually limitless energy source!",
        "https://cdn.pixabay.com/photo/2020/04/01/01/02/science-4989678_1280.png",
        500,
        150,
        1200,
        moveTweetToTop,
      ),
      TweetWidget(
        "Mirigh",
        "starscream",
        "The mission to Mars is well underway, with new discoveries on the surface hinting at the potential for ancient life.",
        "https://cdn.pixabay.com/photo/2023/03/07/04/02/leadership-7834932_1280.jpg",
        800,
        300,
        2500,
        moveTweetToTop,
      ),
    ];
  }


  @override
  Widget build(BuildContext context) {
    
    double maxWidth = MediaQuery.of(context).size.width * 0.85;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),),
        toolbarHeight: 50,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Column(
              children: feed,
            ),
          ),
        ),
      ),
    );
  }

}