import 'package:hive_flutter/hive_flutter.dart';
part 'video_data.g.dart';

@HiveType(typeId: 0)
class RecentlyPlayedData {
  @HiveField(0)
  final String videoPath;
  @HiveField(1)
  final DateTime timestamp;
 

  RecentlyPlayedData({
    required this.videoPath,
    required this.timestamp,
  
  });
}
