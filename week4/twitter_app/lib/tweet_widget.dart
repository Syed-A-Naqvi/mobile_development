import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:twitter_app/create_tweet_page.dart';

class TweetWidget extends StatelessWidget {
  
  final String userShortName;
  final String userLongName;
  final String timeStamp;
  final String description;
  final String imageURL;
  final int numComments;
  final int numRetweets;
  final int numLikes;
  final Map<String,Function(TweetWidget)> tweetFunctions;
  final Function(TweetWidget, TweetWidget) addReply;
  
  TweetWidget(
    this.userShortName,
    this.userLongName,
    this.description,
    this.imageURL,
    this.tweetFunctions,
    this.addReply, {
    this.numComments=0,
    this.numRetweets=0,
    this.numLikes=0,
    super.key,
  }) : timeStamp = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  // Method to generate a random color
  Color _getRandomColor() {
    final Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  Widget _buildUserRow() {

    return Row(
      children: [
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black),
              children: [
                TextSpan(text: userShortName, style: const TextStyle(fontWeight: FontWeight.bold)),
                const TextSpan(text: " "),
                TextSpan(text: "@$userLongName", style: const TextStyle(color: Colors.grey)),
                const TextSpan(text: " · "),
                TextSpan(text: timeStamp, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ),
        PopupMenuButton<String>(
          onSelected: (String result) {
            // Handle menu item selection
            tweetFunctions['hideTweet']!(this);
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'Option 1',
              child: Text('Hide Tweet'),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar Column
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              CircleAvatar(
                backgroundColor: _getRandomColor(),
                child: Text(userShortName[0].toUpperCase()),
              ),
            ],
          ),
          const SizedBox(width: 5),

          // Tweet Content Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildUserRow(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 15),
                  child: Text(description),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageURL,
                    width: double.infinity,
                    height: 400,             
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
                  ),
                ),
                ActionsRow(initialComments: numComments,
                  initialLikes: numLikes,
                  initialRetweets: numRetweets,
                  parentTweet: this,
                  tweetFunctions: tweetFunctions,
                  addReply: addReply,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ActionsRow extends StatefulWidget {
  
  final int initialComments;
  final int initialRetweets;
  final int initialLikes;
  final TweetWidget parentTweet;
  final Map<String,Function(TweetWidget)> tweetFunctions;
  final Function(TweetWidget, TweetWidget) addReply;

  const ActionsRow({
    super.key,
    this.initialComments = 0,
    this.initialRetweets = 0,
    this.initialLikes = 0,
    required this.parentTweet,
    required this.tweetFunctions,
    required this.addReply,
  });

  @override
  ActionsRowState createState() => ActionsRowState();
}

class ActionsRowState extends State<ActionsRow> {

  late int commentsCount;
  late int retweetsCount;
  late int likesCount;
  late TweetWidget parentTweet;
  late Map<String,Function(TweetWidget)> tweetFunctions;
  late Function(TweetWidget, TweetWidget) addReply;
  late bool liked;
  late bool retweeted;
  late bool bookmarked;

  @override
  void initState() {
    super.initState();
    // Initialize counts from passed values
    commentsCount = widget.initialComments;
    retweetsCount = widget.initialRetweets;
    likesCount = widget.initialLikes;
    parentTweet = widget.parentTweet;
    tweetFunctions = widget.tweetFunctions;
    addReply = widget.addReply;
    // Initialize boolean states
    liked = false;
    retweeted = false;
    bookmarked = false;
  }

  Widget _buildActionButton({
    required IconData icon,
    int? count,
    required VoidCallback onPressed,
  }) {
    return Row(
      children: [
        IconButton(
          icon: Icon(icon),
          onPressed: onPressed,
        ),
        if (count != null) Text("$count"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Comments Button
        _buildActionButton(
          icon: Icons.chat_outlined,
          count: commentsCount,
          onPressed: () {
            setState(() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateTweetPage(
                      tweetFunctions,
                      addReply,
                      parentTweet: parentTweet,
                    ),
                  ),
                ).then( (result) {
                  if (result == true){
                    setState(() {
                      commentsCount++;
                    });
                  }
                });
            });
          }
        ),
        _buildActionButton(
          icon: retweeted ? Icons.repeat_on_rounded : Icons.repeat,
          count: retweetsCount,
          onPressed: () {
            setState(() {
              retweeted = !retweeted;
              retweeted ? retweetsCount++ : retweetsCount--; 
            });
          }
        ),
        _buildActionButton(
          icon: liked ? Icons.favorite : Icons.favorite_border,
          count: likesCount,
          onPressed: () {
            setState(() {
              liked = !liked;
              liked ? likesCount++ : likesCount--; 
            });
          }
        ),
        _buildActionButton(
          icon: bookmarked ? Icons.bookmark : Icons.bookmark_border,
          onPressed: () {            
            setState(() {
              bookmarked = !bookmarked;
              bookmarked ? tweetFunctions['moveTweetToTop']!(parentTweet) : null;
            });
          }
        )
      ],
    );
  }
}