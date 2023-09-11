import 'package:flutter/material.dart';
import 'package:video_compress/video_compress.dart';

final videoInfoNotifier = ValueNotifier<List<MediaInfo>>([]);

class VideoFunctions {
  static Future<List<MediaInfo>> getVideoInfo(String path) async {
    List<MediaInfo> videoInfos = [];

    MediaInfo info = await VideoCompress.getMediaInfo(path);
    videoInfos.add(info);

    return videoInfos;
  }
}
