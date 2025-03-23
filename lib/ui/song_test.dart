import 'package:flutter/material.dart';
import 'package:mp3_player/logic/audio_player_logic.dart';

class AudioTestUI extends StatelessWidget {
  AudioTestUI({super.key});

  final AudioPlayerLogic audioPlayerLogic = AudioPlayerLogic();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('AUDIO TEST'), centerTitle: true),
        body: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: audioPlayerLogic.play,
              child: Text('PLAY'),
            ),
            ElevatedButton(
              onPressed: () async {
                audioPlayerLogic.addToQueue('chirp_test_audio.mp3');
              },
              child: Text('ADD TO QUEUE'),
            ),
            ElevatedButton(
              onPressed: audioPlayerLogic.skip,
              child: Text('SKIP'),
            ),
            ElevatedButton(
              onPressed: audioPlayerLogic.mainButtonPress,
              child: Text('RESUME'),
            ),
          ],
        ),
      ),
    );
  }
}
