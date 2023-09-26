import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player_app/Screens/Home/Tabs/widgets/video_tile_widget.dart';

class ScreenRecordsTab extends StatefulWidget {
  final List<File> filesV;
  const ScreenRecordsTab({super.key, required this.filesV});

  @override
  State<ScreenRecordsTab> createState() => _ScreenRecordsTabState();
}

class _ScreenRecordsTabState extends State<ScreenRecordsTab> {
  List<File> screenRecords = [];
  @override
  void initState() {
    super.initState();
  }

  List<File> getscreenRecordsonlyPath() {
    List<File> screenRecords = [];
    for (File path in widget.filesV) {
      if (path.path.contains('Screenshots')) {
        screenRecords.add(path);
      }
    }
    return screenRecords;
  }

  @override
  void didUpdateWidget(covariant ScreenRecordsTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (screenRecords != screenRecords && mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final downloadPath = getscreenRecordsonlyPath();
    return (downloadPath.isEmpty)
        ? const Center(
            child: Text('No video available'),
          )
        : GridView.builder(
            shrinkWrap: true,
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
          );
  }
}
