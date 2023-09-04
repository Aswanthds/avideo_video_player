import 'dart:typed_data';
import 'package:video_thumbnail/video_thumbnail.dart';

Future<Uint8List?> getThumbnailFromVideo(String videoPath) async {
  // Get the thumbnail from the video using the VideoThumbnail class.
  return VideoThumbnail.thumbnailData(
    video: videoPath,
    imageFormat: ImageFormat.JPEG,
    timeMs: 1,
    quality: 50,
  );
}
