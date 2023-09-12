import 'package:hive_flutter/hive_flutter.dart';
part 'most_played_data.g.dart';

@HiveType(typeId: 2)
class MostlyPlayedData {
  @HiveField(0)
  String? videoPath;
  @HiveField(1)
  int playCount;

  MostlyPlayedData({
    required this.videoPath,
     required this.playCount ,
  });
}
