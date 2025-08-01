//TODO: make a songs screen
import 'package:flutter/material.dart';
import 'package:mp3_player/logic/objects/albums.dart';

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
    return const Placeholder();
  }
}
