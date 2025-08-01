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
                onPressed: () {},
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  backgroundColor: WidgetStateProperty.all(
                    Color.fromARGB(255, 221, 221, 221),
                  ),
                ),
                child: Text('Home', style: TextStyle(fontSize: 20)),
              ),
            ),
            SizedBox(
              height: 50,
              width: 100,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/queue_screen');
                },
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                ),
                child: Text('Queue', style: TextStyle(fontSize: 20)),
              ),
            ),
            SizedBox(
              height: 50,
              width: 100,
              child: TextButton(
                onPressed: () {
                  Provider.of<AudioPlayerLogic>(
                    context,
                    listen: false,
                  ).addToQueue(Globals.albums[2].songs[2]);
                  Provider.of<AudioPlayerLogic>(
                    context,
                    listen: false,
                  ).addToQueue(Globals.albums[6].songs[2]);
                  //TODO: fix this back - using this as song add test
                  //Navigator.pushReplacementNamed(context, '/albums_screen');
                },
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                ),
                child: Text('Albums', style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<AudioPlayerLogic>(
            builder:
                (context, value, child) => Center(
                  heightFactor: 1.25,
                  child: SizedBox(
                    height: 240,
                    width: 240,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.file(File(value.currentCover)),
                    ),
                  ),
                ),
          ),
          Consumer<AudioPlayerLogic>(
            builder:
                (context, value, child) => Container(
                  margin: EdgeInsets.only(left: 55),
                  child: Text(
                    value.currentTitle,
                    style: TextStyle(height: -2.25, fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                ),
          ),
          Consumer<AudioPlayerLogic>(
            builder:
                (context, value, child) => Container(
                  margin: EdgeInsets.only(left: 55),
                  child: Text(
                    value.currentArtist,
                    style: TextStyle(height: -0.5, fontSize: 12),
                    textAlign: TextAlign.left,
                  ),
                ),
          ),
          Consumer<AudioPlayerLogic>(
            builder:
                (context, value, child) => SliderTheme(
                  data: SliderThemeData(
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 4),
                    overlayColor: Colors.transparent,
                  ),
                  child: Slider(
                    min: 0,
                    max: value.currentDuration,
                    divisions: 100,
                    value: value.currentPosition,
                    onChanged: (val) => {},
                    onChangeEnd: (val) {
                      value.updatePosition(val);
                    },
                  ),
                ),
          ),
          Consumer<AudioPlayerLogic>(
            builder:
                (context, value, child) => Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 22),
                      child: Text(
                        value.getCurrentTimeForUI(),
                        style: TextStyle(height: -1.6),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 280),
                      child: Text(
                        value.getCurrentDurationForUI(),
                        style: TextStyle(height: -1.6),
                      ),
                    ),
                  ],
                ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: audioPlayerLogic.previousSong,
                icon: Icon(Icons.arrow_left_rounded, size: 80),
              ),
              Consumer<AudioPlayerLogic>(
                builder:
                    (context, value, child) => IconButton(
                      onPressed: audioPlayerLogic.mainButtonPress,
                      icon: audioPlayerLogic.getIcon(),
                    ),
              ),
              IconButton(
                onPressed: audioPlayerLogic.skip,
                icon: Icon(Icons.arrow_right_rounded, size: 80),
              ),
            ],
          ),
          Consumer<AudioPlayerLogic>(
            builder:
                (context, value, child) => SliderTheme(
                  data: SliderThemeData(
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0),
                    overlayColor: Colors.transparent,
                  ),
                  child: Slider(
                    divisions: 100,
                    value: value.currentVolume,
                    onChanged: (val) {
                      setState(() => value.changeVolume(val));
                    },
                  ),
                ),
          ),
          Container(
            padding: EdgeInsets.only(right: 20),
            alignment: Alignment.centerRight,
            child: Text(
              '${(audioPlayerLogic.currentVolume * 100).toInt()}%',
              textAlign: TextAlign.end,
              style: TextStyle(height: -1.8),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/history_screen', arguments: ());
            },
            icon: Icon(Icons.menu_book_rounded),
          ),
        ],
      ),
    );
  }
}
