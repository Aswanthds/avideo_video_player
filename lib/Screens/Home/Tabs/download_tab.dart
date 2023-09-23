import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player_app/screens/home/Tabs/widgets/video_grid_view.dart';

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
    return VideoGriedview(video: downloadpath);
  }
}
