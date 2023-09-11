import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:video_player_app/database/video_data.dart';

class RecentlyPlayed {
  static const String _boxName = 'recently_played';

  static Future<void> init() async {
    await Hive.openBox<VideoData>(_boxName);
  }

  static void onVideoClicked(String videoPath) async {
    final box = await Hive.openBox<VideoData>(_boxName);

    final videoData =
        VideoData(videoPath: videoPath, timestamp: DateTime.now());

    // Save videoData to the box
    await box.add(videoData);

    // Print the video path for debugging
    debugPrint('Video clicked and added to Hive: $videoPath');
  }

  static List<VideoData> getRecentlyPlayedVideos() {
    final box = Hive.box<VideoData>(_boxName);
    final videos = box.values.toList().cast<VideoData>();

    // Create a Map to store unique video data with the latest timestamp
    final uniqueVideosMap = <String, VideoData>{};

    for (final videoData in videos) {
      final videoPath = videoData.videoPath;
      final timestamp = videoData.timestamp;

      // Check if we've already encountered this video path
      if (uniqueVideosMap.containsKey(videoPath)) {
        // Compare timestamps and update if the current timestamp is later
        final existingTimestamp = uniqueVideosMap[videoPath]!.timestamp;
        if (timestamp.isAfter(existingTimestamp)) {
          uniqueVideosMap[videoPath] = videoData;
        }
      } else {
        // If this video path is encountered for the first time, add it to the map
        uniqueVideosMap[videoPath] = videoData;
      }
    }

    // Convert the map back to a list and sort it by timestamp
    final uniqueVideos = uniqueVideosMap.values.toList();
    uniqueVideos.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    debugPrint(uniqueVideos.length.toString());

    return uniqueVideos;
  }

  static void checkHiveData() {
    final recentlyPlayedVideos = RecentlyPlayed.getRecentlyPlayedVideos();
    for (final videoData in recentlyPlayedVideos) {
      debugPrint('Video Path: ${videoData.videoPath}');
      debugPrint('Timestamp: ${videoData.timestamp}');
    }
  }

  static void deleteVideo(String videoPath) async {
    final box = Hive.box<VideoData>(_boxName);

    // Find the video to delete by its path
    final videoToDelete = box.values.firstWhere(
      (videoData) => videoData.videoPath == videoPath,
    );

    if (videoToDelete != null) {
      // Remove the video from the box
      await box.delete(videoToDelete.videoPath);

      // Print for debugging
      debugPrint('Deleted video: $videoPath');
    }

    // Update the UI by loading the recently played videos again
    getRecentlyPlayedVideos();
  }
}
