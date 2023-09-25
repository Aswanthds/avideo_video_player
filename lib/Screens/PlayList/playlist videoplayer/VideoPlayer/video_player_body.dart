// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_app/Screens/playlist/playlist%20videoplayer/VideoPlayer/video_player_appbar.dart';
import 'package:video_player_app/Screens/playlist/playlist%20videoplayer/VideoPlayer/video_player_controls.dart';
import 'package:video_player_app/constants.dart';

class PlayListVideoPlayerBody extends StatefulWidget {
  final VideoPlayerController controller;
  final bool showVolumeSlider;
  final double volumeLevel;
  final ValueChanged<double> onVolumeChanged;
  final Function? onNext;
  final String files;
  final Duration fullduration;

  const PlayListVideoPlayerBody({
    super.key,
    required this.controller,
    required this.showVolumeSlider,
    required this.volumeLevel,
    required this.onVolumeChanged,
    this.onNext,
    required this.files,
    required this.fullduration,
  });

  @override
  State<PlayListVideoPlayerBody> createState() =>
      _PlayListVideoPlayerBodyState();
}

class _PlayListVideoPlayerBodyState extends State<PlayListVideoPlayerBody> {
  bool isRotated = false;
  bool isFullScreen = false;
  bool areControlsVisible = true;
  String? selectedPlaylist;
  void _toggleRotation() {
    setState(() {
      isRotated = !isRotated;
      if (isRotated) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
        ]);
      } else {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: SystemUiOverlay.values);
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      }
    });
  }

  void untoggleRotation() async {
    // Restore all orientations
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  void toggleControlsVisibility() {
    setState(() {
      areControlsVisible = !areControlsVisible;
    });
  }

  @override
  void dispose() {
    untoggleRotation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onDoubleTap: toggleControlsVisibility,
          child: Align(
            alignment: areControlsVisible ? Alignment.center : Alignment.center,
            child: AspectRatio(
              aspectRatio: widget.controller.value.aspectRatio,
              child: VideoPlayer(widget.controller),
            ),
          ),
        ),
        if (areControlsVisible)
          Positioned(
            right: isRotated ? 50 : 0,
            bottom: isRotated ? 120 : 150,
            child: actionButtons(
              orgIcon: Icons.screen_rotation_outlined,
              alticon: Icons.screen_rotation_outlined,
              action: _toggleRotation,
            ),
          ),
        if (areControlsVisible)
          Positioned(
            top: 0,
            left: 0,
            child: VideoPlayerAppBar(
              filename: widget.files,
              controller: widget.controller,
            ),
          ),
        if (areControlsVisible)
          RecentlyVideoPlayerControls(
            controller: widget.controller,
            volume: widget.volumeLevel,
            onVolumeChanged: widget.onVolumeChanged,
            fullDuration: widget.fullduration,
            isRotated: isRotated,
          ),
      ],
    );
  }

  Container actionButtons({
    Function? action,
    required IconData orgIcon,
    IconData? alticon,
  }) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(20),
      ),
      child: FloatingActionButton(
        backgroundColor: Colors.transparent,
        onPressed: () =>
            action?.call(), // Call the function using action?.call()
        child: Icon(
          areControlsVisible ? orgIcon : alticon,
          color: kColorWhite,
        ),
      ),
    );
  }
}
