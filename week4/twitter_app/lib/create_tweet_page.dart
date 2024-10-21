import 'package:flutter/material.dart';
import 'package:twitter_app/tweet_widget.dart';

class CreateTweetPage extends StatelessWidget {
  
  final TweetWidget? parentTweet;
  final Map<String,Function(TweetWidget)> tweetFunctions;
  final Function(TweetWidget,TweetWidget) addReply;
  final TextEditingController shortNameController = TextEditingController();
  final TextEditingController longNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageURLController = TextEditingController();
  
  CreateTweetPage(this.tweetFunctions, this.addReply, {this.parentTweet, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (parentTweet == null) ? const Text('Create New Tweet') : const Text('Add Reply'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: shortNameController, // Assign controller
              decoration: const InputDecoration(
                labelText: 'User Short Name',
              ),
            ),
            TextField(
              controller: longNameController, // Assign controller
              decoration: const InputDecoration(
                labelText: 'User Long Name',
              ),
            ),
            TextField(
              controller: descriptionController, // Assign controller
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),
            TextField(
              controller: imageURLController, // Assign controller
              decoration: const InputDecoration(
                labelText: 'Image URL (optional)',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Retrieve values from the controllers
                String userShortName = shortNameController.text;
                String userLongName = longNameController.text;
                String description = descriptionController.text;
                String imageURL = imageURLController.text;

                // Handle tweet creation logic here
                TweetWidget newTweet = TweetWidget(
                  userShortName,
                  userLongName,
                  description, 
                  imageURL, 
                  tweetFunctions,
                  addReply,
                  key: UniqueKey(),
                );
                // handling adding the new tweet to the list in the parent widget
                if(parentTweet != null){
                  addReply(parentTweet!, newTweet);
                }
                else{
                  tweetFunctions['createTweet']!(newTweet);
                }
                Navigator.pop(context, true);
              },
              child: (parentTweet == null) ? const Text('Create Tweet') : const Text('Add Reply'),
            ),
          ],
        ),
      ),
    );
  }
}
