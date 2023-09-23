import 'package:hive_flutter/hive_flutter.dart';
import 'package:video_player_app/database/most_played_data.dart';

class MostlyPlayedFunctions {
  static const String _boxName = 'mostly_played_data';

  static Future<void> mostlyPlayedVideos(MostlyPlayedData video) async {
    final box = await Hive.openBox<MostlyPlayedData>(_boxName);
    await box.add(video);
  }

  static Future<void> addVideoPlayData(String videoPath) async {
    final box = await Hive.openBox<MostlyPlayedData>(_boxName);

    // Check if the videoPath already exists or not
    int existingDataIndex = -1;
    for (int i = 0; i < box.length; i++) {
      final data = box.getAt(i) as MostlyPlayedData;
      if (data.videoPath == videoPath) {
        existingDataIndex = i;
        break;
      }
    }

    if (existingDataIndex != -1) {
      // VideoPath exists in the box, update the playCount
      final existingData = box.getAt(existingDataIndex) as MostlyPlayedData;
      existingData.playCount++;
      await box.putAt(
          existingDataIndex, existingData); // Update the existing data
    } else {
      // Add a new entry if the videoPath is not found
      final newVideoData = MostlyPlayedData(videoPath: videoPath, playCount: 1);
      await box.add(newVideoData);
    }

    // Check if the video has been played more than 4 times
    if (existingDataIndex == -1) {
      final newVideoData = MostlyPlayedData(videoPath: videoPath, playCount: 1);
      if (newVideoData.playCount >= 4) {
        // If played more than 4 times, add to Mostly Played
        final mostlyPlayedBox =
            await Hive.openBox<MostlyPlayedData>('mostly_played');
        await mostlyPlayedBox.add(newVideoData);
      }
    }

   // debugPrint('Path added to hive $videoPath @ $existingDataIndex');
  }


  static Future<List<MostlyPlayedData>> getSortedVideoPlayData() async {
    final box = await Hive.openBox<MostlyPlayedData>(_boxName);

    // Get all video play data
    final videoDataList = box.values.toList().cast<MostlyPlayedData>();

    // Sort the data by play count in descending order
    videoDataList.sort((a, b) => b.playCount.compareTo(a.playCount));

    return videoDataList;
  }
}
