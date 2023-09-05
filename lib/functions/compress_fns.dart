import 'package:video_compress/video_compress.dart';

compress(String path) async {
  MediaInfo? mediaInfo = await VideoCompress.compressVideo(
    path,
    quality: VideoQuality.DefaultQuality,
    deleteOrigin: false, // It's false by default
  );
  return mediaInfo;
}
