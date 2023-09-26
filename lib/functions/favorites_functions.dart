import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:video_player_app/database/favourite_data.dart';

ValueNotifier<List<FavoriteData>> favoriteData =
    ValueNotifier<List<FavoriteData>>([]);

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
    //
  }

  static Future<List<FavoriteData>> getFavoritesList() async {
    try {
      final box = Hive.box<FavoriteData>(_boxName);
      final videos = box.values.toList().cast<FavoriteData>();

      final uniqueVideosMap = <String, FavoriteData>{};

      for (final video in videos) {
        final videoPath = video.filePath;
        final timestamp = video.timestamp;

        if (uniqueVideosMap.containsKey(videoPath)) {
          final existingTimestamp = uniqueVideosMap[videoPath]!.timestamp;
          if (timestamp.isAfter(existingTimestamp)) {
            uniqueVideosMap[videoPath] = video;
          }
        } else {
          uniqueVideosMap[videoPath] = video;
        }
      }

      final uniqueVideos = uniqueVideosMap.values.toList();
      uniqueVideos.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      //
      //

      return uniqueVideos;
    } catch (e) {
      debugPrint('Error retrieving favorites: $e');
      return [];
    }
  }

  static void checkHiveData() async {
    final recentlyPlayedVideos = await getFavoritesList();
    for (final video in recentlyPlayedVideos) {
      debugPrint('Video Path: ${video.filePath}');
      //
    }
  }

  static void deleteVideo(String videoPath, int indexToDelete) async {
    final box = Hive.box<FavoriteData>(_boxName);
    //
    //
    //
    //

    if (indexToDelete != -1) {
      await box.deleteAt(indexToDelete);
      debugPrint('Deleted video: $videoPath');
    } else {
      debugPrint('Video not found: $videoPath');
    }
  }
}
