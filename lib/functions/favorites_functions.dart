import 'dart:io';

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
    try {
      if (File(path).existsSync()) {
        final videoToAdd = FavoriteData(
          filePath: path,
          timestamp: DateTime.now(),
        );
        debugPrint('video added $path');
        addToFavorites(videoToAdd);
      } else {
        return;
      }
    } catch (e) {
      debugPrint('Error occured on $path');
    }
  }

  static Future<List<FavoriteData>> getFavoritesList() async {
    try {
      final box = Hive.box<FavoriteData>(_boxName);
      final videos = box.values.toList().cast<FavoriteData>();

      final uniqueVideosMap = <String, FavoriteData>{};

      for (final video in videos) {
        final videoPath = video.filePath;
        final timestamp = video.timestamp;

        if (File(videoPath).existsSync()) {
          if (uniqueVideosMap.containsKey(videoPath)) {
            final existingTimestamp = uniqueVideosMap[videoPath]!.timestamp;
            if (timestamp.isAfter(existingTimestamp)) {
              uniqueVideosMap[videoPath] = video;
            }
          } else {
            uniqueVideosMap[videoPath] = video;
          }
        }
      }

      final uniqueVideos = uniqueVideosMap.values.toList();
      uniqueVideos.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      return uniqueVideos;
    } catch (e) {
      debugPrint('Error retrieving favorites: $e');
      return [];
    }
  }

  static List<FavoriteData> removeDuplicateVideos(List<FavoriteData> list) {
    final Set<String> uniqueVideoPaths = <String>{};

    final List<FavoriteData> data = [];

    for (final video in list) {
      final videoPath = video.filePath;
      if (!uniqueVideoPaths.contains(videoPath)) {
        uniqueVideoPaths.add(videoPath);
        if (File(videoPath).existsSync()) {
          data.add(video);
        }
      }
    }

    return data;
  }

  static void checkHiveData() async {
    final recentlyPlayedVideos = await getFavoritesList();
    for (final video in recentlyPlayedVideos) {
      debugPrint('Video Path: ${video.filePath}');
    }
  }

  static Future<void> deleteVideo(String videoPath) async {
    final box = Hive.box<FavoriteData>(_boxName);

    final List<int> indexesToDelete = [];

    for (var i = 0; i < box.length; i++) {
      final item = box.getAt(i);
      if (item != null && item.filePath == videoPath) {
        indexesToDelete.add(i);
      }
    }

    for (var i = indexesToDelete.length - 1; i >= 0; i--) {
      final indexToDelete = indexesToDelete[i];
      await box.deleteAt(indexToDelete);
    }

    debugPrint('Deleted all occurrences of video: $videoPath');
  }
}
