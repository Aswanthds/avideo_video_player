import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player_app/Screens/playlist/widget/recently_played/recently_played_video_list.dart';
import 'package:video_player_app/Screens/playlist/widget/playlist_heading_widget.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/database/recently_video_data.dart';
import 'package:video_player_app/functions/recently_played_functions.dart';

class RecentlyPlayedVideosPage extends StatefulWidget {
  const RecentlyPlayedVideosPage({Key? key}) : super(key: key);

  @override
  State<RecentlyPlayedVideosPage> createState() =>
      _RecentlyPlayedVideosPageState();
}

class _RecentlyPlayedVideosPageState extends State<RecentlyPlayedVideosPage> {
  List<RecentlyPlayedData> recentlyPlayedVideos = [];
  List<File> files = [];
  void loadRecentlyPlayedVideos() async {
    recentlyPlayedVideos = RecentlyPlayed.getRecentlyPlayedVideos();
    setState(() {});
  }

  @override
  void initState() {
    loadRecentlyPlayedVideos();
    super.initState();
  }

  void getfiles() {
    files = recentlyPlayedVideos.map((e) => File(e.videoPath)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          iconTheme: const IconThemeData(color: kColorWhite),
          backgroundColor: kcolorDarkblue,
          // ignore: prefer_const_constructors
          title: Text(
            'Avideo Video Player',
            style: const TextStyle(
              fontFamily: 'Cookie',
              fontSize: 35,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(85, 0, 53, 84),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const ThumbnailRecentlyHeadingWidget(),
            ),
          ),
          RecenPlayedVideoList(files: recentlyPlayedVideos)
        ],
      ),
    );
  }
}
