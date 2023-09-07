import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_app/constants.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String filesV;
  const VideoPlayerScreen({super.key, required this.filesV});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.filesV));
    _controller.initialize().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final filename = basename(widget.filesV);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kColorWhite),
        backgroundColor: Colors.transparent,
        title: Text(filename),
        actions: const [Icon(Icons.more_vert)],
      ),
      backgroundColor: kcolorblack,
      body: Center(
        child: _controller.value.isInitialized
            ? Stack(
                alignment: Alignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 120,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: kcolorblack54),
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.fullscreen,
                            color: kColorWhite,
                          )),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomStart,
                    child: Container(
                      height: 120,
                      decoration: const BoxDecoration(
                        color: kcolorblack54,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20, top: 20, bottom: 10),
                            child: VideoProgressIndicator(
                              _controller,
                              colors: const VideoProgressColors(
                                playedColor: Colors.blue,
                                backgroundColor: Colors.grey,
                              ),
                              allowScrubbing: true,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () {
                                  // Handle forward action
                                },
                                icon: const Icon(
                                  Icons.replay_10,
                                  size: 32.0,
                                  color: kColorWhite,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  // Handle forward action
                                },
                                icon: const Icon(
                                  Icons.skip_previous,
                                  size: 32.0,
                                  color: kColorWhite,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (_controller.value.isPlaying) {
                                      _controller.pause();
                                    } else {
                                      _controller.play();
                                    }
                                  });
                                },
                                child: Icon(
                                  _controller.value.isPlaying
                                      ? Icons.pause_circle_outline
                                      : Icons.play_circle_outline,
                                  size: 72.0,
                                  color: kColorWhite,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  // Handle next action
                                },
                                icon: const Icon(
                                  Icons.skip_next,
                                  size: 32.0,
                                  color: kColorWhite,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  // Handle forward action
                                },
                                icon: const Icon(
                                  Icons.forward_10,
                                  size: 32.0,
                                  color: kColorWhite,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : const CircularProgressIndicator(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
