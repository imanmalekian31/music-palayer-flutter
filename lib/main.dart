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
  bool _grid = true;

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

  void changeView() {
    setState(() {
      _grid ? _grid = false : _grid = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget viewList() {
      return ListView.builder(
          itemCount: getSongsLength(),
          itemBuilder: (context, int index) {
            return ListTile(
              leading: CircleAvatar(
                child: _songs[index].albumArt != null
                    ? Image.file(
                        File(_songs[index].albumArt),
                        fit: BoxFit.fill,
                      )
                    : Image.asset('assets/images/placeholder.png'),
              ),
              title: Text(_songs[index].title),
            );
          });
    }

    Widget viewGrid() {
      return GridView.builder(
        itemCount: getSongsLength(),
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, int index) {
          return Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            margin: EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: _songs[index].albumArt != null
                      ? FileImage(File(_songs[index].albumArt))
                      : ExactAssetImage('assets/images/placeholder.png'),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
          );
        },
      );
    }

    Widget grid() {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Music list'),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  _grid ? Icons.view_module : Icons.view_list,
                  color: Colors.white,
                ),
                onPressed: () {
                  changeView();
                },
              )
            ],
          ),
          body: _grid ? viewList() : viewGrid(),
        ),
      );
    }

    return MaterialApp(
      home: grid(),
    );
  }
}
