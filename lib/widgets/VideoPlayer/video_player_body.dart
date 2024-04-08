// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/widgets/VideoPlayer/custom_appbar.dart';
import 'package:video_player_app/widgets/VideoPlayer/video_player_controls.dart';

class VideoPlayerBody extends StatefulWidget {
  final VideoPlayerController controller;
  final String filesV;
  final bool showVolumeSlider;
  final double volumeLevel;
  final ValueChanged<double> onVolumeChanged;
  final Duration fullduration;
  final double position;

  const VideoPlayerBody({
    super.key,
    required this.controller,
    required this.showVolumeSlider,
    required this.volumeLevel,
    required this.onVolumeChanged,
    required this.filesV,
    required this.fullduration,
    required this.position,
  });

  @override
  State<VideoPlayerBody> createState() => _VideoPlayerBodyState();
}

class _VideoPlayerBodyState extends State<VideoPlayerBody> {
  bool isrotated = false;
  bool isFullScreen = false;
  bool areControlsVisible = true;
  Future<void> _toggleRotation() async {
    setState(() async {
      isrotated = !isrotated;
      if (isrotated) {
        await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
        await SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
        ]);
      } else {
        await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  void dispose() {
    super.dispose();
    untoggleRotation();
  }

  void toggleControlsVisibility() {
    setState(() {
      areControlsVisible = !areControlsVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: videoPlayerScreen(),
        ),
        rotateButton(),
        if (areControlsVisible)
          VideoPlayerControls(
            controller: widget.controller,
            fullDuration: widget.fullduration,
            isrotated: isrotated,
            volume: widget.volumeLevel,
            onVolumeChanged: widget.onVolumeChanged,
            current: widget.position,
            file: widget.filesV,
          ),
        if (areControlsVisible)
          VideoPlayerAppbar(
            filename: widget.filesV,
            widget: widget,
            isRotated: isrotated,
          ),
      ],
    );
  }

  GestureDetector videoPlayerScreen() {
    return GestureDetector(
      onDoubleTap: toggleControlsVisibility,
      child: InteractiveViewer(
        maxScale: 5,
        minScale: 1,
        child: Align(
          alignment: areControlsVisible ? Alignment.center : Alignment.center,
          child: AspectRatio(
            aspectRatio: widget.controller.value.aspectRatio,
            child: VideoPlayer(widget.controller),
          ),
        ),
      ),
    );
  }

  Positioned rotateButton() {
    return Positioned(
      right: isrotated ? 50 : 0,
      bottom: isrotated ? 155 : 155,
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
            color: Colors.black26, borderRadius: BorderRadius.circular(20)),
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          onPressed: () {
            _toggleRotation();
            areControlsVisible = false;
          },
          child: Icon(
            isrotated
                ? Icons.screen_rotation_outlined
                : Icons.screen_rotation_outlined,
            color: kColorWhite,
          ),
        ),
      ),
    );
  }

  Future<void> untoggleRotation() async {
    //
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }
}
