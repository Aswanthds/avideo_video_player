import 'package:flutter/material.dart';
import 'package:video_player_app/Screens/playlist/most_played_videos.dart';
import 'package:video_player_app/Screens/playlist/recent_played_videos_page.dart';
import 'package:video_player_app/Screens/playlist/widget/playlist%20create/playlist_bottom_sheet.dart';
import 'package:video_player_app/Screens/playlist/widget/playlist_widget.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/screens/PlayList/widget/user_playlist.dart/userplaylistwidget.dart';

class PlaylistPageScreen extends StatefulWidget {
  const PlaylistPageScreen({super.key});

  @override
  State<PlaylistPageScreen> createState() => _PlaylistPageScreenState();
}

class _PlaylistPageScreenState extends State<PlaylistPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(75),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(24),
          ),
          child: AppBar(
            automaticallyImplyLeading: false,
            iconTheme: const IconThemeData(color: kColorWhite ),
            backgroundColor: kcolorMintGreen,
            title: const Text(
              'Playlists',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  fontFamily: 'Cookie'),
            ),
            actions: [
              IconButton(
                  onPressed: () => showDialog(
                        context: context,
                        builder: (context) => const PlaylistBottomSheet(
                          playlistIcon: Icons.abc,
                          playlistName: 'Create a playlist',
                        ),
                      ),
                  icon: const Icon(Icons.add_box))
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const RecentlyPlayedVideosPage())),
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
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kColorWhite ,
              ),
              child: const PlaylistListWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
