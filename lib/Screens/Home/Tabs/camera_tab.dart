import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player_app/Screens/Home/Tabs/widgets/video_tile_widget.dart';

class CameraTab extends StatefulWidget {
  final List<File> filesV;
  const CameraTab({super.key, required this.filesV});

  @override
  State<CameraTab> createState() => _CameraTabState();
}

class _CameraTabState extends State<CameraTab> {
  MediaInfo? info;
  List<File> camera = [];
  @override
  void initState() {
    super.initState();
  }

  List<File> getcameraonlyPath() {
    List<File> camera = [];
    for (File path in widget.filesV) {
      if (path.path.contains('Camera')) {
        camera.add(path);
      }
    }
    return camera;
  }

  @override
  Widget build(BuildContext context) {
    final downloadPath = getcameraonlyPath();
    return Expanded(
      child: GridView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: downloadPath.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          final videoPath = downloadPath[index];

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
