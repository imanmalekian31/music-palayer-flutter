import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Song> _songs;
  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  void initPlayer() async {
    var songs = await MusicFinder.allSongs() as List<Song>;
    songs = List.from(songs);
    setState(() {
      _songs = songs;
    });
  }

  int getSongsLength() {
    if (_songs == null) {
      return 0;
    }
    return _songs.length;
  }

  @override
  Widget build(BuildContext context) {
    Widget home() {
      return new Scaffold(
        appBar: AppBar(title: Text("Music App")),
        body: ListView.builder(
            itemCount: getSongsLength(),
            itemBuilder: (context, int index) {
              return ListTile(
                leading: CircleAvatar(
                  child: _songs[index].albumArt != null
                      ? Image.file(File(_songs[index].albumArt))
                      : null,
                ),
                title: Text(_songs[index].title),
              );
            }),
      );
    }

    return MaterialApp(
      home: home(),
    );
  }
}
