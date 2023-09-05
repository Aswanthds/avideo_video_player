import 'package:flutter/material.dart';

class VideoListTileWidget extends StatelessWidget {
  const VideoListTileWidget({
    super.key,
  });

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
        ],
        elevation: 8.0,
      );
    }

    return Container(
      decoration: BoxDecoration(
          color: Colors.transparent, borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: const Icon(
          Icons.smart_display,
          size: 50,
        ),
        title: const Text(
          'Videos 1',
          style: TextStyle(fontSize: 20),
        ),
        trailing: GestureDetector(
          onTapDown: (TapDownDetails details) {
            showPopupMenu(details.globalPosition);
          },
          child: const Icon(Icons.more_vert),
        ),
      ),
    );
  }
}
