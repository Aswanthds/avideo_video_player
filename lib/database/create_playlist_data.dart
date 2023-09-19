import 'package:hive_flutter/hive_flutter.dart';

part 'create_playlist_data.g.dart';

@HiveType(typeId: 3)
class CreatePlaylistData {
  @HiveField(0)
  final String? name;
  // @HiveField(1)
  // final List<String> paths;

  CreatePlaylistData({
    this.name,
    //this.paths = const [],
  });
}

@HiveType(typeId: 4)
class Video {
  @HiveField(0)
  final String videoPath;

  Video({required this.videoPath});
}
