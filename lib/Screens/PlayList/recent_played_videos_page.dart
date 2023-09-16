import 'package:flutter/material.dart';
import 'package:video_player_app/Screens/playlist/widget/recently_played/recently_played_video_list.dart';
import 'package:video_player_app/Screens/Home/widgets/home_search_page.dart';
import 'package:video_player_app/Screens/playlist/widget/playlist_heading_widget.dart';
import 'package:video_player_app/widgets/appbar_common.dart';

class RecentlyPlayedVideosPage extends StatefulWidget {
  const RecentlyPlayedVideosPage({Key? key}) : super(key: key);

  @override
  State<RecentlyPlayedVideosPage> createState() =>
      _RecentlyPlayedVideosPageState();
}

class _RecentlyPlayedVideosPageState extends State<RecentlyPlayedVideosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: AppbarCommon(
          isHome: false,
          title: 'Recently Played Videos',
          navigation: HomeSearchPaage(text: 'Search Videos here'),
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
          RecenPlayedVideoList()
        ],
      ),
    );
  }
}