import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mp3_player/logic/audio_player_logic.dart';
import 'dart:io';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        centerTitle: true,
        backgroundColor: Color(
          const Color.fromARGB(255, 236, 236, 236).toARGB32(),
        ),
      ),
      body: Consumer<AudioPlayerLogic>(
        builder:
            (context, value, child) => ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: value.getHistory().length,
              itemBuilder:
                  (context, index) => ListTile(
                    leading: Image(
                      image: FileImage(
                        File(value.getHistory()[index].albumArtPath),
                      ),
                    ),
                    title: Text(
                      value.getHistory()[index].title.substring(
                        3,
                        value.getHistory()[index].title.length - 4,
                      ),
                    ),
                    subtitle: Text(value.getHistory()[index].artist),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            value.addFromHistory('top', index);
                          },
                          icon: Icon(Icons.arrow_upward_rounded),
                        ),
                        IconButton(
                          onPressed: () {
                            value.addFromHistory('bottom', index);
                          },
                          icon: Icon(Icons.arrow_downward_rounded),
                        ),
                      ],
                    ),
                    onTap: () {},
                    splashColor: Colors.transparent,
                  ),
            ),
      ),
    );
  }
}
