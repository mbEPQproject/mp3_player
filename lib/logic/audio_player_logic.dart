import 'package:audioplayers/audioplayers.dart';

class AudioPlayerLogic {
  AudioPlayer audioPlayer = AudioPlayer();

  List<String> queue = [];
  List<String> history = [];

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
      await audioPlayer.play(AssetSource(queue[0]));
    }
  }

  void skip() async {
    if (queue.isEmpty) {
      print("Queue is empty.");
    } else {
      audioPlayer.stop();
      history.add(queue[0]);
      queue.removeAt(0);
    }
  }
}
