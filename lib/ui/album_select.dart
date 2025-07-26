import 'dart:io';
import '/data/globals.dart';
import 'package:flutter/material.dart';
import '/logic/audio_player_logic.dart';
import 'package:provider/provider.dart';

class AlbumSelect extends StatefulWidget {
  const AlbumSelect({super.key});

  @override
  State<AlbumSelect> createState() => _AlbumSelectState();
}

class _AlbumSelectState extends State<AlbumSelect> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("Select an Album"), centerTitle: true),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          padding: EdgeInsets.all(8),
          itemCount: Globals.albums.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: FileImage(
                  File(Globals.albums[index].albumArtPath),
                ),
              ),
              title: Text(Globals.albums[index].title),
              onTap: () {
                final audioLogic = Provider.of<AudioPlayerLogic>(
                  context,
                  listen: false,
                );
                // adds the first song to the queue
                //TODO: change this to go into a screen that allows you to select from the songs in the album
                audioLogic.addToQueue(Globals.albums[index].songs[0].songPath);
                //print(Globals.albums[index].songs[0].title);
              },
            );
          },
        ),
      ),
    );
  }
}
