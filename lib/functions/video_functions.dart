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

  static Future<String> getVideoDuration(String path) async {
    MediaInfo info = await VideoCompress.getMediaInfo(path);
    double durationVideo = info.duration!;
    Duration duration = Duration(milliseconds: durationVideo.toInt());

    String formattedDuration =
        "${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}";

    return formattedDuration;
  }

}
