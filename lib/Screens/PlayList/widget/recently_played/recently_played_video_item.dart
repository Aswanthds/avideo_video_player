import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player_app/Screens/playlist/widget/recently_played/error_video_tile.dart';
import 'package:video_player_app/Screens/playlist/widget/recently_played/recently_played_video_tile.dart';
import 'package:video_player_app/Screens/playlist/widget/recently_played/loading_video_tile.dart';
import 'package:video_player_app/Screens/playlist/widget/recently_played/thumbnot_video_tile.dart';
import 'package:video_player_app/database/video_data.dart';
import 'package:video_player_app/functions/recently_played_functions.dart';

class RecentlyPlayedVideoItem extends StatelessWidget {
  final List<RecentlyPlayedData> videoData;
  final int index;

  const RecentlyPlayedVideoItem({
    Key? key,
    required this.videoData,
    required this.index,
  }) : super(key: key);

  Future<Uint8List> generateThumbnail(String path) async {
    try {
      final thumbnailFile = await VideoCompress.getByteThumbnail(
        path,
        quality: 10,
        position: -1,
      );
      return thumbnailFile!;
    } catch (e) {
      debugPrint('Error generating thumbnail: $e');
      return Uint8List(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final videoPath = videoData[index].videoPath;
    final timestamp =
        DateFormat('dd-MMM-yyyy HH:mm').format(videoData[index].timestamp);

    return FutureBuilder<Uint8List>(
      future: generateThumbnail(videoPath),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return RecentlyPlayedLoadingVideListTile(
            videoPath: videoPath,
            timestamp: timestamp,
          );
        } else if (snapshot.hasError) {
          return RecentlyPlayedErrorVideListTile(videoPath: videoPath);
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return RecentlyPlayedThumbNotVideListTile(videoPath: videoPath);
        } else {
          return ValueListenableBuilder<List<RecentlyPlayedData>>(
            valueListenable: recentlyPlayedVideos,
            builder: (BuildContext context, List<RecentlyPlayedData> value,
                    Widget? child) =>
                RecentlyPlayedVideoTile(
              thumbnail: snapshot.data!,
              files: videoData,
              index: index,
            ),
          );
        }
      },
    );
  }
}