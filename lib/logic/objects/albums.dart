import 'package:mp3_player/logic/objects/songs.dart';

class Album {
  List<Song> songs = [];
  late Object albumArt;

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

/*TODO: 
  when loading in albums, you will go folder by folder through the 'music' folder
  here, you can create an 'album' object. at this point, iterate through all of the songs adding them to the album object.
  this will all happen for the specific artist so you can get their name from the folder directory above. after you finish all the albums
  you will move to the next artist.

  you can do this at the start in order to collect in all data then use ListView builder thing that the medium website talked about in order to
  load everything in into a page (however u use that idk)
  HOWEVER, first test without using ListView as you need to just learn how to take data from a random .mp3 into the program
*/
