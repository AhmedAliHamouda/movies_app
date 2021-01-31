import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class VideoPlayerScreen extends StatefulWidget {
  final YoutubePlayerController controller;
  VideoPlayerScreen({@required this.controller});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body:
        Stack(
          children: <Widget>[
            Center(
              child: YoutubePlayer(
                controller: widget.controller,
                showVideoProgressIndicator: true,
              ),
            ),
            Positioned(
              top: 40.0,
              right: 20.0,
              child: IconButton(icon: Icon(EvaIcons.closeCircle, color: Colors.white, size: 40.0,), onPressed: () {
                Navigator.pop(context);
              }),
            )
          ],
        )
    );
  }
}
