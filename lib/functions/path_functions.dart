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

  static Future<void> seperateVideos() async {
    Map<String, String> pathsAndParents = {};

    List<String> paths = await getPath();

    for (String path in paths) {
      String parentFolder = path.split('/').last;

      pathsAndParents[path] = parentFolder;
    }
  }
}
