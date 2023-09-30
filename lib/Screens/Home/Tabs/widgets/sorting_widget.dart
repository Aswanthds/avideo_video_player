import 'package:flutter/material.dart';
import 'dart:io';

import 'package:video_player_app/screens/home/Tabs/widgets/video_tile_widget.dart';

class GridviewWidget extends StatelessWidget {
  const GridviewWidget({
    super.key,
    required this.sortedFiles,
  });

  final List<File> sortedFiles;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: sortedFiles.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          final videoPath = sortedFiles[index];

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
      ),
    );
  }
}
