import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player_app/Screens/Home/Tabs/widgets/video_tile_widget.dart';

class DownloadTab extends StatefulWidget {
  final List<File> filesV;
  const DownloadTab({super.key, required this.filesV});

  @override
  State<DownloadTab> createState() => _DownloadTabState();
}

class _DownloadTabState extends State<DownloadTab> {
  List<File> downloads = [];
  @override
  void initState() {
    super.initState();
  }

  List<File> getdownloadsonlyPath() {
    List<File> downloads = [];
    for (File path in widget.filesV) {
      if (path.path.contains('Download')) {
        downloads.add(path);
      }
    }
    return downloads;
  }

  @override
  Widget build(BuildContext context) {
    final downloadpath = getdownloadsonlyPath();
    return Expanded(
      child: GridView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: downloadpath.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          final videoPath = downloadpath[index];

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
    )
    ;
  }
}
