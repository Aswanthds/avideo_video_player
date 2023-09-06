import 'package:flutter/material.dart';
import 'package:video_player_app/Screens/Favorites/widgets/video_listtile_widget.dart';
import 'package:video_player_app/Screens/PlayList/widget/playlist_heading_widget.dart';
import 'package:video_player_app/widgets/appbar_common.dart';

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
        const PopupMenuItem<Widget>(
          child: Row(
            children: [
              Icon(Icons.favorite_outline),
              Text('Remove from favourites'),
            ],
          ),
        ),
        const PopupMenuItem<Widget>(
          child: Row(
            children: [
              Icon(Icons.playlist_add),
              Text('Add to Playlist'),
            ],
          ),
        ),
        const PopupMenuItem<Widget>(
          child: Row(
            children: [
              Icon(Icons.info_sharp),
              Text('Info'),
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
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: AppbarCommon(
          title: 'Most Played Videos', isHome: false,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0x54003554),
                borderRadius: BorderRadius.circular(20),
              ),
              child:const  PlayListHeadingWidget(title: 'Most Played Videos',imgPath: 'assets/images/mostly.png'),
            ),
          ),
         const VideoListTileWidget(),
        ],
      ),
    );
  }
}
