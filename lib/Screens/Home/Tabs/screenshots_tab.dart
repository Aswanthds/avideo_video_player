import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player_app/Screens/Home/Tabs/video_tile_widget.dart';

class ScreenRecordsTab extends StatefulWidget {
  final List<File> filesV;
  const ScreenRecordsTab({super.key, required this.filesV});

  @override
  State<ScreenRecordsTab> createState() => _ScreenRecordsTabState();
}

class _ScreenRecordsTabState extends State<ScreenRecordsTab> {
    @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: widget.filesV.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        final videoPath = widget.filesV[index];

        return Padding(
          padding: const EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
          ),
          child: VideoTileWidget(videoFile: videoPath),
        );
      },
    );
  }
}
