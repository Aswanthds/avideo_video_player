import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/functions/video_functions.dart';
import 'package:video_player_app/widgets/VideoPlayer/vertical_slider.dart';
import 'package:video_player_app/widgets/dummy.dart';

class VideoPlayerControls extends StatefulWidget {
  final VideoPlayerController controller;
  final Duration fullDuration;
  final bool isrotated;
  final double volume;
  final ValueChanged<double> onVolumeChanged;
  final double current;
  final String file;

  const VideoPlayerControls({
    super.key,
    required this.controller,
    required this.fullDuration,
    required this.isrotated,
    required this.volume,
    required this.onVolumeChanged,
    required this.current,
    required this.file,
  });

  @override
  State<VideoPlayerControls> createState() => _VideoPlayerControlsState();
}

class _VideoPlayerControlsState extends State<VideoPlayerControls> {
  bool areControlsVisible = true;
  double videoPosition = 0.0;
  bool ismute = false;
  void toggleControlsVisibility() {
    setState(() {
      areControlsVisible = !areControlsVisible;
    });
  }

  String? duration;
  @override
  void initState() {
    widget.controller.addListener(() {
      setState(() {
        videoPosition = widget.controller.value.position.inSeconds.toDouble();
      });
    });
    super.initState();
  }

  Future<void> getDuration() async {
    try {
      final videoDuration = await VideoFunctions.getVideoDuration(widget.file);
      if (mounted) {
        setState(() {
          duration = videoDuration;
        });
      }
    } catch (e) {
      debugPrint('Unhandled Exception $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: widget.isrotated ? 145 : 155,
        decoration: const BoxDecoration(
          color: kcolorblack54,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20, top: 20, bottom: 10),
              child: CustomVideoProgressIndicator(
                widget.controller,
                allowScrubbing: true,
                current: widget.current,
                duration: widget.fullDuration.inMicroseconds.toDouble(),
              ),
            ),
            Row(
              mainAxisAlignment: widget.isrotated
                  ? MainAxisAlignment.spaceEvenly
                  : MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      ismute = !ismute;
                      if (ismute) {
                        widget.controller.setVolume(0.0);
                      } else {
                        widget.controller.setVolume(widget.volume);
                      }
                    });
                  },
                  icon: ismute
                      ? const Icon(
                          Icons.volume_off,
                          size: 25,
                          color: kColorWhite,
                        )
                      : const Icon(
                          Icons.volume_up,
                          size: 25,
                          color: kColorWhite,
                        ),
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
            )
          ],
        ),
      ),
    );
  }
}
