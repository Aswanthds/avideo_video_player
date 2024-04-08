import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.zero),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              fit: BoxFit.contain,
              child: Text(
                widget.info.isNotEmpty
                    ? basename(widget.info[0].path!)
                    : 'No Title',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            buildRichText(
                'Size', '${formatBytesToMB(widget.info[0].filesize!)} MB'),
            buildRichText('Length', formatDuration(widget.info[0].duration!)),
            buildRichText('Location', widget.info[0].path!),
            buildRichText('Orientation',
                '${widget.info[0].width}x ${widget.info[0].height}'),
          ],
        ),
      ),
    );
  }

  Widget buildRichText(String title, String content) {
    String formattedPath = content;
    // Replace specific paths with custom labels
    if (content.contains('/storage/emulated/0')) {
      formattedPath =
          content.replaceAll('/storage/emulated/0', 'Device storage');
    } else if (content.contains('/storage/emulated/sdcard')) {
      formattedPath = content.replaceAll('/storage/emulated/sdcard', 'SD Card');
    }

    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        style: const TextStyle(fontSize: 15),
        children: [
          TextSpan(
              text: '$title : ',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black)),
          TextSpan(
            text: formattedPath,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
