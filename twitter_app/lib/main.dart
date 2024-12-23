import 'package:flutter/material.dart';
import 'package:twitter_app/create_tweet_page.dart';
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
  Map<String, Function(TweetWidget)> tweetFunctions = {};

  // Function to create a new reply tweet right below current tweet
  void addReply(TweetWidget oldTweet, TweetWidget newTweet){
    setState(() {
      feed.insert(feed.indexOf(oldTweet)+1, newTweet);
    });
  }

  // Function to create new tweet
  void createTweet(TweetWidget tweet){
    setState(() {
      feed.insert(0, tweet);
    });
  }

  // Function to move a tweet to the first position
  void moveTweetToTop(TweetWidget tweet) {
    setState(() {
    feed.remove(tweet);  // Remove the tweet
    feed.insert(0, tweet);  // Insert it at the first position
    });
  }
  // Function to hide the tweet (basically delete the tweet from the feed)
  void hideTweet(TweetWidget tweet) {
    setState(() {
      feed.remove(tweet);
    });
  }

  @override
  void initState() {
    super.initState();
    tweetFunctions = {
      'moveTweetToTop' : moveTweetToTop,
      'hideTweet' : hideTweet,
      'createTweet' : createTweet,
    };
    feed = [
      TweetWidget(
        "Fish",
        "killawalle",
        "Killer whales, also known as orcas, are apex predators. They have no natural predators and can take down whales far bigger than themselves.",
        "https://cdn.pixabay.com/photo/2023/06/18/21/46/killer-whale-8072814_1280.jpg",
        tweetFunctions,
        addReply,
        numComments:  120,
        numRetweets:  45,
        numLikes:  300,
        key: UniqueKey(),
      ),
      TweetWidget(
        "Bijli",
        "reactamon",
        "Scientists have made a significant breakthrough in fusion reaction, bringing us closer to a clean and virtually limitless energy source!",
        "https://cdn.pixabay.com/photo/2020/04/01/01/02/science-4989678_1280.png",
        tweetFunctions,
        addReply,
        numComments:  500,
        numRetweets:  150,
        numLikes:  1200,
        key: UniqueKey(),
      ),
      TweetWidget(
        "Mirigh",
        "starscream",
        "The mission to Mars is well underway, with new discoveries on the surface hinting at the potential for ancient life.",
        "https://cdn.pixabay.com/photo/2023/03/07/04/02/leadership-7834932_1280.jpg",
        tweetFunctions,
        addReply,
        numComments:  800,
        numRetweets:  300,
        numLikes:  2500,
        key: UniqueKey(),
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0), // Add padding to the right
            child: IconButton(
              icon: const Icon(Icons.add),
              color: Theme.of(context).colorScheme.onPrimary,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateTweetPage(
                      tweetFunctions,
                      addReply,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
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