import 'package:flutter/material.dart';
import 'package:video_player_app/Screens/playlist/widget/recently_played/recently_played_video_item.dart';
import 'package:video_player_app/database/recently_video_data.dart';

class RecenPlayedVideoList extends StatefulWidget {
  final List<RecentlyPlayedData> files;
  const RecenPlayedVideoList({Key? key, required this.files}) : super(key: key);

  @override
  State<RecenPlayedVideoList> createState() => _RecenPlayedVideoListState();
}

class _RecenPlayedVideoListState extends State<RecenPlayedVideoList> {
  int currentIndex = 0; // Add currentIndex to track the current video index

  @override
  void initState() {
    super.initState();
    //loadRecentlyPlayedVideos();
  }

  void playNextVideo() {
    if (currentIndex < widget.files.length - 1) {
      currentIndex++; // Increment the current index
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.files.length,
        itemBuilder: (context, index) {
          return RecentlyPlayedVideoItem(
            videoData: widget.files,
            index: index,
          );
        },
      ),
    );
  }
}
