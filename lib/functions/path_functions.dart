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
      '/storage/emulated/0/Android/data'
    ];

    List<String> paths = [];
    final deviceInfo = await DeviceInfoPlugin().androidInfo;
    final sdkVersion = deviceInfo.version.sdkInt;

    if (sdkVersion >= 31) {
      Directory root = Directory(
          '/storage/emulated/0/Android'); //finding all files in android folder
      root.listSync().forEach((element) {
        paths.add(element.path);
      });
      root = Directory('/storage/emulated/0'); //finding files in the phone
      root.listSync().forEach((element) {
        if (isVideoFile(element.path) && isVideoFile(element.path)) {
          videoPaths.add(element.path);
        } else {
          paths.add(element.path);
        }
      });
      for (final resPath in restrictedFiles) {
        // removing all restricted files
        if (paths.contains(resPath)) {
          paths.remove(resPath);
        }
      }
      for (final path in paths) {
        Directory root = Directory(path);
        root.listSync(recursive: true).forEach((element) {
          if (isVideoFile(element.path) && element.existsSync()) {
            videoPaths.add(element.path);
          }
        });
      }
    } else {
      try {
        Directory root = Directory('/storage/emulated/0/');
        await for (final FileSystemEntity entity
            in root.list(recursive: true)) {
          if (entity is File && isVideoFile(entity.path) &&
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
    final videos =
        await getVideoPathsAsync(); // Specify the folder you want to search

    if (!Hive.isBoxOpen('videos')) {
      await Hive.openBox<List<String>>('videos');
    }

    final box = Hive.box<List<String>>('videos');

    box.put('videos', videos);
  }
}
 /*
    try {
      Directory root = Directory('/storage/emulated/0/');
      await for (final FileSystemEntity entity in root.list(recursive: true)) {
        if (entity is File && isVideoFile(entity.path)) {
          videoPaths.add(entity.path);
        }
      }
    
      List<String> restrictedFiles = [
      '/storage/emulated/0/Android',
      '/storage/emulated/0/Android/obb',
      '/storage/emulated/0/Android/data'
    ];

    List<String> paths = [];
      
       Directory root = Directory(
          '/storage/emulated/0/Android'); //finding all files in android folder
      root.listSync().forEach((element) {
        paths.add(element.path);
      });
      root = Directory('/storage/emulated/0'); //finding files in the phone
      root.listSync().forEach((element) {
        if (isVideoFile(element.path) && isVideoFile(element.path)) {
          videoPaths.add(element.path);
        } else {
          paths.add(element.path);
        }
      });
      for (final resPath in restrictedFiles) {
        // removing all restricted files
        if (paths.contains(resPath)) {
          paths.remove(resPath);
        }
      }
      for (final path in paths) {
        Directory root = Directory(path);
        root.listSync(recursive: true).forEach((element) {
          if (isVideoFile(element.path)) {
            videoPaths.add(element.path);
          }
        });
      }
     
    } catch (e) {
      debugPrint('Error getting video files: $e');
      return []; // Handle the error gracefully
    }
 */
/*
static Future<List<String>> getVideoPathsAsync() async {
  bool isVideoFile(File file) {
    final String extension = file.path.split('.').last.toLowerCase();
    return extension == 'mp4' || extension == 'mov' || extension == 'avi';
  }

  //final rootDirectories = await getDevicepath();
  List<String> restrictedDirectories = ['/storage/emulated/0/Android/data'];

  List<String> paths = [];

  try {
    //Directory root = Directory('/storage/emulated/0/');

   Directory root = Directory(
        '/storage/emulated/0/Android'); //finding all files in android folder
    root.listSync().forEach((element) {
      paths.add(element.path);
    });
    root = Directory('/storage/emulated/0'); //finding files in the phone
    root.listSync().forEach((element) {
      paths.add(element.path);
    });

    // await for (final FileSystemEntity entity in root.list(recursive: true)) {
    //   if (entity is File && isVideoFile(entity)) {
    //     paths.add(entity.path);
    //   }
    // }

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


*/