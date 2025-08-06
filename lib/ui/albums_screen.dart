//TODO: make an albums screen
import 'songs_screen.dart';
import 'package:flutter/material.dart';

class AlbumsScreen extends StatefulWidget {
  const AlbumsScreen({super.key});

  @override
  State<AlbumsScreen> createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
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
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/queue_screen');
                },
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                ),
                child: Text('Queue', style: TextStyle(fontSize: 20)),
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
                child: Text('Albums', style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
      body: Placeholder(),
    );
  }
}
