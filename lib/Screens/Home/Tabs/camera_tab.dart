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

final ValueNotifier<File> thumbnailNotifier = ValueNotifier<File>(File(''));

class _CameraTabState extends State<CameraTab> {
  MediaInfo? info;
  @override
  void initState() {
    super.initState();
  }

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
          child: VideoTileWidget(
            videoFile: videoPath,
          ),
        );
      },
    );
  }
}
