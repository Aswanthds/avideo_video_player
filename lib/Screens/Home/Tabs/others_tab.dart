import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player_app/Screens/Home/Tabs/widgets/video_tile_widget.dart';

class OthersTab extends StatefulWidget {
  final List<File> filesV;
  const OthersTab({super.key, required this.filesV});

  @override
  State<OthersTab> createState() => _OthersTabState();
}

class _OthersTabState extends State<OthersTab> {
  List<File> getdownloadsonlyPath() {
    List<File> others = [];
    List<File> dummy = [];
    for (File path in widget.filesV) {
      if (path.path.contains('Download') ||
          path.path.contains('WhatsApp') ||
          path.path.contains('Screenshots') ||
          path.path.contains('Camera')) {
        dummy.add(path);
      } else {
        others.add(path);
      }
    }
    return others;
  }

  @override
  Widget build(BuildContext context) {
    final otherspath = getdownloadsonlyPath();
    return GridView.builder(
      shrinkWrap: true,
      itemCount: otherspath.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        final videoPath = otherspath[index];

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
