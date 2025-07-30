import 'dart:io';
import 'package:flutter/material.dart';
import '/logic/objects/albums.dart';
import '/logic/objects/songs.dart';
import '/data/globals.dart';
import 'home.dart';

const String defaultAlbumArtPath =
    '/home/ohbowie/Downloads/music/default_album_art.png';

// defines the class and allows me to work on it in the next codeblock with the addition of variables/methods
class OpeningLoadingScreen extends StatefulWidget {
  const OpeningLoadingScreen({super.key});

  @override
  State<OpeningLoadingScreen> createState() => _OpeningLoadingScreenState();
}

class _OpeningLoadingScreenState extends State<OpeningLoadingScreen> {
  Future<bool> loadAllAlbums() async {
    Directory mainDir = Directory('/home/ohbowie/Downloads/music_transfer/');
    List<FileSystemEntity> artists = mainDir.listSync();

    for (FileSystemEntity artist in artists) {
      if (artist is File) continue;
      Directory artistDir = Directory(artist.path);
      List<FileSystemEntity> albums = artistDir.listSync();

      for (FileSystemEntity album in albums) {
        Directory albumDir = Directory(album.path);
        List<FileSystemEntity> songs = albumDir.listSync();

        Album newAlbum = Album();
        newAlbum.albumArtPath = '';

        newAlbum.title = albumDir.path.substring(artist.path.length + 1);
        newAlbum.artist = artistDir.path.substring(mainDir.path.length);

        int count = 0;
        for (FileSystemEntity file in songs) {
          if (file.path.endsWith('.jpg') ||
              file.path.endsWith('.png') ||
              file.path.endsWith('.jpeg')) {
            newAlbum.albumArtPath = file.path;
            continue;
          }
          Song newSong = Song();
          newSong.songPath = file.path;
          newSong.title = file.path.substring(albumDir.path.length + 1);
          newSong.trackNumber = count + 1;

          newAlbum.songs.add(newSong);

          count++;
        }
        newAlbum.amountOfSongs = count;

        if (newAlbum.albumArtPath == '') {
          newAlbum.albumArtPath = defaultAlbumArtPath;
        }

        // sorting songs by track number
        newAlbum.songs.sort((a, b) => a.title.compareTo(b.title));
        Globals.albums.add(newAlbum);
      }
    }

    await Future.delayed(const Duration(seconds: 1), () {});
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.displayMedium!,
      child: FutureBuilder<bool>(
        future: loadAllAlbums(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // results in song test being swapped to after 2 seconds of displaying a checkmark
            Future.delayed(const Duration(seconds: 2), () {
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, '/home_screen');
              }
            });
            return Center(
              child: Icon(Icons.check, color: Colors.green, size: 100),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('ERROR'));
          }
          // what shows when loading
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Center(child: CircularProgressIndicator(color: Colors.white)),
          );
        },
      ),
    );
  }
}
