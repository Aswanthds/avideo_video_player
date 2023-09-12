import 'package:hive_flutter/hive_flutter.dart';
part 'favourite_data.g.dart';

@HiveType(typeId: 1)
class FavoriteData {
  @HiveField(0)
  final String filePath;
  @HiveField(1)
  final DateTime timestamp;

  FavoriteData({
    required this.filePath,
    required this.timestamp,
  });
}
