import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mp3_player/logic/audio_player_logic.dart';

class QueueScreen extends StatefulWidget {
  const QueueScreen({super.key});

  @override
  State<QueueScreen> createState() => _QueueScreenState();
}

class _QueueScreenState extends State<QueueScreen> {
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
                onPressed: () {},
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  backgroundColor: WidgetStateProperty.all(
                    Color.fromARGB(255, 221, 221, 221),
                  ),
                ),
                child: Text('Queue', style: TextStyle(fontSize: 20)),
              ),
            ),
            SizedBox(
              height: 50,
              width: 100,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/albums_screen');
                },
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                ),
                child: Text('Albums', style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
      body: Consumer<AudioPlayerLogic>(
        builder:
            (context, value, child) => ReorderableListView(
              buildDefaultDragHandles: false,
              children: <Widget>[
                for (int index = 0; index < value.getQueue().length; index++)
                  ListTile(
                    key: Key('$index'),
                    tileColor: value.ifZeroGray(index),
                    leading: Stack(
                      children: [
                        ReorderableDragStartListener(
                          index: index,
                          child: Container(
                            padding: EdgeInsets.only(top: 5),
                            child: Icon(Icons.menu, size: 35),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 50),
                          child: Image(
                            image: FileImage(
                              File(value.queue[index].albumArtPath),
                            ),
                          ),
                        ),
                      ],
                    ),
                    title: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.only(),
                          child: Text(
                            value.queue[index].title.substring(
                              3,
                              value.queue[index].title.length - 4,
                            ),
                            style: TextStyle(
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 16),
                          child: Text(
                            value.queue[index].artist,
                            style: TextStyle(
                              fontSize: 8,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        if (index == 0) {
                          value.skip();
                        } else {
                          value.queueRemoveAt(index);
                        }
                      },
                      icon: Icon(Icons.cancel_presentation_sharp),
                    ),
                  ),
              ],
              onReorder:
                  (oldIndex, newIndex) => {value.moveQueue(oldIndex, newIndex)},
            ),
      ),
    );
  }
}
