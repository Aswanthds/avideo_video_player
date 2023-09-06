import 'package:flutter/material.dart';

class VideoListTileWidget extends StatelessWidget {
  const VideoListTileWidget({super.key});

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

    return ListTile(
      leading: Container(
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    color: Color(0xF1003554),
                    blurRadius: 10,
                    blurStyle: BlurStyle.outer),
              ],
              color: const Color(0xF1003554),
              border: Border.all(
                style: BorderStyle.solid,
                color: const Color(0xF1003554),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/images/logo.png',
                color: Colors.white,
              ))),
      title: const Text('Video'),
      trailing: GestureDetector(
        onTapDown: (TapDownDetails details) =>
            showPopupMenu(details.globalPosition),
        child: const Icon(
          Icons.more_vert,
          color: Color(0xF1003554),
          fill: 0,
        ),
      ),
    );
  }
}
