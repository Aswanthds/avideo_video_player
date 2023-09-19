import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/widgets/VideoPlayer/vertical_slider.dart';
import 'package:video_player_app/widgets/VideoPlayer/video_player_controls.dart';

class VideoPlayerBody extends StatefulWidget {
  final VideoPlayerController controller;
  final String filesV;
  final bool showVolumeSlider;
  final double volumeLevel;
  final ValueChanged<double> onVolumeChanged;
  final Duration fullduration;

  const VideoPlayerBody({
    super.key,
    required this.controller,
    required this.showVolumeSlider,
    required this.volumeLevel,
    required this.onVolumeChanged,
    required this.filesV,
    required this.fullduration,
  });

  @override
  State<VideoPlayerBody> createState() => _VideoPlayerBodyState();
}

class _VideoPlayerBodyState extends State<VideoPlayerBody> {
  bool isrotated = false;
  bool isFullScreen = false;
  // bool _showVolumeSlider = false;
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
    final filename = basename(widget.filesV);
    return Stack(
      alignment: Alignment.center,
      children: [
        AspectRatio(
          aspectRatio: widget.controller.value.aspectRatio,
          child: VideoPlayer(widget.controller),
        ),
        Positioned(
          right: isrotated ? 50 : 0,
          bottom: isrotated ? 120 : 150,
          child: Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
                color: Colors.black26, borderRadius: BorderRadius.circular(20)),
            child: FloatingActionButton(
              backgroundColor: Colors.transparent,
              onPressed: () => _toggleRotation(),
              child: Icon(
                isrotated
                    ? Icons.screen_rotation_outlined
                    : Icons.screen_rotation_outlined,
                color: kColorWhite,
              ),
            ),
          ),
        ),
        Positioned(
          left: 5,
          bottom: isrotated ? 120 : 150,
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: Colors.black26, borderRadius: BorderRadius.circular(20)),
            child: FloatingActionButton(
              backgroundColor: Colors.transparent,
              onPressed: () {},
              child: Icon(
                isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
                color: kColorWhite,
              ),
            ),
          ),
        ),
        VideoPlayerControls(
          controller: widget.controller,
          fullDuration: widget.fullduration,
          isrotated: isrotated,
        ),
        Positioned(
          top: isrotated ? 0 : 20,
          left: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: kcolorblack54,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  IconButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: kColorWhite,
                      )),
                  Expanded(
                    child: Text(
                      filename,
                      style: const TextStyle(
                        color: kColorWhite,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.more_vert,
                    color: kColorWhite,
                  )
                ]),
          ),
        ),
      ],
    );
  }

  void untoggleRotation() async {
    // Restore all orientations
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }
}
