import 'package:mp3_player/logic/objects/songs.dart';

class Album {
  List<Song> songs = [];
  late String albumArtPath;

  late String title;
  late String artist;

  late String genre;
  late int year;
  late int amountOfSongs;

  Album() {
    albumInitialiser();
  }

  albumInitialiser() async {}
}
