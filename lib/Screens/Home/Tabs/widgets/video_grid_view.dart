import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player_app/screens/home/Tabs/widgets/video_tile_widget.dart';

class VideoGriedview extends StatefulWidget {
  const VideoGriedview({
    super.key,
    required this.video,
  });

  final List<File> video;

  @override
  State<VideoGriedview> createState() => _VideoGriedviewState();
}

class _VideoGriedviewState extends State<VideoGriedview> {
  @override
  Widget build(BuildContext context) {
    return (widget.video.isEmpty)
        ? const Center(
            child: Text('No video available'),
          )
        : GridView.builder(
            shrinkWrap: true,
            itemCount: widget.video.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              final videoPath = widget.video[index];

              return Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                ),
                child: VideoTileWidget(
                  videoFile: videoPath,
                  index: index,
                ),
              );
            },
          );
  }
}
