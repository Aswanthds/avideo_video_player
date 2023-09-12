import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:video_player_app/constants.dart';

class RecentlyPlayedThumbNotVideListTile extends StatelessWidget {
  const RecentlyPlayedThumbNotVideListTile({
    super.key,
    required this.videoPath,
  });

  final String videoPath;

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

    return ListTile(
      leading: Container(
        width: 100,
        height: 160,
        decoration: BoxDecoration(
          border: Border.all(
            color: kcolorblack,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      title: Text(basename(videoPath)),
      trailing: GestureDetector(
        onTapDown: (details) => showPopupMenu(details.globalPosition),
        child: const Icon(Icons.more_vert),
      ),
    );
  }
}
