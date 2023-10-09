import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:video_player_app/database/most_played_data.dart';

class MostlyPlayedFunctions {
  static const String _boxName = 'mostly_played_data';

  static Future<void> mostlyPlayedVideos(MostlyPlayedData video) async {
    final box = await Hive.openBox<MostlyPlayedData>(_boxName);
    await box.add(video);
  }

  static Future<void> addVideoPlayData(String videoPath) async {
    final videoFile = File(videoPath).existsSync();
    if (videoFile) {
      // Video file doesn't exist, so don't add it
      // Optionally, you can display a message or handle it as needed
      // debugPrint('Video file does not exist: $videoPath');
      // return;
      final box = await Hive.openBox<MostlyPlayedData>(_boxName);

      //
      int existingDataIndex = -1;
      for (int i = 0; i < box.length; i++) {
        final data = box.getAt(i) as MostlyPlayedData;
        if (data.videoPath == videoPath) {
          existingDataIndex = i;
          break;
        }
      }

      if (existingDataIndex != -1) {
        //
        final existingData = box.getAt(existingDataIndex) as MostlyPlayedData;
        existingData.playCount++;
        await box.putAt(existingDataIndex, existingData); //
      } else {
        //
        final newVideoData =
            MostlyPlayedData(videoPath: videoPath, playCount: 1);
        await box.add(newVideoData);
      }

      //
      if (existingDataIndex == -1) {
        final newVideoData =
            MostlyPlayedData(videoPath: videoPath, playCount: 1);
        if (newVideoData.playCount >= 4) {
          //
          final mostlyPlayedBox =
              await Hive.openBox<MostlyPlayedData>('mostly_played_data');
          await mostlyPlayedBox.add(newVideoData);
        }
      }
    } else {
      return;
    }

    //
  }

  static Future<List<MostlyPlayedData>> getSortedVideoPlayData() async {
    final box = await Hive.openBox<MostlyPlayedData>(_boxName);

    //
    final videoDataList = box.values.toList().cast<MostlyPlayedData>();

    //
    videoDataList.sort((a, b) => b.playCount.compareTo(a.playCount));

    return videoDataList;
  }
}
