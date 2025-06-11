import 'package:mp3_player/logic/objects/songs.dart';
import 'package:mp3_player/data/globals.dart';

class Album {
  List<Song> songs = [];
  late Object albumArt;

  late String title;
  late String artist;
  late String album;

  late String genre;
  late int year;

  Album() {
    albumInitialiser();
  }

  albumInitialiser() async {}
}
