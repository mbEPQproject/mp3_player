//TODO fix imports when im compiling app
import 'package:flutter/material.dart';
import 'package:mp3_player/ui/opening_loadingscreen.dart';
// USE FOR ACTUAL APP import '/ui/opening_loadingscreen.dart';
import 'ui/album_select.dart';
import 'data/globals.dart';

import 'dart:io';

import '/logic/objects/albums.dart';
import '/logic/objects/songs.dart';
import 'package:mp3_player/logic/audio_player_logic.dart';
import 'package:provider/provider.dart';
import 'ui/song_test.dart';
import 'ui/song_select.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // testLoadSongs();

  //print(Globals.albums[0].songs[0].title);

  runApp(
    ChangeNotifierProvider(
      create: (context) => AudioPlayerLogic(),
      child: MaterialApp(
        home: const OpeningLoadingScreen(),
        routes: {
          '/album_select': (context) => AlbumSelect(),
          '/song_test': (context) => AudioTestUI(),
          '/song_select':
              (context) => SongSelect(
                album: ModalRoute.of(context)!.settings.arguments as Album,
              ),
        },
      ),
    ),
  );
}

// allows for lloading songs without needing to use the opening_loadingscreen as i dont know how to swtich from it
void testLoadSongs() {
  Directory mainDir = Directory('/home/ohbowie/Downloads/music/');
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
      Globals.albums.add(newAlbum);
    }
  }
}
