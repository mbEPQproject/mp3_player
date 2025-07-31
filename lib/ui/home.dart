import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:mp3_player/logic/audio_player_logic.dart';
import '/logic/objects/albums.dart';
import '/data/globals.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool testFunction() {
    print('button pressed');
    Provider.of<AudioPlayerLogic>(
      context,
      listen: false,
    ).addToQueue(Globals.albums[0].songs[0]);
    Provider.of<AudioPlayerLogic>(
      context,
      listen: false,
    ).addToQueue(Globals.albums[6].songs[0]);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var audioPlayerLogic = Provider.of<AudioPlayerLogic>(
      context,
      listen: false,
    );

    return Scaffold(
      //TODO: give the app bar buttons correct functionality
      appBar: AppBar(
        backgroundColor: Color(
          const Color.fromARGB(255, 236, 236, 236).toARGB32(),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              width: 100,
              child: TextButton(
                onPressed: testFunction,
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  backgroundColor: WidgetStateProperty.all(
                    Color.fromARGB(255, 221, 221, 221),
                  ),
                ),
                child: Text('Home'),
              ),
            ),
            SizedBox(
              height: 50,
              width: 100,
              child: TextButton(
                onPressed: testFunction,
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                ),
                child: Text('Queue'),
              ),
            ),
            SizedBox(
              height: 50,
              width: 100,
              child: TextButton(
                onPressed: testFunction,
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                ),
                child: Text('Albums'),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<AudioPlayerLogic>(
            builder:
                (context, value, child) => Center(
                  heightFactor: 1.25,
                  child: SizedBox(
                    height: 240,
                    width: 240,
                    child: Image.file(File(value.currentCover)),
                  ),
                ),
          ),
          Consumer<AudioPlayerLogic>(
            builder:
                (context, value, child) => Container(
                  margin: EdgeInsets.only(left: 55),
                  child: Text(
                    value.currentTitle,
                    style: TextStyle(height: -3.5, fontSize: 12),
                    textAlign: TextAlign.left,
                  ),
                ),
          ),

          //TODO: find out how to move this text without moving the rest of the things in the app
          Consumer<AudioPlayerLogic>(
            builder:
                (context, value, child) => Container(
                  margin: EdgeInsets.only(left: 55),
                  child: Text(
                    value.currentArtist,
                    style: TextStyle(height: -1.5, fontSize: 10),
                    textAlign: TextAlign.left,
                  ),
                ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //TODO: make 'previous song' button function
              IconButton(
                onPressed: audioPlayerLogic.previousSong,
                icon: Icon(Icons.arrow_left_rounded, size: 80),
              ),
              IconButton(
                onPressed: audioPlayerLogic.mainButtonPress,
                icon: Icon(Icons.play_arrow_rounded, size: 80),
              ),
              IconButton(
                onPressed: audioPlayerLogic.skip,
                icon: Icon(Icons.arrow_right_rounded, size: 80),
              ),
            ],
          ),
          SliderTheme(
            data: SliderThemeData(
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0),
              overlayColor: Colors.transparent,
            ),
            child: Slider(
              divisions: 100,
              label: '${(audioPlayerLogic.currentVolume * 100).toInt()}%',
              value: audioPlayerLogic.currentVolume,
              onChanged: (value) {
                setState(() => audioPlayerLogic.currentVolume = value);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 20),
            alignment: Alignment.centerRight,
            child: Text(
              '${(audioPlayerLogic.currentVolume * 100).toInt()}%',
              textAlign: TextAlign.end,
              style: TextStyle(height: -0.75),
            ),
          ),
        ],
      ),
    );
  }
}
