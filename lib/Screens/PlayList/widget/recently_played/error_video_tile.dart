import 'package:flutter/material.dart';
import 'package:path/path.dart';

class RecentlyPlayedErrorVideListTile extends StatelessWidget {
  const RecentlyPlayedErrorVideListTile({
    super.key,
    required this.videoPath,
  });

  final String videoPath;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.error, color: Colors.red),
      title: Text(basename(videoPath)),
    );
  }
}
