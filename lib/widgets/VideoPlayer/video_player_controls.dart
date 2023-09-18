import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_app/constants.dart';

class VideoPlayerControls extends StatefulWidget {
  final VideoPlayerController controller;
  final Function? onNext;
  const VideoPlayerControls({super.key, required this.controller, this.onNext});

  @override
  State<VideoPlayerControls> createState() => _VideoPlayerControlsState();
}

class _VideoPlayerControlsState extends State<VideoPlayerControls> {
  bool areControlsVisible = true;

  void toggleControlsVisibility() {
    setState(() {
      areControlsVisible = !areControlsVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
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
                widget.controller,
                colors: const VideoProgressColors(
                  playedColor: Colors.blue,
                  backgroundColor: Colors.grey,
                ),
                allowScrubbing: true,
              ),
            ),
            // widget.isFullScreen!
            //     ? SizedBox(
            //         height: 30,
            //       )
            //     :
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (widget.controller.value.isPlaying) {
                        widget.controller.seekTo(
                            widget.controller.value.position -
                                const Duration(seconds: 10));
                      }
                    });
                  },
                  icon: const Icon(
                    Icons.replay_10,
                    size: 32.0,
                    color: kColorWhite,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (widget.controller.value.isPlaying) {
                        widget.controller.pause();
                      } else {
                        widget.controller.play();
                      }
                    });
                  },
                  child: Icon(
                    widget.controller.value.isPlaying
                        ? Icons.pause_circle_outline
                        : Icons.play_circle_outline,
                    size: 72.0,
                    color: kColorWhite,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (widget.controller.value.isPlaying) {
                        widget.controller.seekTo(
                            widget.controller.value.position +
                                const Duration(seconds: 10));
                      }
                    });
                  },
                  icon: const Icon(
                    Icons.forward_10,
                    size: 32.0,
                    color: kColorWhite,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
