import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:video_compress/video_compress.dart';

class VideoInfoDialog extends StatefulWidget {
  final List<MediaInfo> info;
  const VideoInfoDialog({super.key, required this.info});

  @override
  State<VideoInfoDialog> createState() => _VideoInfoDialogState();
}

class _VideoInfoDialogState extends State<VideoInfoDialog> {
  String formatBytesToMB(int bytes) {
    double megabytes = bytes / (1024 * 1024);
    return megabytes.toStringAsFixed(2);
  }

  String formatDuration(double seconds) {
    Duration duration = Duration(milliseconds: seconds.toInt());

    String formattedDuration =
        "${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}";

    return formattedDuration;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.info.isNotEmpty ? basename(widget.info[0].path!) : 'No Title',
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Size :  ${formatBytesToMB(widget.info[0].filesize!)} MB',
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
          Text(
            'Length : ${formatDuration(widget.info[0].duration!)}',
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
          Text(
            'Location :  ${widget.info[0].path}',
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
          Text(
            'Orientation : ${widget.info[0].width}x ${widget.info[0].height} ',
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
