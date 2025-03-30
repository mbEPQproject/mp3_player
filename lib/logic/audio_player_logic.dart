import 'package:audioplayers/audioplayers.dart';
import 'package:mp3_player/data/globals.dart';

class AudioPlayerLogic {
  bool isPlaying = false;
  final AudioPlayer audioPlayer = AudioPlayer();

  List<String> queue = [];
  List<String> history = [];

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

  Future<void> addToQueue(String songUrl) async {
    queue.add((songUrl));

    if (queue.length == 1) {
      play();
    }
  }

  void play() async {
    if (queue.isEmpty) {
      print("Queue is empty.");
    } else {
      await audioPlayer.play(
        DeviceFileSource(Globals.mp3PlayerPath + queue[0]),
      );
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
