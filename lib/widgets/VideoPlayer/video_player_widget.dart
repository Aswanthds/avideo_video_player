import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/functions/recently_played_functions.dart';
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
  Duration? _fullDuration;
  Duration? current;
  bool _disposed = false;
  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer().then((_) {
      //
      _startUpdatingHiveData();
    });
  }

  Future<void> _initializeVideoPlayer() async {
    _controller = VideoPlayerController.file(File(widget.filesV));
    await _controller.initialize();
    setState(() {
      _fullDuration = _controller.value.duration;
      current = _controller.value.position;
    });

    _controller.play();
    _controller.addListener(_updateCurrentPosition);
  }

  void _updateCurrentPosition() {
    final currentPosition = _controller.value.position;
    setState(() {
      current = currentPosition;
    });

    //
    _updateHiveData(widget.filesV, currentPosition);
  }

  void _startUpdatingHiveData() {
    //
    Timer.periodic(const Duration(seconds: 1), (_) {
      if (_controller.value.isPlaying) {
        final currentPosition = _controller.value.position;
        //
        _updateHiveData(widget.filesV, currentPosition);
      }
    });
  }

  void _updateHiveData(String videoPath, Duration currentPosition) {
    //
    if (!_disposed) {
      //
      //
      RecentlyPlayed.onVideoClicked(
        videoPath: videoPath,
        current: currentPosition,
        full: _fullDuration,
      );
    }
  }

  void toggleVolumeSlider() {
    setState(() {
      _showVolumeSlider = !_showVolumeSlider;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kcolorblack,
      body: VideoPlayerBody(
        controller: _controller,
        showVolumeSlider: _showVolumeSlider,
        volumeLevel: _volumeLevel,
        onVolumeChanged: (newValue) {
          setState(() {
            _volumeLevel = newValue;
            _controller.setVolume(newValue);
          });
        },
        filesV: widget.filesV,
        fullduration: _fullDuration ?? Duration.zero,
      ),
    );
  }

  @override
  void dispose() {
    _disposed = true;
    _controller.dispose();
    super.dispose();
  }
}
