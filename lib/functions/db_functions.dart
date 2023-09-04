
import 'package:fetch_all_videos/fetch_all_videos.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<List<dynamic>> getPath() async {
  FetchAllVideos ob = FetchAllVideos();
  List<dynamic> videos = await ob.getAllVideos();
  print('Fetched video data: $videos');

  return videos;
}

Future<List> storeVideos() async {
  final videos = await getPath();

  if (!Hive.isBoxOpen('videos')) {
    await Hive.openBox<List<dynamic>>('videos');
  }

  final box = Hive.box<List<dynamic>>('videos');

  // Store the videos list using the key 'videos' instead of 'video'
  box.put('videos', videos); // Use the same key 'videos'

  return videos;
}
