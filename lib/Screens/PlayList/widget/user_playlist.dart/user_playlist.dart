import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_app/Screens/playlist/playlist%20videoplayer/VideoPlayer/video_player_body.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/database/create_playlist_data.dart';

class VideoPlaylistScreen extends StatefulWidget {
  final VideoPlaylist videoPaths;
  final int currentIndex;

  const VideoPlaylistScreen({
    Key? key,
    required this.videoPaths,
    required this.currentIndex,
  }) : super(key: key);

  @override
  State<VideoPlaylistScreen> createState() => _VideoPlaylistScreenState();
}

class _VideoPlaylistScreenState extends State<VideoPlaylistScreen> {
  late VideoPlayerController _videoController;
  double _volumeLevel = 1.0;
  final bool _showVolumeSlider = false;
  Duration? fullDuration;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
    _initializeVideoController();
  }

  void _initializeVideoController() {
    final videoPathLsit = widget.videoPaths.videos;
    final videopath = videoPathLsit![_currentIndex];
    _videoController = VideoPlayerController.file(File(videopath))
      ..initialize().then((_) {
        setState(() {});
        _videoController.play();
        fullDuration =  _videoController.value.duration;
      });
  }

  String getname() {
    final filenmae = widget.videoPaths.videos;
    // debugPrint('String  $filenmae');
    return filenmae![_currentIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcolorblack,
      body: PlayListVideoPlayerBody(
        controller: _videoController,
        showVolumeSlider: _showVolumeSlider,
        volumeLevel: _volumeLevel,
        onVolumeChanged: (newValue) {
          setState(() {
            _volumeLevel = newValue;
            _videoController.setVolume(newValue);
          });
        },
        files: getname(),
        fullduration: fullDuration!,
      ),
    );
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }
}
