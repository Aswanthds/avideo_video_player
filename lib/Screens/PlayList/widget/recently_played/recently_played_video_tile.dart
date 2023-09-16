import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player_app/Screens/Home/Tabs/widgets/video_info_dialog.dart';
import 'package:video_player_app/Screens/playlist/playlist%20videoplayer/VideoPlayer/video_player_widget.dart';
import 'package:video_player_app/database/video_data.dart';
import 'package:video_player_app/functions/mostly_played_functions.dart';
import 'package:video_player_app/functions/recently_played_functions.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/functions/video_functions.dart';

class RecentlyPlayedVideoTile extends StatefulWidget {
  final List<RecentlyPlayedData> files;
  final int index;
  final Uint8List thumbnail;

  const RecentlyPlayedVideoTile({
    Key? key,
    required this.thumbnail,
    required this.files,
    required this.index,
  }) : super(key: key);

  @override
  State<RecentlyPlayedVideoTile> createState() =>
      _RecentlyPlayedVideoTileState();
}

class _RecentlyPlayedVideoTileState extends State<RecentlyPlayedVideoTile> {
  Future<void> loadVideoInfo() async {
    try {
      final info = await VideoFunctions.getVideoInfo(
          widget.files[widget.index].videoPath);
      videoInfoNotifier.value = info;
    } catch (e) {
      videoInfoNotifier.value = [];
    }
  }

  @override
  Widget build(BuildContext context) {
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
                Icon(Icons.playlist_add),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Add to Playlist'),
                ),
              ],
            ),
          ),
          PopupMenuItem<Widget>(
            onTap: () {
              RecentlyPlayed.deleteVideo(widget.files[widget.index].videoPath);

              RecentlyPlayed.updateRecentlyPlayed(widget.files);
            },
            child: const Row(
              children: [
                Icon(Icons.remove),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Remove'),
                ),
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
            child: Row(
              children: [
                Icon(Icons.info_outline),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Info'),
                ),
              ],
            ),
          ),
        ],
        elevation: 8.0,
      );
    }

    final formattedTime = DateFormat('yyyy-MM-dd – kk:mm')
        .format(widget.files[widget.index].timestamp);
    return Padding(
      padding: const EdgeInsets.only(
        left: 5,
        bottom: 10,
      ),
      child: ValueListenableBuilder<List<RecentlyPlayedData>>(
        valueListenable: recentlyPlayedVideos, // Listen to changes in the list
        builder: (context, recentlyPlayedList, child) {
          return ListTile(
            onTap: () {
              List<String> videoPathsList =
                  widget.files.map((data) => data.videoPath).toList();

              MostlyPlayedFunctions.addVideoPlayData(
                  widget.files[widget.index].videoPath);
              RecentlyPlayed.onVideoClicked(videoPath: 
                  widget.files[widget.index].videoPath);
              RecentlyPlayed.checkHiveData();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => RecentlyPlayedVideoScreen(
                    currentIndex: widget.index,
                    videoPaths: widget.files,
                  ),
                ),
              );
            },
            leading: Container(
              width: 100,
              height: 160,
              decoration: BoxDecoration(
                border: Border.all(
                  color: kcolorblack,
                ),
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: MemoryImage(widget.thumbnail),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(
              basename(widget.files[widget.index].videoPath),
              maxLines: 1,
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
              ),
            ),
            subtitle: Text(
              formattedTime,
              style: TextStyle(),
            ),
            trailing: GestureDetector(
              onTapDown: (details) => showPopupMenu(details.globalPosition),
              child: const Icon(Icons.more_vert),
            ),
          );
        },
      ),
    );
  }
}
