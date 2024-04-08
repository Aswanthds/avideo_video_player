import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:device_info_plus/device_info_plus.dart';

class PathFunctions {
  static Future<List<String>> getVideoPathsAsync() async {
    bool isVideoFile(String file) {
      final String extension = file.split('.').last.toLowerCase();
      return extension == 'mp4' ||
          extension == 'mov' ||
          extension == 'avi' ||
          extension == 'mkv';
    }

    List<String> videoPaths = [];
    List<String> restrictedFiles = [
      '/storage/emulated/0/Android',
      '/storage/emulated/0/Android/obb',
      '/storage/emulated/0/Android/data',
    ];

    List<String> paths = [];
    final deviceInfo = await DeviceInfoPlugin().androidInfo;
    final sdkVersion = deviceInfo.version.sdkInt;

    if (sdkVersion >= 31) {
      Directory root = Directory('/storage/emulated/0/Android');
      root.listSync().forEach((element) {
        paths.add(element.path);
      });
      root = Directory('/storage/emulated/0');
      root.listSync().forEach((element) {
        if (element is File &&
            !element.path.contains('/cache/') &&
            !element.path.contains('Gifs') &&
            isVideoFile(element.path) &&
            element.existsSync()) {
          videoPaths.add(element.path);
        } else {
          paths.add(element.path);
        }
      });
      for (final resPath in restrictedFiles) {
        if (paths.contains(resPath)) {
          paths.remove(resPath);
        }
      }
      for (final path in paths) {
        Directory root = Directory(path);
        root.listSync(recursive: true).forEach((element) {
          if (isVideoFile(element.path) &&
              element.existsSync() &&
              !element.path.contains('/cache/')) {
            videoPaths.add(element.path);
          }
        });
      }
    } else {
      try {
        Directory root = Directory('/storage/emulated/0/');
        await for (final FileSystemEntity entity
            in root.list(recursive: true)) {
          if (entity is File &&
              !entity.path.contains('/cache/') &&
              !entity.path.contains('Gifs') &&
              isVideoFile(entity.path) &&
              entity.existsSync()) {
            videoPaths.add(entity.path);
          }
        }
      } catch (e) {
        debugPrint('Error getting video files: $e');
        return [];
      }
    }
    return videoPaths;
  }

  static Future<void> storeVideos() async {
    final videos = await getVideoPathsAsync();

    if (!Hive.isBoxOpen('videos')) {
      await Hive.openBox<List<String>>('videos');
    }

    final box = Hive.box<List<String>>('videos');

    box.put('videos', videos);
  }
}
