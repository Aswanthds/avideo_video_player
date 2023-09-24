import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player_app/screens/home/Tabs/widgets/video_grid_view.dart';

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
    final whatsappPath = getwhatsApponlyPath();
    return VideoGriedview(video: whatsappPath);
  }
}
