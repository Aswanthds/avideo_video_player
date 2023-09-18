// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:video_player/video_player.dart';
// import 'package:video_player_app/database/video_data.dart';

// class VideoPositionManager {
//   static Future<void> saveVideoPosition(
//       VideoPlayerController controller, String videoPath) async {
//     if (controller.value.isInitialized) {
//      final position = await controller.position;

//       final duration = await VideoFunctions.getVideoDuration(videoPath);
//       // You can save the position using Hive or any other storage method here
//       // For example, using Hive:
//       final positionInSeconds = position!.inSeconds;
//       final box = await Hive.openBox<RecentlyPlayedData>('recently_played');
//       final videoPositionData = RecentlyPlayedData(
//         videoPath: videoPath,
//         // videoPosition: Duration(seconds: positionInSeconds),
//         timestamp: DateTime.now(),
//         // videoDuration: duration,
//       );
//       box.put(videoPath, videoPositionData);
//     }
//   }

//   static Future<Duration?> getSavedVideoPosition(String videoPath) async {
//     // Retrieve the saved video position using Hive or any other storage method here
//     // For example, using Hive:
//     final box = await Hive.openBox<RecentlyPlayedData>('recently_played');
//     final videoPositionData = box.get(videoPath);
//     if (videoPositionData != null) {
//       return videoPositionData.videoPosition;
//     }
//     // If no position is saved, return Duration.zero or any other default value
//     return Duration.zero;
//   }
// }
