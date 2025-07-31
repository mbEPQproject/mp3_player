/* TODO: WHEN COMPLETED APP
o fix imports to only essentials across entire app
o remove all print statements
*/
import 'package:flutter/material.dart';
import 'package:mp3_player/ui/home.dart';
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

  runApp(
    ChangeNotifierProvider(
      create: (context) => AudioPlayerLogic(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const OpeningLoadingScreen(),
        routes: {
          '/home_screen': (context) => HomeScreen(),
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
