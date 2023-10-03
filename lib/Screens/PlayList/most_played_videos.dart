import 'package:flutter/material.dart';
import 'package:video_player_app/Screens/playlist/widget/mostly_played/mostly_played_list_screen.dart';
import 'package:video_player_app/Screens/playlist/widget/mostly_played/thumbnail_mostly_played.dart';
import 'package:video_player_app/constants.dart';

class MostPlayedVideos extends StatefulWidget {
  const MostPlayedVideos({super.key});

  @override
  State<MostPlayedVideos> createState() => _MostPlayedVideosState();
}

class _MostPlayedVideosState extends State<MostPlayedVideos> {
  showPopupMenu(Offset offset) async {
    double left = offset.dx;
    double top = offset.dy;
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(left, top, 30, 0),
      items: [
        PopupMenuItem<Widget>(
          child: const Row(
            children: [
              Icon(Icons.favorite_outline),
              Text('Remove from favourites'),
            ],
          ),
          onTap: () {},
        ),
        const PopupMenuItem<Widget>(
          child: Row(
            children: [
              Icon(Icons.playlist_add),
              Text('Add to Playlist'),
            ],
          ),
        ),
      ],
      elevation: 8.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(75),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(24),
          ),
          child: AppBar(
            iconTheme: const IconThemeData(color: kColorWhite),
            backgroundColor: kcolorDarkblue,
            title: const Text(
              'Mostly Played ',
              style: TextStyle(
                fontFamily: 'Cookie',
                fontSize: 35,
              ),
            ),
          ),
        ),
      ),
      body: const Column(
        children: [
          Padding(
              padding: EdgeInsets.all(8.0),
              child: ThumbnailMostlyHeadingWidget()),
          Expanded(child: MostlyPlayedListScreen())
        ],
      ),
    );
  }
}
