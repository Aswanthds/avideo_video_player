import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_app/Screens/playlist/playlist%20videoplayer/VideoPlayer/video_player_body.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/database/recently_video_data.dart';
import 'package:video_player_app/functions/recently_played_functions.dart';

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
  }

  Future<void> _initializeVideoPlayer() async {
    final videoPathLsit = widget.videoPaths.map((e) => e.videoPath).toList();
    final videopath = videoPathLsit[_currentIndex];
    _videoController = VideoPlayerController.file(File(videopath));

    //
    await _videoController.initialize();
    final currentPosition = widget.videoPaths[_currentIndex].current;
    if (currentPosition != null) {
      await _videoController.seekTo(currentPosition);
    }

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
    if (_currentIndex < widget.videoPaths.length - 1) {
      _currentIndex++;
      _videoController.dispose();
      _initializeVideoPlayer();
    }
  }

  String getname() {
    final filenmae = widget.videoPaths.map((e) => e.videoPath).toList();
    //
    return filenmae[_currentIndex];
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
      widget.videoPaths[_currentIndex].videoPath,
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
            widget.videoPaths[_currentIndex].videoPath, currentPosition);
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
        files: getname(),
        onNext: () => _playNextVideo(),
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
