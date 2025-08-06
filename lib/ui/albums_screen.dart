//TODO: make an albums screen
import 'package:mp3_player/logic/audio_player_logic.dart';

import 'songs_screen.dart';
import 'package:flutter/material.dart';
import 'package:mp3_player/data/globals.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class AlbumsScreen extends StatefulWidget {
  const AlbumsScreen({super.key});

  @override
  State<AlbumsScreen> createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  @override
  Widget build(BuildContext context) {
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
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home_screen');
                },
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
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
                onPressed: () {},
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  backgroundColor: WidgetStateProperty.all(
                    Color.fromARGB(255, 221, 221, 221),
                  ),
                ),
                child: Text('Albums', style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        padding: EdgeInsets.all(8),
        itemCount: Globals.albums.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Container(
              padding: EdgeInsets.only(bottom: 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image(
                  image: FileImage(File(Globals.albums[index].albumArtPath)),
                ),
              ),
            ),
            subtitle: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Container(
                  padding: EdgeInsets.only(),
                  child: Text(
                    Globals.albums[index].title,
                    style: TextStyle(
                      height: 2,
                      fontSize: 8,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(),
                  child: Text(
                    Globals.albums[index].artist,
                    style: TextStyle(
                      height: 5.5,
                      fontSize: 7,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            onTap: () {},
          );
        },
      ),
    );
  }
}
