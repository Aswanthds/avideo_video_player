import 'package:flutter/material.dart';
import 'package:video_player_app/Screens/Home/widgets/home_search_page.dart';
import 'package:video_player_app/Screens/PlayList/most_played_videos.dart';
import 'package:video_player_app/Screens/PlayList/recent_played_videos_page.dart';
import 'package:video_player_app/Screens/PlayList/widget/playlist_widget.dart';
import 'package:video_player_app/widgets/appbar_common.dart';

class PlaylistPageScreen extends StatefulWidget {
  const PlaylistPageScreen({
    super.key,
  });

  @override
  State<PlaylistPageScreen> createState() => _PlaylistPageScreenState();
}

class _PlaylistPageScreenState extends State<PlaylistPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: AppbarCommon(
          title: 'Playlists',
          isHome: false,
          navigation: HomeSearchPaage(text: 'Search Playlists'),
        ),
      ),
      body: Column(
        children: [
          InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => RecentlyPlayedVideosPage())),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: PlayListWidget(
                  title: 'Recently Played Videos ',
                ),
              )),
          InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MostPlayedVideos())),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: PlayListWidget(
                  title: 'Most Played Videos ',
                ),
              )),
        ],
      ),
    );
  }
}
