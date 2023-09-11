import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:video_player_app/constants.dart';

class RecentlyPlayedThumbNotVideListTile extends StatelessWidget {
  const RecentlyPlayedThumbNotVideListTile({
    super.key,
    required this.videoPath,
  });

  final String videoPath;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.image, color: kcolorDarkblue),
      title: Text(basename(videoPath)),
    );
  }
}
