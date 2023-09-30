import 'package:flutter/material.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player_app/Screens/Home/Tabs/widgets/video_info_dialog.dart';
import 'package:video_player_app/Screens/playlist/widget/mostly_played/mostly_played_list_screen.dart';
import 'package:video_player_app/Screens/playlist/widget/mostly_played/thumbnail_mostly_played.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/functions/video_functions.dart';
import 'package:video_player_app/Screens/Home/widgets/home_search_page.dart';

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
        PopupMenuItem<Widget>(
          onTap: () => showDialog(
            context: context,
            builder: (context) {
              return ValueListenableBuilder<List<MediaInfo>>(
                valueListenable: videoInfoNotifier,
                builder: (context, info, _) {
                  return VideoInfoDialog(
                    info: info,
                  );
                },
              );
            },
          ),
          child: const Row(
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
            actions: [
              IconButton(
                  onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const HomeSearchPaage(
                            files: [],
                          ),
                        ),
                      ),
                  icon: const Icon(Icons.search))
            ],
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
