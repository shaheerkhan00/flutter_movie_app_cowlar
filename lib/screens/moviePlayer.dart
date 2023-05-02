import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MoviePlayerPage extends StatefulWidget {
  final String videoKey;

  const MoviePlayerPage({Key? key, required this.videoKey}) : super(key: key);

  @override
  _MoviePlayerPageState createState() => _MoviePlayerPageState();
}

class _MoviePlayerPageState extends State<MoviePlayerPage> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: widget.videoKey,
      flags: YoutubePlayerFlags(
        autoPlay: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: YoutubePlayer(
        controller: _controller,
        onEnded: (_) {
          Navigator.pop(context);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.pause();
          Navigator.pop(context);
        },
        child: Icon(Icons.done),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
