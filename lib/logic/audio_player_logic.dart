import 'package:audioplayers/audioplayers.dart';

class AudioPlayerLogic {
  bool isPlaying = false;
  final AudioPlayer audioPlayer = AudioPlayer();

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

  void pause() async {
    await audioPlayer.pause();
  }

  void resume() async {
    await audioPlayer.resume();
  }

  void buttonPress() async {}
}

//TODO: add logic buttonPress() to play if nothing is playing, pause if it is, and resume if it is paused
//TODO: use streams in order to detect things like when a song ends, when a song is paused, etc.
//TODO: make the audioplayer a late and instead create an initialiser for it which can also create an AudioState (or something) variable that can be used to detect if a song is playing n stuff
//TODO: read through onenote page i made on 'getting started' to find out things you can add/change