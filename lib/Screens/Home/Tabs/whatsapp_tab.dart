import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player_app/Screens/Home/Tabs/widgets/video_tile_widget.dart';

class WhatsappTab extends StatefulWidget {
  final List<File> filesV;
  const WhatsappTab({super.key, required this.filesV});

  @override
  State<WhatsappTab> createState() => _WhatsappTabState();
}

class _WhatsappTabState extends State<WhatsappTab> {
  List<File> whatsApp = [];
  @override
  void initState() {
    super.initState();
  }

  List<File> getwhatsApponlyPath() {
    for (File path in widget.filesV) {
      if (path.path.contains('WhatsApp')) {
        whatsApp.add(path);
      }
    }
    return whatsApp;
  }

  @override
  Widget build(BuildContext context) {
    final downloadPath = getwhatsApponlyPath();
    return GridView.builder(
      shrinkWrap: true,
      itemCount: downloadPath.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
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
