import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player_app/Screens/playlist/widget/recently_played/error_video_tile.dart';
import 'package:video_player_app/Screens/playlist/widget/recently_played/recently_played_video_tile.dart';
import 'package:video_player_app/Screens/playlist/widget/recently_played/loading_video_tile.dart';
import 'package:video_player_app/Screens/playlist/widget/recently_played/thumbnot_video_tile.dart';
import 'package:video_player_app/database/recently_video_data.dart';

class RecentlyPlayedVideoItem extends StatelessWidget {
  final List<RecentlyPlayedData> videoData;
  final int index;

  const RecentlyPlayedVideoItem({
    Key? key,
    required this.videoData,
    required this.index,
  }) : super(key: key);

  Future<File> generateThumbnail(String path) async {
    final videoFile = File(path);
    final isValidVideo = videoFile.existsSync();

    if (!isValidVideo) {
      // Skip invalid video paths
      return File(''); // Return an empty SizedBox
    }

    try {
      final thumbnailFile = await VideoCompress.getFileThumbnail(
        path,
        quality: 10,
        position: -1,
      );
      return thumbnailFile;
    } catch (e) {
      debugPrint('Error generating thumbnail: $e');
      return File('');
    }
  }

  @override
  Widget build(BuildContext context) {
    final videoPath = videoData[index].videoPath;
    final timestamp =
        DateFormat('dd-MMM-yyyy HH:mm').format(videoData[index].timestamp);

    return FutureBuilder<File>(
      future: generateThumbnail(videoPath),
      builder: (context, snapshot) {
        final videoFile = File(videoPath);
        final isValidVideo = videoFile.existsSync();

        if (!isValidVideo) {
          // Skip invalid video paths
          return const SizedBox(); // Return an empty SizedBox
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return RecentlyPlayedLoadingVideListTile(
            videoPath: videoPath,
            timestamp: timestamp,
          );
        } else if (snapshot.hasError) {
          return RecentlyPlayedErrorVideListTile(videoPath: videoPath);
        } else if (!snapshot.hasData) {
          return RecentlyPlayedThumbNotVideListTile(videoPath: videoPath);
        } else {
          return RecentlyPlayedVideoTile(
            thumbnail: snapshot.data!,
            files: videoData,
            index: index,
          );
        }
      },
    );
  }
}
