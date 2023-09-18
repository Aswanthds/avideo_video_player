import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_app/Screens/playlist/playlist%20videoplayer/VideoPlayer/video_player_body.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/database/video_data.dart';

class RecentlyPlayedVideoScreen extends StatefulWidget {
  final List<RecentlyPlayedData> videoPaths;
  final int currentIndex;

  const RecentlyPlayedVideoScreen({
    Key? key,
    required this.videoPaths,
    required this.currentIndex,
  }) : super(key: key);

  @override
  State<RecentlyPlayedVideoScreen> createState() =>
      _RecentlyPlayedVideoScreenState();
}

class _RecentlyPlayedVideoScreenState extends State<RecentlyPlayedVideoScreen> {
  late VideoPlayerController _videoController;
  double _volumeLevel = 1.0;
  final bool _showVolumeSlider = false;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
    _initializeVideoController();
  }

  void _initializeVideoController() {
    final videoPathLsit = widget.videoPaths.map((e) => e.videoPath).toList();
    final videopath = videoPathLsit[_currentIndex];
    _videoController = VideoPlayerController.file(File(videopath))
      ..initialize().then((_) {
        setState(() {});
        _videoController.play();
      });
    _videoController.addListener(_onVideoControllerUpdate);
  }

  void _onVideoControllerUpdate() {
    if (_videoController.value.position >= _videoController.value.duration) {
      _playNextVideo();
    }
  }

  void _playNextVideo() {
    if (_currentIndex < widget.videoPaths.length - 1) {
      _currentIndex++;
      _videoController.dispose();
      _initializeVideoController();
    }
  }

  String getname() {
    final filenmae = widget.videoPaths.map((e) => e.videoPath).toList();
    debugPrint('String  $filenmae');
    return filenmae[_currentIndex];
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
        onNext: ()=> _playNextVideo(),
      ),
    );
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }
}
