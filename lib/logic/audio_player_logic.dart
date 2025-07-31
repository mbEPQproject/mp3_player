import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'objects/songs.dart';

class AudioPlayerLogic extends ChangeNotifier {
  bool isPlaying = false;
  final AudioPlayer audioPlayer = AudioPlayer();

  List<Song> queue = [];
  List<Song> history = [];

  double currentVolume = 1;
  String currentCover =
      '/home/ohbowie/Downloads/music_transfer/default_album_art.png';
  String currentTitle = 'No Album Selected';
  String currentArtist = 'No Album Selected';

  AudioPlayerLogic() {
    // STREAMS:

    // if the player is playing, set isPlaying to true
    audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.playing) {
        isPlaying = true;
      } else {
        isPlaying = false;
      }
    });

    // if the player completes a song, play the next song in the queue
    audioPlayer.onPlayerComplete.listen((event) {
      skip();
    });
  }

  //END OF STREAMS

  // NON-STREAMS:
  Future<void> addToQueue(Song song) async {
    queue.add((song));

    if (queue.length == 1) {
      play();
    }
  }

  void play() async {
    if (queue.isEmpty) {
      print("Queue is empty.");
      defaultValues();
      return;
    } else {
      await audioPlayer.play(DeviceFileSource(queue[0].songPath));

      currentCover = queue[0].albumArtPath;
      currentTitle = queue[0].title.substring(
        3,
        queue[0].title.length - 4,
      ); // trims numbers from start and .mp3 from end
      currentArtist = queue[0].artist;
      notifyListeners();
    }
  }

  void defaultValues() async {
    currentCover =
        '/home/ohbowie/Downloads/music_transfer/default_album_art.png';
    currentTitle = 'No Album Selected';
    currentArtist = 'No Album Selected';
    notifyListeners();
  }

  void skip() async {
    if (queue.isEmpty) {
      print("Queue is empty.");
      defaultValues();
    } else {
      await audioPlayer.stop();
      history.add(queue[0]);
      queue.removeAt(0);
      play();
    }
  }

  /*
  TODO: add a 'previous' button, which goes to the start of the song (pausing it) if a song is playing, and puts the last song from history into queue[0] and plays it
    o list.insert(0, history[history.length]) allows you to put it to the start
    
    remove from end of history
    insert into start of queue
    play song?
  */

  void mainButtonPress() async {
    if (queue.isEmpty) {
      print("Queue is empty.");
      return;
    }
    if (isPlaying) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.resume();
    }
  }
}
