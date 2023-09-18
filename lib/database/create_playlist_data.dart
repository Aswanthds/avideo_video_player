import 'package:hive_flutter/hive_flutter.dart';

part 'create_playlist_data.g.dart';

@HiveType(typeId: 3)
class CreatePlaylistData {
  @HiveField(0)
  final String filePath;
  @HiveField(1)
  final DateTime timestamp;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String path;

  CreatePlaylistData({
    required this.filePath,
    required this.timestamp,
    required this.name,
    required this.path,
  });
}
