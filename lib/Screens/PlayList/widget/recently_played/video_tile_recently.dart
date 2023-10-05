import 'dart:io';
import 'package:video_player_app/Screens/PlayList/widget/recently_played/widgets/listtile.dart';
import 'package:video_player_app/database/recently_video_data.dart';
import 'package:flutter/material.dart';

class RecentlyPlayedVideoTileWidget extends StatefulWidget {
  const RecentlyPlayedVideoTileWidget({
    super.key,
    required this.current,
    required this.full,
    required this.files,
    required this.index,
    required this.thumbnail,
  });

  final double current;
  final double full;
  final List<RecentlyPlayedData> files;
  final int index;
  final File thumbnail;

  @override
  State<RecentlyPlayedVideoTileWidget> createState() =>
      _RecentlyPlayedVideoTileWidgetState();
}

class _RecentlyPlayedVideoTileWidgetState
    extends State<RecentlyPlayedVideoTileWidget> {
  String selectedPlaylist = '';
  @override
  Widget build(BuildContext context) {
    return ListTileRecentlyPlayed(
        current: widget.current,
        full: widget.full,
        files: widget.files,
        index: widget.index,
        thumbnail: widget.thumbnail);
  }
}
