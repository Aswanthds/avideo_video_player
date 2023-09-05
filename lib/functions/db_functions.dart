import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class VideoFunctions {
  static Future<List<String>> getPath() async {
    bool _isVideoFile(File file) {
      final String extension = file.path.split('.').last.toLowerCase();
      return extension == 'mp4' ||
          extension == 'mov' ||
          extension == 'avi' ||
          extension == 'mkv';
    }

    Directory root = Directory('/storage/emulated/0');
    List<String> paths = [];

    try {
      final List<FileSystemEntity> allFiles = root.listSync(recursive: true);

      for (final FileSystemEntity entity in allFiles) {
        if (entity is File && _isVideoFile(entity)) {
          paths.add(entity.path);
        }
      }
    } catch (e) {
      debugPrint('Error getting video files: $e');
    }
    debugPrint(paths.toString());
    return paths;
  }

  static Future<void> storeVideos() async {
    final videos = await getPath();

    if (!Hive.isBoxOpen('videos')) {
      await Hive.openBox<List<String>>('videos');
    }

    final box = Hive.box<List<String>>('videos');

    // Store the videos list using the key 'videos'
    box.put('videos', videos);
  }
}
 // FetchAllVideos ob = FetchAllVideos();
    // List<dynamic> videos = await ob.getAllVideos();
    // debugPrint('Fetched video data: $videos');