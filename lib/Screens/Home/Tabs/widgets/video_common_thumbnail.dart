import 'dart:typed_data';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:video_player_app/Screens/Home/Tabs/widgets/video_tile_widget.dart';
import 'package:video_player_app/constants.dart';

class VideoThumbnailCommon extends StatelessWidget {
  const VideoThumbnailCommon({
    super.key,
    required this.thumbnailNotifier,
    required this.widget,
  });

  final ValueNotifier<Uint8List?> thumbnailNotifier;
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
          ValueListenableBuilder<Uint8List?>(
            valueListenable: thumbnailNotifier,
            builder: (context, thumbnail, child) {
              return Container(
                width: 160,
                height: 100,
                decoration: BoxDecoration(
                  color: kcolorblack,
                  image: DecorationImage(
                    image: MemoryImage(
                      thumbnail!,
                    ),
                  ),
                ),
              );
            },
          ),
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
