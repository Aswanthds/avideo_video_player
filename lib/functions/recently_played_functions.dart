import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:video_player_app/database/video_data.dart';

class RecentlyPlayed {
  static const String _boxName = 'recently_played';

  static Future<void> init() async {
    await Hive.openBox<RecentlyPlayedData>(_boxName);
  }

  static void onVideoClicked(String videoPath) async {
    final box = await Hive.openBox<RecentlyPlayedData>(_boxName);

    final videoData =
        RecentlyPlayedData(videoPath: videoPath, timestamp: DateTime.now());

    
    await box.add(videoData);

    
    debugPrint('Video clicked and added to Hive: $videoPath');
  }

  static List<RecentlyPlayedData> getRecentlyPlayedVideos() {
    final box = Hive.box<RecentlyPlayedData>(_boxName);
    final videos = box.values.toList().cast<RecentlyPlayedData>();

    
    final uniqueVideosMap = <String, RecentlyPlayedData>{};

    for (final videoData in videos) {
      final videoPath = videoData.videoPath;
      final timestamp = videoData.timestamp;

      
      if (uniqueVideosMap.containsKey(videoPath)) {
        
        final existingTimestamp = uniqueVideosMap[videoPath]!.timestamp;
        if (timestamp.isAfter(existingTimestamp)) {
          uniqueVideosMap[videoPath] = videoData;
        }
      } else {
        
        uniqueVideosMap[videoPath] = videoData;
      }
    }

    
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
    final box = Hive.box<RecentlyPlayedData>(_boxName);

    
    final videoToDelete = box.values.firstWhere(
      (videoData) => videoData.videoPath == videoPath,
    );

    if (videoToDelete != null) {
      
      await box.delete(videoToDelete.videoPath);

      
      debugPrint('Deleted video: $videoPath');
    }

    
    getRecentlyPlayedVideos();
  }
}
