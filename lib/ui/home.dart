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

//TODO: everything needs to update dynamically as songs get queue'd up -> potentially put current cover/title/artist into provider to setstate from there

class _HomeScreenState extends State<HomeScreen> {
  bool testFunction() {
    print('button pressed');
    Provider.of<AudioPlayerLogic>(
      context,
      listen: false,
    ).addToQueue(Globals.albums[0].songs[0]);
    return true;
  }

  String getAlbumArt() {
    String albumArtPath =
        '/home/ohbowie/Downloads/music_transfer/default_album_art.png';

    if (Provider.of<AudioPlayerLogic>(
      context,
      listen: false,
    ).queue.isNotEmpty) {
      albumArtPath =
          Provider.of<AudioPlayerLogic>(
            context,
            listen: false,
          ).queue[0].albumArtPath;
    }
    return albumArtPath;
  }

  String getAlbumTitle() {
    String albumTitle = 'No Album Selected';

    if (Provider.of<AudioPlayerLogic>(
      context,
      listen: false,
    ).queue.isNotEmpty) {
      albumTitle =
          Provider.of<AudioPlayerLogic>(context, listen: false).queue[0].title;
    }
    return albumTitle;
  }

  String getAlbumArtist() {
    String albumArtist = 'No Album Selected';

    if (Provider.of<AudioPlayerLogic>(
      context,
      listen: false,
    ).queue.isNotEmpty) {
      albumArtist = 'PLACEHOLDER';
      //Provider.of<AudioPlayerLogic>(context, listen: false).queue[0].artist;
    }
    return albumArtist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //TODO: give the app bar buttons functionality
      //TOOD: make the app bar highlight when you're on its page
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
        children: [
          Center(
            heightFactor: 1.25,
            child: SizedBox(
              height: 240,
              width: 240,
              child: Image.file(File(getAlbumArt())),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 132),
            child: Text(
              getAlbumTitle(),
              style: TextStyle(height: -3.5, fontSize: 12),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 148),
            child: Text(
              getAlbumArtist(),
              style: TextStyle(height: -1.5, fontSize: 10),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: testFunction,
                icon: Icon(Icons.arrow_left_rounded, size: 80),
              ),
              IconButton(
                onPressed: testFunction,
                icon: Icon(Icons.play_arrow_rounded, size: 80),
              ),
              IconButton(
                onPressed: testFunction,
                icon: Icon(Icons.arrow_right_rounded, size: 80),
              ),
            ],
          ),
          //TODO: here - below the row - add a volume slider
        ],
      ),
    );
  }
}
