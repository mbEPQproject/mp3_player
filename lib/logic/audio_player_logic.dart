import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'objects/songs.dart';
import 'dart:async';

class AudioPlayerLogic extends ChangeNotifier {
  bool isPlaying = false;
  final AudioPlayer audioPlayer = AudioPlayer();

  late Timer timer;

  List<Song> queue = [];
  List<Song> history = [];

  double currentVolume = 1;
  double currentDuration =
      1; // starts at a number to not cause error during initialisation
  double currentPosition = 0;
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
        launchTimer();
      } else {
        isPlaying = false;
        timer.cancel();
      }
      updateUI();
    });

    // if the player completes a song, play the next song in the queue
    audioPlayer.onPlayerComplete.listen((event) {
      skip();
    });

    audioPlayer.onDurationChanged.listen((Duration duration) {
      currentDuration = duration.inSeconds.toDouble();
      updateUI();
    });

    audioPlayer.onPositionChanged.listen((Duration position) {
      if (currentDuration == 0) return;
      currentPosition = position.inSeconds.toDouble();
      updateUI();
    });
  }

  //END OF STREAMS

  // NON-STREAMS:
  void launchTimer() {
    timer = Timer.periodic(Duration(milliseconds: 200), (timer) async {
      currentPosition = await audioPlayer.getCurrentPosition().then((value) {
        if (value == null) return 0.0;
        return value.inSeconds.toDouble();
      });
      updateUI();
    });
  }

  void updatePosition(double position) {
    currentPosition = position;
    audioPlayer.seek(Duration(seconds: position.toInt()));
    updateUI();
  }

  void changeVolume(double position) {
    audioPlayer.setVolume(position);
    currentVolume = position;
  }

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

  Icon getIcon() {
    if (isPlaying) {
      return Icon(Icons.pause_rounded, size: 80);
    } else {
      return Icon(Icons.play_arrow_rounded, size: 80);
    }
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
    if (history.isEmpty) {
      print("History is empty.");
      return;
    }

    if (isPlaying == true ||
        await audioPlayer.getCurrentPosition() != Duration.zero) {
      await audioPlayer.pause();
      await audioPlayer.seek(Duration.zero);
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

  String getCurrentTimeForUI() {
    if (currentDuration == 1) {
      return '00:00';
    }

    int minutes = (currentPosition ~/ 60);
    int seconds = (currentPosition % 60).toInt();

    String minutesPart;
    minutesPart = minutes.toString();
    if (minutesPart.length == 1) {
      minutesPart = '0$minutesPart';
    }
    String secondsPart;
    secondsPart = seconds.toString();
    if (secondsPart.length == 1) {
      secondsPart = '0$secondsPart';
    }

    return '$minutesPart:$secondsPart';
  }

  String getCurrentDurationForUI() {
    if (currentDuration == 1) {
      return '00:00';
    }

    int minutes = (currentDuration ~/ 60);
    int seconds = (currentDuration % 60).toInt();

    String minutesPart;
    minutesPart = minutes.toString();
    if (minutesPart.length == 1) {
      minutesPart = '0$minutesPart';
    }
    String secondsPart;
    secondsPart = seconds.toString();
    if (secondsPart.length == 1) {
      secondsPart = '0$secondsPart';
    }

    return '$minutesPart:$secondsPart';
  }

  List<Song> getHistory() {
    // returned reversed so that the visualisation looks correct (songs coming in at the top)
    return history.reversed.toList();
  }

  void addFromHistory(String whereTo, int index) {
    // list that the user views in history is upside down
    // get original queue, reverse, take out the index - inserting into queue, reverse again, insert as queue
    List<Song> userHistory = history.reversed.toList();
    Song songSelected = userHistory[index];

    if (whereTo == 'top') {
      if (queue.isEmpty) {
        addToQueue(songSelected);
      }
      queue.insert(1, songSelected);
      if (queue.length == 1) {
        play();
      }
    } else if (whereTo == 'bottom') {
      addToQueue(songSelected);
    }

    userHistory.removeAt(index);
    history = userHistory.reversed.toList();
    notifyListeners();
  }
}
