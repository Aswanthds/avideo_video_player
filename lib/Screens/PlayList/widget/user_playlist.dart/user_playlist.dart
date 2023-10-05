import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_app/Screens/playlist/playlist%20videoplayer/VideoPlayer/video_player_body.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/database/create_playlist_data.dart';
import 'package:video_player_app/functions/recently_played_functions.dart';

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
  int _currentIndex = 0;
  Duration? _fullDuration;
  Duration? current;
  bool disposed = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    _initializeVideoPlayer().then((_) {
      //
      _startUpdatingHiveData();
    });
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  Future<void> _initializeVideoPlayer() async {
    final videoPathList = widget.videoPaths.videos;
    final videoPath = videoPathList![_currentIndex];
    _videoController = VideoPlayerController.file(File(videoPath));

    //
    await _videoController.initialize();

    setState(() {
      _fullDuration = _videoController.value.duration;
      current = _videoController.value.position;
    });

    _videoController.play();
    _videoController.addListener(_updateCurrentPosition);
    _videoController.addListener(_onVideoControllerUpdate);
  }

  void _onVideoControllerUpdate() {
    if (_videoController.value.position >= _videoController.value.duration) {
      _playNextVideo();
    }
  }

  void _playNextVideo() {
    if (_currentIndex < widget.videoPaths.videos!.length - 1) {
      _currentIndex++;
      _videoController.dispose();
      _initializeVideoPlayer();
    }
  }

  String getname() {
    final filename = widget.videoPaths.videos;
    return filename![_currentIndex];
  }

  void _updateCurrentPosition() {
    final currentPosition = _videoController.value.position;
    final fullDuration = _videoController.value.duration;

    setState(() {
      current = currentPosition;
    });

    //
    if (currentPosition >= fullDuration) {
      //
      _videoController.seekTo(Duration.zero);
      _videoController.play();
    }

    //
    _updateHiveData(
      widget.videoPaths.videos![_currentIndex],
      currentPosition,
    );
  }

  void _startUpdatingHiveData() {
    //
    Timer.periodic(const Duration(seconds: 1), (_) {
      if (_videoController.value.isPlaying) {
        final currentPosition = _videoController.value.position;
        //
        _updateHiveData(
          widget.videoPaths.videos![_currentIndex],
          currentPosition,
        );
      }
    });
  }

  void _updateHiveData(String videoPath, Duration currentPosition) {
    //
    if (!disposed) {
      //
      //
      RecentlyPlayed.onVideoClicked(
        videoPath: videoPath,
        current: currentPosition,
        full: _fullDuration ?? Duration.zero,
      );
    }
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
        filesV: getname(),
        position: current!.inMilliseconds.toDouble() ,
        fullduration: _fullDuration ?? Duration.zero,
      ),
    );
  }

  @override
  void dispose() {
    disposed = true;
    _videoController.dispose();
    super.dispose();
  }
}
