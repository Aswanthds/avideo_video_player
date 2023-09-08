import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/widgets/VideoPlayer/vertical_slider.dart';
import 'package:video_player_app/widgets/VideoPlayer/video_player_controls.dart';

class VideoPlayerBody extends StatelessWidget {
  final VideoPlayerController controller;
  final bool showVolumeSlider;
  final double volumeLevel;
  final ValueChanged<double> onVolumeChanged;

  const VideoPlayerBody({
    super.key,
    required this.controller,
    required this.showVolumeSlider,
    required this.volumeLevel,
    required this.onVolumeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: VideoPlayer(controller),
        ),
        if (showVolumeSlider)
          Positioned(
            top: 60,
            left: -40,
            child: VerticalSlider(
              value: volumeLevel,
              onChanged: onVolumeChanged,
            ),
          ),
        Positioned(
          right: 0,
          bottom: 120,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50), color: kcolorblack54),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.fullscreen,
                color: kColorWhite,
              ),
            ),
          ),
        ),
        VideoPlayerControls(
          controller: controller,
        ),
      ],
    );
  }
}
