import 'package:flutter/material.dart';
import 'dart:io';

import 'package:video_player_app/screens/home/Tabs/widgets/video_tile_widget.dart';

class GridviewWidget extends StatefulWidget {
  const GridviewWidget({
    super.key,
    required this.sortedFiles,
  });

  final List<File> sortedFiles;

  @override
  State<GridviewWidget> createState() => _GridviewWidgetState();
}

class _GridviewWidgetState extends State<GridviewWidget> {
  bool isVideoFileExists(File path) {
    return path.existsSync();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: widget.sortedFiles.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          final videoPath = widget.sortedFiles[index];

          return (isVideoFileExists(videoPath))
              ? Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                  ),
                  child: VideoTileWidget(
                    videoFile: videoPath,
                    index: index,
                  ),
                )
              : const SizedBox(child: Center(child: Text("Video has been removed")));
        },
      ),
    );
  }
}
