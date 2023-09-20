import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_app/Screens/playlist/playlist%20videoplayer/VideoPlayer/video_player_appbar.dart';
import 'package:video_player_app/Screens/playlist/playlist%20videoplayer/VideoPlayer/video_player_controls.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/widgets/VideoPlayer/vertical_slider.dart';

class PlayListVideoPlayerBody extends StatefulWidget {
  final VideoPlayerController controller;

  final bool showVolumeSlider;
  final double volumeLevel;
  final ValueChanged<double> onVolumeChanged;
  final Function? onNext;
  final String files;

  const PlayListVideoPlayerBody({
    super.key,
    required this.controller,
    required this.showVolumeSlider,
    required this.volumeLevel,
    required this.onVolumeChanged,
    this.onNext,
    required this.files,
  });

  @override
  State<PlayListVideoPlayerBody> createState() =>
      _PlayListVideoPlayerBodyState();
}

class _PlayListVideoPlayerBodyState extends State<PlayListVideoPlayerBody> {
  bool isrotated = false;
  bool isFullScreen = false;
  void _toggleRotation() {
    setState(() {
      isrotated = !isrotated;
      if (isrotated) {
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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    untoggleRotation();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AspectRatio(
          aspectRatio: widget.controller.value.aspectRatio,
          child: VideoPlayer(widget.controller),
        ),
        if (widget.showVolumeSlider)
          Positioned(
            top: 60,
            left: -40,
            child: VerticalSlider(
              value: widget.volumeLevel,
              onChanged: widget.onVolumeChanged,
            ),
          ),
        Positioned(
          left: isrotated ? 50 : 0,
          top: 75,
          child: actionButtons(
            orgIcon: Icons.volume_up_sharp,
            alticon: Icons.volume_up_sharp,
            action: () => widget.showVolumeSlider,
          ),
        ),
        Positioned(
          right: isrotated ? 50 : 0,
          bottom: 120,
          child: actionButtons(
              orgIcon: Icons.screen_rotation_outlined,
              alticon: Icons.screen_rotation_outlined,
              action: _toggleRotation),
        ),
        Positioned(
          left: 5,
          bottom: 120,
          child: actionButtons(
              orgIcon: Icons.fullscreen, alticon: Icons.fullscreen_exit),
        ),
        RecentlyVideoPlayerControls(
          controller: widget.controller,
        ),
        Positioned(
          top: isrotated ? 0 : 20,
          left: 0,
          child: VideoPlayerAppBar(
            filename: widget.files,
          ),
        ),
        RecentlyVideoPlayerControls(
          controller: widget.controller,
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
          color: Colors.black26, borderRadius: BorderRadius.circular(20)),
      child: FloatingActionButton(
        backgroundColor: Colors.transparent,
        onPressed: () => action,
        child: Icon(
          isFullScreen ? orgIcon : alticon,
          color: kColorWhite,
        ),
      ),
    );
  }
}
