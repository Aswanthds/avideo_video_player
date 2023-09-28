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

  @override
  void didUpdateWidget(covariant ScreenRecordsTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.filesV != widget.filesV && mounted) {
      setState(() {});
    }
  }

  List<File> separatePaths() {
    for (final path in widget.filesV) {
      if (path.path.contains('Screenshots')) {
        screenRecords.add(path);
      }
    }
    return screenRecords;
  }

  @override
  Widget build(BuildContext context) {
    final path = separatePaths();
    return (path.isEmpty)
        ? const Center(
            child: Text('No video available'),
          )
        : GridView.builder(
            shrinkWrap: true,
            itemCount: path.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              final videoPath = path[index];

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
