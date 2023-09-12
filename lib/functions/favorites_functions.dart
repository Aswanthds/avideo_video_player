import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:video_player_app/database/favourite_data.dart';
import 'package:video_player_app/database/video_data.dart';

class FavoriteFunctions {
  static const String _boxName = 'favorite_videos';

  static Future<void> addToFavorites(FavoriteData video) async {
    final box = await Hive.openBox<FavoriteData>(_boxName);
    await box.add(video);
  }

  static Future<void> addToFavoritesList(String path) async {
    final videoToAdd = FavoriteData(
      filePath: path,
      timestamp: DateTime.now(),
    );

    addToFavorites(videoToAdd);
  }

  static List<FavoriteData> getFavoritesList() {
    final box = Hive.box<FavoriteData>(_boxName);
    final videos = box.values.toList().cast<FavoriteData>();

    final uniqueVideosMap = <String, FavoriteData>{};

    for (final Video in videos) {
      final videoPath = Video.filePath;
      final timestamp = Video.timestamp;

      if (uniqueVideosMap.containsKey(videoPath)) {
        final existingTimestamp = uniqueVideosMap[videoPath]!.timestamp;
        if (timestamp.isAfter(existingTimestamp)) {
          uniqueVideosMap[videoPath] = Video;
        }
      } else {
        uniqueVideosMap[videoPath] = Video;
      }
    }

    final uniqueVideos = uniqueVideosMap.values.toList();
    uniqueVideos.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    debugPrint(uniqueVideos.length.toString());

    return uniqueVideos;
  }

  static void checkHiveData() {
    final recentlyPlayedVideos = getFavoritesList();
    for (final Video in recentlyPlayedVideos) {
      debugPrint('Video Path: ${Video.filePath}');
      debugPrint('Timestamp: ${Video.timestamp}');
    }
  }

  static void deleteVideo(String videoPath) async {
    final box = Hive.box<FavoriteData>(_boxName);

    final videoToDelete = box.values.firstWhere(
      (Video) => Video.filePath == videoPath,
    );

    if (videoToDelete != null) {
      await box.delete(videoToDelete.filePath);

      debugPrint('Deleted video: $videoPath');
    }

    getFavoritesList();
  }
}
