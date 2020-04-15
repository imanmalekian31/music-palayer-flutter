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
    var songs = await MusicFinder.allSongs();
    songs = List.from(songs);
    setState(() {
      _songs = songs;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget home() {
      return new Scaffold(
        appBar: AppBar(title: Text("Music App")),
        body: ListView.builder(
            itemCount: 30,
            itemBuilder: (context, int index) {
              return ListTile(
                leading: CircleAvatar(
                  child: Text(_songs[index].title[0]),
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
