import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/widgets/VideoPlayer/custom_appbar.dart';
import 'package:video_player_app/widgets/VideoPlayer/video_player_body.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String filesV;
  const VideoPlayerScreen({super.key, required this.filesV});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  double _volumeLevel = 1.0;
  bool _showVolumeSlider = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.filesV));
    _controller.initialize().then((_) {
      setState(() {});
    });
  }

  void toggleVolumeSlider() {
    setState(() {
      _showVolumeSlider = !_showVolumeSlider;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filename = basename(widget.filesV);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85),
        child: CustomAppBar(
          filename: filename,
          toggleVolumeSlider: toggleVolumeSlider,
        ),
      ),
      backgroundColor: kcolorblack,
      body: Center(
        child: VideoPlayerBody(
          controller: _controller,
          showVolumeSlider: _showVolumeSlider,
          volumeLevel: _volumeLevel,
          onVolumeChanged: (newValue) {
            setState(() {
              _volumeLevel = newValue;
              _controller.setVolume(newValue);
            });
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
