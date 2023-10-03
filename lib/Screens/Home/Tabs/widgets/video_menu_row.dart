
import 'package:flutter/material.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player_app/Screens/Home/Tabs/widgets/menu_icon.dart';
import 'package:video_player_app/Screens/Home/Tabs/widgets/video_info_dialog.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/widgets/addtoplaylist.dart';
import 'package:video_player_app/functions/favorites_functions.dart';
import 'package:video_player_app/functions/video_functions.dart';

class VideoMenuRow extends StatefulWidget {
  final String path;

  const VideoMenuRow(
    this.path, {
    Key? key,
  }) : super(key: key);

  @override
  State<VideoMenuRow> createState() => _VideoMenuRowState();
}

class _VideoMenuRowState extends State<VideoMenuRow> {

  Future<void> loadVideoInfo() async {
    try {
      final info = await VideoFunctions.getVideoInfo(widget.path);
      videoInfoNotifier.value = info;
    } catch (e) {
      videoInfoNotifier.value = [];
    }
  }

  @override
  void initState() {
    super.initState();
    
    loadVideoInfo();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () async {
              showDialog(
                context: context,
                builder: (context)  {
                  return AddtoPlaylistDialog(
                    files: widget.path,
                  );
                },
              );
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: kcolorblack05,
                duration: const Duration(seconds: 2),
                content: const Text('Video added to playlist'),
              ));
            },
            child: const MenuIconWidget(
              title: 'Add to Playlist',
              icon: Icons.playlist_add,
            ),
          ),
          GestureDetector(
            onTap: () {
              FavoriteFunctions.addToFavoritesList(widget.path);
              Navigator.of(context).popUntil(
                (route) => route.isFirst,
              );

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: kcolorblack05,
                duration: const Duration(seconds: 2),
                content: const Text('Video added to favorites'),
              ));
            },
            child: const MenuIconWidget(
              title: 'Add to Favorites',
              icon: Icons.favorite,
            ),
          ),
          GestureDetector(
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
            child: const MenuIconWidget(
              title: 'Video Info',
              icon: Icons.info_outlined,
            ),
          ),
        ],
      ),
    );
  }
}
