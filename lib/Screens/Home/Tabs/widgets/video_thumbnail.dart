import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/functions/video_functions.dart';

class VideoThumbnailCommon extends StatefulWidget {
  const VideoThumbnailCommon({
    Key? key,
    required this.videoFile,
  }) : super(key: key);

  final File videoFile;

  @override
  State<VideoThumbnailCommon> createState() => _VideoThumbnailCommonState();
}

class _VideoThumbnailCommonState extends State<VideoThumbnailCommon> {
  String? duration;
  final ValueNotifier<File> thumbnailNotifier = ValueNotifier<File>(File(''));

  @override
  void initState() {
    super.initState();
    getDuration();
    updateThumbnail();
  }

  Future<void> updateThumbnail() async {
    if (widget.videoFile.existsSync()) {
      try {
        final thumbnailFile = await VideoCompress.getFileThumbnail(
          widget.videoFile.path,
          quality: 30,
          position: 0,
        );

        thumbnailNotifier.value = thumbnailFile;
      } catch (e) {
        debugPrint('Error generating thumbnail: $e');
      }
    } else {
      return;
    }
  }

  Future<void> getDuration() async {
    final videoDuration =
        await VideoFunctions.getVideoDuration(widget.videoFile.path);
    if (mounted) {
      setState(() {
        duration = videoDuration;
      });
    }
  }

  @override
  void didUpdateWidget(covariant VideoThumbnailCommon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.videoFile != oldWidget.videoFile) {
      updateThumbnail();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      color: Colors.white.withOpacity(0.8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ValueListenableBuilder<File?>(
            valueListenable: thumbnailNotifier,
            builder: (context, thumbnail, child) {
              if (thumbnail == null) {
                return Container(
                  width: 160,
                  height: 100,
                  decoration: BoxDecoration(
                    color: kcolorDarkblue,
                    border: Border.all(
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                    ),
                  ),
                );
              } else {
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        width: 160,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(thumbnail),
                          ),
                        ),
                      ),
                    ),
                    if (duration != null)
                      Positioned(
                        bottom: 5,
                        right: 5,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            duration!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              basename(widget.videoFile.path).toUpperCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.5,
                  fontFamily: 'OpenSans'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
