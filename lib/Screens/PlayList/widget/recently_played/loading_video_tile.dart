import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:video_player_app/constants.dart';

class RecentlyPlayedLoadingVideListTile extends StatelessWidget {
  const RecentlyPlayedLoadingVideListTile({
    super.key,
    required this.videoPath,
    required this.timestamp,
  });

  final String videoPath;
  final String timestamp;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircularProgressIndicator(
        strokeWidth: 2,
        color: kcolorDarkblue,
      ),
      title: Text(basename(videoPath)),
      subtitle: Text('Timestamp: $timestamp'),
    );
  }
}
