import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(AudioTest());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AudioTest extends StatelessWidget {
  const AudioTest({super.key});

  void play() async {
    AudioPlayer audioPlayer = AudioPlayer();
    await audioPlayer.play(AssetSource('test_audio.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('Audio Test')),
        body: Center(
          child: ElevatedButton(
            onPressed: play,
            child: Text('Play Audio'),
          ),
        ),
      ),
    );
  }
}
