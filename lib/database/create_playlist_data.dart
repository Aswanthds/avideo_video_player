import 'package:hive_flutter/hive_flutter.dart';
part 'create_playlist_data.g.dart';

@HiveType(typeId: 3)
class VideoPlaylist {
  @HiveField(0)
  String? name;

  @HiveField(1)
  List<String>? videos;

  VideoPlaylist({
     this.name,
     this.videos,
  });
}
