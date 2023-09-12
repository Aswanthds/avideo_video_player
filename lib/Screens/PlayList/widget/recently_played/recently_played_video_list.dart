import 'package:flutter/material.dart';
import 'package:video_player_app/Screens/PlayList/widget/recently_played/recently_played_video_item.dart';
import 'package:video_player_app/functions/recently_played_functions.dart';
import 'package:video_player_app/database/video_data.dart';

class RecenPlayedVideoList extends StatefulWidget {
  const RecenPlayedVideoList({super.key});

  @override
  State<RecenPlayedVideoList> createState() => _RecenPlayedVideoListState();
}

class _RecenPlayedVideoListState extends State<RecenPlayedVideoList> {
  List<RecentlyPlayedData> recentlyPlayedVideos = [];
  @override
  void initState() {
    super.initState();
    loadRecentlyPlayedVideos();
  }

  void loadRecentlyPlayedVideos() async {
    recentlyPlayedVideos = RecentlyPlayed.getRecentlyPlayedVideos();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: recentlyPlayedVideos.length,
        itemBuilder: (context, index) {
          return RecentlyPlayedVideoItem(
            videoData: recentlyPlayedVideos[index],
          );
        },
      ),
    );
  }
}
