import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:video_player_app/Screens/Home/Tabs/widgets/video_tile_widget.dart';

class VideoThumbnailCommon extends StatelessWidget {
  const VideoThumbnailCommon({
    super.key,
    required this.thumbnailNotifier,
    required this.widget,
  });

  final ValueNotifier<File> thumbnailNotifier;
  final VideoTileWidget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ValueListenableBuilder(
              valueListenable: thumbnailNotifier,
              builder: (context, thumbnail, child) => Container(
                  width: 160,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                        image: FileImage(
                          thumbnail,
                        ),
                      )))),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              basename(widget.videoFile.path),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
