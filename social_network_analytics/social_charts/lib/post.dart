import 'package:english_words/english_words.dart';
import 'dart:math';

class Post {
  final String title;
  final int numUpVotes;
  final int numDownVotes;
  static final Random _random = Random();

  Post({
    required this.title,
    required this.numUpVotes,
    required this.numDownVotes,
  });


  static Post _generatePost() {

    final String randomTitle = List<String>.generate(_random.nextInt(10)+1, (i) => WordPair.random().first).join(' ');
    final int randomUpVotes = _random.nextInt(100);
    final int randomDownVotes = _random.nextInt(100);

    return Post(
      title: randomTitle,
      numUpVotes: randomUpVotes,
      numDownVotes: randomDownVotes,
    );
  }

  static List<Post> generateData() {
    return List<Post>.generate(_random.nextInt(5)+5, (index) => _generatePost());
  }
}