import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class PathFunctions {
  // static Future<List<String>> getDevicepath() async {
  //   List<String> paths = [];
  //   try {
  //     paths = await ExternalPath.getExternalStorageDirectories();
  //     for (final String path in paths) {
  //       debugPrint(path);
  //     }
  //   } on PlatformException {
  //     return [];
  //   } catch (e) {
  //     debugPrint('Exception ocured $e');
  //   }
  //   return paths;
  // }

  static Future<List<String>> getVideoPathsAsync() async {
    bool isVideoFile(File file) {
      final String extension = file.path.split('.').last.toLowerCase();
      return extension == 'mp4' ||
          extension == 'mov' ||
          extension == 'avi' ||
          extension == 'mkv';
    }

    //final rootDirectories = await getDevicepath();
    List<String> restrictedDirectories = [
      '/storage/emulated/0/Android/data',
      '/storage/emulated/0/Android'
    ];

    List<String> paths = [];

    try {
      Directory root = Directory('/storage/emulated/0/');

      // if (restrictedDirectories.contains(rootPath)) {
      //   continue;
      // }

      await for (final FileSystemEntity entity in root.list(recursive: true)) {
        if (entity is File && isVideoFile(entity)) {
          paths.add(entity.path);
        }
      }

      for (final resPath in restrictedDirectories) {
        // removing all restricted files
        if (paths.contains(resPath)) {
          paths.remove(resPath);
        }
      }
    } catch (e) {
      debugPrint('Error getting video files: $e');
      return []; // Handle the error gracefully
    }

    return paths;
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
