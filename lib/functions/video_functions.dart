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

    String formattedHours = '';
    String formattedMinutes = '';
    String formattedSeconds = '';

    try {
      int hours = duration.inHours;
      int minutes = duration.inMinutes.remainder(60);
      int seconds = duration.inSeconds.remainder(60);

      if (hours > 0) {
        formattedHours = '${hours.toString().padLeft(2, '0')}:';
      }

      formattedMinutes = minutes.toString().padLeft(2, '0');
      formattedSeconds = seconds.toString().padLeft(2, '0');
    } catch (e) {
      debugPrint('Exception $e');
    }

    return '$formattedHours$formattedMinutes:$formattedSeconds';
  }
}
