import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class PathFunctions {
  static Future<List<String>> getPath() async {
    bool isVideoFile(File file) {
      final String extension = file.path.split('.').last.toLowerCase();
      return extension == 'mp4' ||
          extension == 'mov' ||
          extension == 'avi' ||
          extension == 'mkv';
    }

    Directory root = Directory('/storage/emulated/0/');
    List<String> paths = [];

    try {
      final List<FileSystemEntity> allFiles = root.listSync(recursive: true);

      for (final FileSystemEntity entity in allFiles) {
        if (entity is File && isVideoFile(entity)) {
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

    box.put('videos', videos);
  }

}
 