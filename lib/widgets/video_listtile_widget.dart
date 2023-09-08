import 'package:flutter/material.dart';

class VideoListTileWidget extends StatelessWidget {
  final String page;
  const VideoListTileWidget({
    super.key,
    required this.page,
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
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Add  to favourites'),
                ),
              ],
            ),
          ),
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
            child: Row(
              children: [
                Icon(Icons.delete),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Remove from $page'),
                ),
              ],
            ),
          ),
          PopupMenuItem<Widget>(
            child: Row(
              children: [
                Icon(Icons.info),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('info'),
                ),
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
