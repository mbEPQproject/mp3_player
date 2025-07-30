import 'package:flutter/material.dart';
import '/logic/objects/albums.dart';
import 'package:provider/provider.dart';
import '/logic/audio_player_logic.dart';

class SongSelect extends StatefulWidget {
  const SongSelect({super.key, required this.album});

  final Album album;

  @override
  State<SongSelect> createState() => _SongSelectState();
}

class _SongSelectState extends State<SongSelect> {
  @override
  Widget build(BuildContext context) {
    Album album = widget.album;

    return Scaffold(
      appBar: AppBar(title: Text(album.title), centerTitle: true),
      body: ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: album.songs.length,
        itemBuilder:
            (context, index) => ListTile(
              title: Text(
                album.songs[index].title.substring(
                  0,
                  album.songs[index].title.length - 4,
                ),
              ),
              subtitle: Text(album.artist),
              onTap: () {
                Provider.of<AudioPlayerLogic>(
                  context,
                  listen: false,
                ).addToQueue(album.songs[index].songPath);
              },
            ),
      ),
    );
  }
}
