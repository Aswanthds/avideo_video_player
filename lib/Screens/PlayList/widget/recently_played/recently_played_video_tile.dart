import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:video_player_app/constants.dart';
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
  @override
  void initState() {
    super.initState();
    //
    loadVideoInfo();
  }

  Future<void> loadVideoInfo() async {
    if (widget.index < widget.files.length) {
      final videoPath = widget.files[widget.index].videoPath;
      final recentlyPlayedList =
          Hive.box<RecentlyPlayedData>('recently_played');

      //
      final matchingData = recentlyPlayedList.values.firstWhere(
        (data) {
          return data.videoPath == videoPath;
        },
        orElse: () => RecentlyPlayedData(
          timestamp: DateTime.now(),
          videoPath: videoPath,
          current: Duration.zero,
          full: Duration.zero,
        ),
      );

      setState(() {
        currentTimestamp = matchingData.current!;
        fullTimestamp = matchingData.full!;
      });
    }
  }

  Duration currentTimestamp = Duration.zero;
  Duration fullTimestamp = Duration.zero;

  @override
  Widget build(BuildContext context) {
    return (widget.files.length > widget.index || widget.files.isEmpty && widget.files.isNotEmpty)
        ? RecentlyPlayedVideoTileWidget(
            current: currentTimestamp.inMilliseconds.toDouble(),
            full: fullTimestamp.inMilliseconds.toDouble(),
            files: widget.files,
            index: widget.index,
            thumbnail: widget.thumbnail,
          )
        : const Center(child: nodata,);
  }
}
