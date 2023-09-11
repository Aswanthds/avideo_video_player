import 'dart:typed_data';
import 'package:video_player_app/database/recently_played.dart';
import 'package:video_player_app/widgets/VideoPlayer/video_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:video_player_app/constants.dart';

class RecentlyPlayedVideoTile extends StatelessWidget {
  final String videoPath;
  final String timestamp;
  final Uint8List thumbnail;

  const RecentlyPlayedVideoTile({
    Key? key,
    required this.videoPath,
    required this.timestamp,
    required this.thumbnail,
  }) : super(key: key);

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
          const PopupMenuItem<Widget>(
            child: Row(
              children: [
                Icon(Icons.remove),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Remove'),
                ),
              ],
            ),
          ),
          const PopupMenuItem<Widget>(
            child: Row(
              children: [
                Icon(Icons.info_sharp),
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

    return Padding(
      padding: const EdgeInsets.only(
        left: 5,
        bottom: 10,
      ),
      child: ListTile(
        onTap: () {
          RecentlyPlayed.onVideoClicked(videoPath);
          RecentlyPlayed.checkHiveData();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => VideoPlayerScreen(
                filesV: videoPath,
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
              image: MemoryImage(thumbnail),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          basename(videoPath),
          maxLines: 1,
          style: const TextStyle(
            overflow: TextOverflow.ellipsis,
          ),
        ),
        subtitle: Text(
          timestamp.toString(),
          style: TextStyle(),
        ),
        trailing: GestureDetector(
          onTapDown: (details) => showPopupMenu(details.globalPosition),
          child: const Icon(Icons.more_vert),
        ),
      ),
    );
  }
}
