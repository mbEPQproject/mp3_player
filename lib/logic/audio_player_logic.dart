import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'objects/songs.dart';

class AudioPlayerLogic extends ChangeNotifier {
  bool isPlaying = false;
  final AudioPlayer audioPlayer = AudioPlayer();

  List<Song> queue = [];
  List<Song> history = [];

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
  }

  void skip() async {
    if (queue.isEmpty) {
      print("Queue is empty.");
    } else {
      await audioPlayer.stop();
      history.add(queue[0]);
      queue.removeAt(0);
      play();
    }
  }

  void mainButtonPress() async {
    if (isPlaying) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.resume();
    }
  }
}
