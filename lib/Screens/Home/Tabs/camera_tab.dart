import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player_app/screens/home/Tabs/widgets/video_grid_view.dart';

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
    final cameraPath = getcameraonlyPath();
    return VideoGriedview(
      video: cameraPath,
    );
  }
}
