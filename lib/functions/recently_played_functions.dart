import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player_app/database/video_data.dart';

ValueNotifier<List<RecentlyPlayedData>> recentlyPlayedVideos =
    ValueNotifier<List<RecentlyPlayedData>>([]);
final videoduration = ValueNotifier<List<MediaInfo>>([]);

class RecentlyPlayed {
  static const String _boxName = 'recently_played';

  static Future<void> init() async {
    await Hive.openBox<RecentlyPlayedData>(_boxName);
  }

  static void onVideoClicked({
    required String videoPath,
    Duration? current,
    Duration? full,
  }) async {
    final box = Hive.box<RecentlyPlayedData>(_boxName);

    final videoData = RecentlyPlayedData(
      videoPath: videoPath,
      timestamp: DateTime.now(),
      current: current,
      full: full,
    );

    await box.put(videoPath, videoData);

    debugPrint(
        'onVideo: ${videoData.videoPath}, ${videoData.current}, ${videoData.full}, ${videoData.timestamp}');
  }

  static List<RecentlyPlayedData> getRecentlyPlayedVideos() {
    final box = Hive.box<RecentlyPlayedData>(_boxName);
    final videos = box.values.toList().cast<RecentlyPlayedData>();

    final uniqueVideosMap = <String, RecentlyPlayedData>{};

    for (final videoData in videos) {
      final videoPath = videoData.videoPath;
      final timestamp = videoData.timestamp;

      if (uniqueVideosMap.containsKey(videoPath)) {
        final existingTimestamp = uniqueVideosMap[videoPath]!.timestamp;

        if (timestamp.isAfter(existingTimestamp)) {
          uniqueVideosMap[videoPath] = videoData;
        }
      } else {
        uniqueVideosMap[videoPath] = videoData;
      }
    }

    final uniqueVideos = uniqueVideosMap.values.toList();
    uniqueVideos.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    //debugPrint(uniqueVideos.length.toString());

    return uniqueVideos;
  }

  static void checkHiveData() {
    final recentlyPlayedVideos = RecentlyPlayed.getRecentlyPlayedVideos();
    for (final videoData in recentlyPlayedVideos) {
      debugPrint('Video Path: ${videoData.videoPath}');
      //debugPrint('Timestamp: ${videoData.timestamp}');
    }
  }

  static Future<void> deleteVideo(String videoPath) async {
    final box = await Hive.openBox<RecentlyPlayedData>(_boxName);

    final videoToDeleteKey = box.keys.firstWhere(
      (key) {
        final videoData = box.get(key);
        return videoData != null && videoData.videoPath == videoPath;
      },
      orElse: () => null,
    );

    if (videoToDeleteKey != null) {
      await box.delete(videoToDeleteKey);
      // debugPrint('Deleted video: $videoPath');

      // Modify the list of recently played videos
      final updatedList = recentlyPlayedVideos.value.toList();
      updatedList.removeWhere((videoData) => videoData.videoPath == videoPath);

      // Update the ValueNotifier with the modified list
      recentlyPlayedVideos.value = updatedList;
    }
  }

  // Add a method to update the list
  static updateRecentlyPlayed(List<RecentlyPlayedData> videos) {
    recentlyPlayedVideos.value = videos;
  }
}
