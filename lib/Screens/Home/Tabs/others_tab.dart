import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player_app/screens/home/Tabs/widgets/video_grid_view.dart';

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
    final downloadpath = getdownloadsonlyPath();
    return VideoGriedview(video: downloadpath);
  }
}
