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
  void updateUI() {
    if (queue.isEmpty) {
      currentCover =
          '/home/ohbowie/Downloads/music_transfer/default_album_art.png';
      currentTitle = 'No Album Selected';
      currentArtist = 'No Album Selected';
    } else {
      currentCover = queue[0].albumArtPath;
      currentTitle = queue[0].title.substring(
        3,
        queue[0].title.length - 4,
      ); // trims numbers from start and .mp3 from end
      currentArtist = queue[0].artist;
    }
    notifyListeners();
  }

  Future<void> addToQueue(Song song) async {
    queue.add((song));

    if (queue.length == 1) {
      play();
    }
  }

  void play() async {
    if (queue.isEmpty) {
      print("Queue is empty.");
    } else {
      await audioPlayer.play(DeviceFileSource(queue[0].songPath));
    }
    updateUI();
  }

  void previousSong() async {
    if (isPlaying == true) {
      await audioPlayer.pause();
      await audioPlayer.seek(Duration.zero);
      return;
    }

    if (history.isEmpty) {
      print("History is empty.");
      return;
    }

    Song lastSong = history.removeLast();
    queue.insert(0, lastSong);
    play();
  }

  void skip() async {
    if (queue.isEmpty) {
      print("Queue is empty.");
      updateUI();
    } else {
      await audioPlayer.stop();
      history.add(queue[0]);
      queue.removeAt(0);
      play();
    }
  }

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
