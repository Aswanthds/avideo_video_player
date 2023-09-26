import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:external_path/external_path.dart';

class PathFunctions {
  static Future<List<String>> getDevicepath() async {
    var paths = await ExternalPath.getExternalStorageDirectories();
    for (final String path in paths) {
      debugPrint(path);
    }
    return paths;
  }

  static Future<List<String>> getPath() async {
    bool isVideoFile(File file) {
      final String extension = file.path.split('.').last.toLowerCase();
      return extension == 'mp4' ||
          extension == 'mov' ||
          extension == 'avi' ||
          extension == 'mkv';
    }

    final rootDirectories = await getDevicepath();
    List<String> restrictedDirectories = [
      '/storage/emulated/0/Android/data',
      '/storage/emulated/0/Android'
    ];

    List<String> paths = [];

    try {
      for (final String rootPath in rootDirectories) {
        final Directory root = Directory(rootPath);

        if (restrictedDirectories.contains(rootPath)) {
          continue; //
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
}
