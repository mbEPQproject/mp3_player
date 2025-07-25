import 'dart:io';
import 'package:flutter/material.dart';
import '/logic/objects/albums.dart';

// defines the class and allows me to work on it in the next codeblock with the addition of variables/methods
class OpeningLoadingScreen extends StatefulWidget {
  const OpeningLoadingScreen({super.key});

  @override
  State<OpeningLoadingScreen> createState() => _OpeningLoadingScreenState();
}

class _OpeningLoadingScreenState extends State<OpeningLoadingScreen> {
  void loadAllAlbums() async {
    Directory mainDir = Directory('/home/ohbowie/Downloads/music/');
    List<FileSystemEntity> artists = mainDir.listSync();

    for (FileSystemEntity artist in artists) {
      Directory artistDir = Directory(artist.path);
      List<FileSystemEntity> albums = artistDir.listSync();

      for (FileSystemEntity album in albums) {
        Directory albumDir = Directory(album.path);
        List<FileSystemEntity> songs = albumDir.listSync();

        Album newAlbum = Album();
        print(albumDir.path.substring(artist.path.length + 1));
        //newAlbum.title = albumDir.path.substring(album.path.length);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    loadAllAlbums();
    return MaterialApp();
  }
}
