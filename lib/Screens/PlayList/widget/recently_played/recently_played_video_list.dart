import 'package:flutter/material.dart';
import 'package:video_player_app/Screens/playlist/widget/recently_played/recently_played_video_item.dart';
import 'package:video_player_app/functions/recently_played_functions.dart';
import 'package:video_player_app/database/video_data.dart';

class RecenPlayedVideoList extends StatefulWidget {
  const RecenPlayedVideoList({Key? key}) : super(key: key);

  @override
  State<RecenPlayedVideoList> createState() => _RecenPlayedVideoListState();
}

class _RecenPlayedVideoListState extends State<RecenPlayedVideoList> {
  List<RecentlyPlayedData> recentlyPlayedVideos = [];
  int currentIndex = 0; // Add currentIndex to track the current video index

  @override
  void initState() {
    super.initState();
    loadRecentlyPlayedVideos();
  }

  void loadRecentlyPlayedVideos() async {
    recentlyPlayedVideos = RecentlyPlayed.getRecentlyPlayedVideos();
    setState(() {});
  }

  void playNextVideo() {
    if (currentIndex < recentlyPlayedVideos.length - 1) {
      currentIndex++; // Increment the current index
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: recentlyPlayedVideos.length,
        itemBuilder: (context, index) {
          return RecentlyPlayedVideoItem(
            videoData: recentlyPlayedVideos,
            index: index,
          );
        },
      ),
    );
  }
}
