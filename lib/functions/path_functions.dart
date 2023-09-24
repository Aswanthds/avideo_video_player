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

    List<String> restrictedDirectories = [
      '/storage/emulated/0/Android/data',
      '/storage/emulated/0/Android'
    ];
    List<String> rootDirectories = [
      '/storage/sdcard1', // Add your first directory
      '/storage/emulated/0/', // Add your second directory
    ];
    List<String> paths = [];

    try {
      for (final String rootPath in rootDirectories) {
        final Directory root = Directory(rootPath);

        if (restrictedDirectories.contains(rootPath)) {
          continue; // Skip if the root directory doesn't exist
        }

        final List<FileSystemEntity> allFiles =
            await root.list(recursive: true).toList();

        for (final FileSystemEntity entity in allFiles) {
          if (entity is File && isVideoFile(entity)) {
            paths.add(entity.path);
          }
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
