import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

//TODO: make button switch screen to home/queue/albums appropriately
//TODO: other parts of home (not appbar) to this
class _HomeScreenState extends State<HomeScreen> {
  bool testFunction() {
    print('button pressed');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              width: 100,
              child: TextButton(
                onPressed: testFunction,
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                ),
                child: Text('Home'),
              ),
            ),
            SizedBox(
              height: 50,
              width: 100,
              child: TextButton(
                onPressed: testFunction,
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                ),
                child: Text('Queue'),
              ),
            ),
            SizedBox(
              height: 50,
              width: 100,
              child: TextButton(
                onPressed: testFunction,
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                ),
                child: Text('Albums'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
