void main() {
  Map<String,double> grades = {
    '100000001': 46.0,
    '100000002': 71.5,
    '100000003': 62.0,
  };
  grades['100000001'] = 50.0;  // replace
  grades['100000004'] = 100.0; // new key
  print(grades['100000001']);  // 50.0

  //<Map<String,dynamic>
  //List<<Map<String,dynamic>>


/*
   * Task: Analyze Music Track Data
Create a Dart program that simulates a list of music tracks,
each with attributes such as title, artist, duration, and
rating. The program should perform various data analysis
tasks on the music tracks, demonstrating the use of different
list methods and a mix of inline and non-inline functions.
   *
   * */

  print("***************************");
  print("***************************");
  print("***************************");

  List<Map<String,dynamic>> musicTracks = [
    {'title': 'Blue', 'artist': 'Eiffel 65', 'duration': 231, 'rating': 4.2},
    {'title': 'Levitating', 'artist': 'Dua Lipa', 'duration': 210, 'rating': 4.8},
    {'title': 'Vroom Vroom', 'artist': 'Charli XCX', 'duration': 193, 'rating': 4.7},
    {'title': 'Kings & Queens', 'artist': 'Ava Max', 'duration': 234, 'rating': 4.5},
    {'title': 'Sweet but Psycho', 'artist': 'Ava Max', 'duration': 206, 'rating': 4.6},
    {'title': 'Montero (Call Me By Your Name)', 'artist': 'Lil Nas X', 'duration': 223, 'rating': 4.6},
    {'title': 'New Rules', 'artist': 'Dua Lipa', 'duration': 200, 'rating': 4.4},
    {'title': 'Watermelon Sugar', 'artist': 'Harry Styles', 'duration': 174, 'rating': 4.6},
    {'title': 'Good 4 U', 'artist': 'Olivia Rodrigo', 'duration': 215, 'rating': 4.5},
    {'title': 'Levitating (Remix)', 'artist': 'Dua Lipa & DaBaby', 'duration': 203, 'rating': 4.7},
    {'title': 'Blinding Lights', 'artist': 'The Weeknd', 'duration': 200, 'rating': 4.8},
  ];

  //defining a function
  double calculateAverageDuration(List<Map<String,dynamic>> songs){
    if (songs.isEmpty) return 0.0;

    var totalDuration = songs.map((s) => s['duration']).reduce( (a,b) => a+b);

    return totalDuration/songs.length;

  }

  print(calculateAverageDuration(musicTracks));

  Map<String,dynamic> findHighestRatedTrack(List<Map<String,dynamic>> songs){
    if (songs.isEmpty) {
      return {};
    }

    return songs.reduce(

            (a,b) => a['rating'] > b['rating'] ? a : b

    );

  }

  print(findHighestRatedTrack(musicTracks));

  void sortTracksByDuration(List<Map<String,dynamic>> songs){
    songs.sort(

            (a,b) => a['duration'].compareTo(b['duration'])

    );
  }

  sortTracksByDuration(musicTracks);

  musicTracks.forEach((track) => print(track['title']));

}