import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/widgets/VideoPlayer/vertical_slider.dart';

class RecentlyVideoPlayerControls extends StatefulWidget {
  final VideoPlayerController controller;
  final double volume;
  final ValueChanged<double> onVolumeChanged;
  final Duration fullDuration;
  final bool isRotated;

  const RecentlyVideoPlayerControls(
      {super.key,
      required this.controller,
      required this.volume,
      required this.onVolumeChanged,
      required this.fullDuration,
      required this.isRotated});

  @override
  State<RecentlyVideoPlayerControls> createState() =>
      _RecentlyVideoPlayerControlsState();
}

class _RecentlyVideoPlayerControlsState
    extends State<RecentlyVideoPlayerControls> {
  @override
  Widget build(BuildContext context) {
    //
    return Align(
      alignment: AlignmentDirectional.bottomStart,
      child: Container(
        height: 130,
        decoration: const BoxDecoration(
          color: kcolorblack54,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 30.0, right: 30, top: 30, bottom: 10),
              child: VideoProgressIndicator(
                widget.controller,
                colors: const VideoProgressColors(
                  playedColor: Colors.blue,
                  backgroundColor: Colors.grey,
                ),
                allowScrubbing: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formatDuration(widget.controller.value.position),
                    style: const TextStyle(color: kColorWhite),
                  ),
                  Text(
                    _formatDuration(widget.fullDuration),
                    style: const TextStyle(
                        color: kColorWhite, fontFamily: 'OpenSans'),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.volume_down,
                  size: 25,
                  color: kColorWhite,
                ),
                VerticalSlider(
                  value: widget.volume,
                  onChanged: widget.onVolumeChanged,
                ),
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
                    Icons.fast_rewind_outlined,
                    size: 30,
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
                    size: 40.0,
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
                    Icons.fast_forward_outlined,
                    size: 30,
                    color: kColorWhite,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    //
  }

  String _formatDuration(Duration duration) {
    return '${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}';
  }
}
