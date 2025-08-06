import 'package:flutter/material.dart';
import 'package:mp3_player/ui/home_screen.dart';
import 'package:mp3_player/ui/loading_screen.dart';
import '/logic/objects/albums.dart';
import 'package:mp3_player/logic/audio_player_logic.dart';
import 'package:provider/provider.dart';
import 'ui/history_screen.dart';
import 'ui/queue_screen.dart';
import 'ui/albums_screen.dart';
import 'ui/songs_screen.dart';

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
          '/history_screen': (context) => HistoryScreen(),
          '/queue_screen': (context) => QueueScreen(),
          '/albums_screen': (context) => AlbumsScreen(),
          '/songs_screen':
              (context) => SongsScreen(
                album: ModalRoute.of(context)!.settings.arguments as Album,
              ),
        },
      ),
    ),
  );
}
