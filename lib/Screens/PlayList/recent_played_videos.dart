import 'package:flutter/material.dart';
import 'package:video_player_app/Screens/Favorites/widgets/video_listtile_widget.dart';
import 'package:video_player_app/Screens/PlayList/widget/playlist_heading_widget.dart';
import 'package:video_player_app/widgets/appbar_common.dart';

class RecentlyPlayedVideos extends StatefulWidget {
  const RecentlyPlayedVideos({super.key});

  @override
  State<RecentlyPlayedVideos> createState() => _RecentlyPlayedVideosState();
}

class _RecentlyPlayedVideosState extends State<RecentlyPlayedVideos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: AppbarCommon(
          title: 'Recently Played Videos',
          isHome: false,
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
              child: const PlayListHeadingWidget(
                title: 'Recently Played Videos',
                imgPath: 'assets/images/recently.png',
              ),
            ),
          ),
          const VideoListTileWidget(),
        ],
      ),
    );
  }
}
