import 'package:flutter/material.dart';
import 'package:video_player_app/constants.dart';

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
                    color: kcolorDarkblue,
                    blurRadius: 10,
                    blurStyle: BlurStyle.outer),
              ],
              color:  kcolorDarkblue,
              border: Border.all(
                style: BorderStyle.solid,
                color:  kcolorDarkblue,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/images/logo.png',
                color: kColorWhite,
              ))),
      title: const Text('Video'),
      trailing: GestureDetector(
        onTapDown: (TapDownDetails details) =>
            showPopupMenu(details.globalPosition),
        child: const Icon(
          Icons.more_vert,
          color: kcolorDarkblue,
          fill: 0,
        ),
      ),
    );
  }
}
