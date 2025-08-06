//TODO: make a songs screen
import 'package:flutter/material.dart';
import 'package:mp3_player/logic/audio_player_logic.dart';
import 'package:mp3_player/logic/objects/albums.dart';
import 'package:provider/provider.dart';

class SongsScreen extends StatefulWidget {
  const SongsScreen({super.key, required this.album});

  final Album album;

  @override
  State<SongsScreen> createState() => _SongsScreenState();
}

class _SongsScreenState extends State<SongsScreen> {
  @override
  Widget build(BuildContext context) {
    Album album = widget.album;
    return Scaffold(
      appBar: AppBar(
        title: Text(album.title),
        centerTitle: true,
        backgroundColor: Color(
          const Color.fromARGB(255, 236, 236, 236).toARGB32(),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<AudioPlayerLogic>(
                context,
                listen: false,
              ).addEntireAlbum('top', album);
            },
            icon: Icon(Icons.arrow_upward_rounded),
          ),
          IconButton(
            onPressed: () {
              Provider.of<AudioPlayerLogic>(
                context,
                listen: false,
              ).addEntireAlbum('bottom', album);
            },
            icon: Icon(Icons.arrow_downward_rounded),
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: album.songs.length,
        itemBuilder:
            (context, index) => ListTile(
              leading: Text(
                (index + 1).toString(),
                style: TextStyle(fontSize: 25),
              ),
              title: Text(
                album.songs[index].title.substring(
                  3,
                  album.songs[index].title.length - 4,
                ),
                style: (TextStyle(overflow: TextOverflow.ellipsis)),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      if (Provider.of<AudioPlayerLogic>(
                        context,
                        listen: false,
                      ).queue.isEmpty) {
                        Provider.of<AudioPlayerLogic>(
                          context,
                          listen: false,
                        ).addToQueue(album.songs[index]);
                      } else {
                        Provider.of<AudioPlayerLogic>(
                          context,
                          listen: false,
                        ).queue.insert(1, album.songs[index]);
                      }
                    },
                    icon: Icon(Icons.arrow_upward_rounded),
                  ),
                  IconButton(
                    onPressed: () {
                      Provider.of<AudioPlayerLogic>(
                        context,
                        listen: false,
                      ).addToQueue(album.songs[index]);
                    },
                    icon: Icon(Icons.arrow_downward_rounded),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
