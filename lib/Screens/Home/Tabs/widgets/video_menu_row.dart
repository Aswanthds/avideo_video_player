import 'package:flutter/material.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player_app/Screens/Home/Tabs/widgets/menu_icon.dart';
import 'package:video_player_app/Screens/Home/Tabs/widgets/video_info_dialog.dart';
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
      // Handle the error gracefully, e.g., show an error message.
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const MenuIconWidget(
          title: 'Add to Playlist',
          icon: Icons.playlist_add,
        ),
        const MenuIconWidget(
          title: 'Add to Favorites',
          icon: Icons.favorite,
        ),
        const MenuIconWidget(
          title: 'Share Video',
          icon: Icons.ios_share,
        ),
        GestureDetector(
          onTap: () => showDialog(
            context: context,
            builder: (context) {
              return ValueListenableBuilder<List<MediaInfo>>(
                valueListenable: videoInfoNotifier,
                builder: (context, info, _) {
                  return VideoInfoDialog(info: info,);
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
    );
  }

}
