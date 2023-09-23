import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:video_player_app/database/recently_video_data.dart';
import 'package:flutter/material.dart';

import 'package:video_player_app/screens/PlayList/widget/recently_played/video_tile_recently.dart';


class RecentlyPlayedVideoTile extends StatefulWidget {
  final List<RecentlyPlayedData> files;
  final int index;
  final File thumbnail;

  const RecentlyPlayedVideoTile({
    Key? key,
    required this.thumbnail,
    required this.files,
    required this.index,
  }) : super(key: key);

  @override
  State<RecentlyPlayedVideoTile> createState() =>
      _RecentlyPlayedVideoTileState();
}

class _RecentlyPlayedVideoTileState extends State<RecentlyPlayedVideoTile> {
  Duration? currentTimestamp;
  Duration? fullTimestamp;

  @override
  void initState() {
    super.initState();
    // Load video info when the widget is created
    loadVideoInfo();
  }

  Future<void> loadVideoInfo() async {
    final videoPath = widget.files[widget.index].videoPath;
    final recentlyPlayedList = Hive.box<RecentlyPlayedData>('recently_played');

    // Find the RecentlyPlayedData object with the matching videoPath
    final matchingData = recentlyPlayedList.values.firstWhere(
      (data) => data.videoPath == videoPath,
      orElse: () => RecentlyPlayedData(
          timestamp: DateTime.now(),
          videoPath: videoPath,
          current: Duration.zero,
          full: Duration.zero),
    );

    setState(() {
      currentTimestamp = matchingData.current;
      fullTimestamp = matchingData.full;
    });
  }

  @override
  void didUpdateWidget(covariant RecentlyPlayedVideoTile oldWidget) {
    if (oldWidget.files != widget.files && mounted) {
      // Update video info when the widget receives new data
      loadVideoInfo();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (currentTimestamp != null &&
        fullTimestamp != null &&
        widget.files.length >= widget.index) {
      return RecentlyPlayedVideoTileWidget(
        current: currentTimestamp!.inMilliseconds.toDouble(),
        full: fullTimestamp!.inMilliseconds.toDouble(),
        files: widget.files,
        index: widget.index,
        thumbnail: widget.thumbnail,
      );
    } else {
      return const SizedBox();
    }
  }
}
