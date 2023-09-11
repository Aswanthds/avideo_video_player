import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player_app/Screens/Home/Tabs/widgets/video_tile_widget.dart';

class AllVideoTab extends StatefulWidget {
  final List<File> video;
  const AllVideoTab({super.key, required this.video});

  @override
  State<AllVideoTab> createState() => _AllVideoTabState();
}

class _AllVideoTabState extends State<AllVideoTab> {
  @override
  Widget build(BuildContext context) {
    {
      return GridView.builder(
        shrinkWrap: true,
        itemCount: widget.video.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
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
}
