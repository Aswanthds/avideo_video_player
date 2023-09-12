import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/database/favourite_data.dart';

class VideoListTileWidget extends StatelessWidget {
  final String page;
  final FavoriteData? video;
  final Uint8List? thumbnail;
  final ValueNotifier<Uint8List?> thumbnailNotifier;
  const VideoListTileWidget({
    super.key,
    required this.page,
    this.video,
    this.thumbnail,
    required this.thumbnailNotifier,
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
                const Icon(Icons.delete),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Remove from $page'),
                ),
              ],
            ),
          ),
          const PopupMenuItem<Widget>(
            child: Row(
              children: [
                Icon(Icons.info),
                Padding(
                  padding: EdgeInsets.all(8.0),
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
        leading: ValueListenableBuilder<Uint8List?>(
          valueListenable: thumbnailNotifier,
          builder: (context, thumbnail, child) {
            if (thumbnail!.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: kcolorDarkblue,
                ),
              );
            } else {
              return Container(
                width: 160,
                height: 100,
                decoration: BoxDecoration(
                  color: kcolorDarkblue,
                  border: Border.all(
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: MemoryImage(
                      thumbnail,
                    ),
                  ),
                ),
              );
            }
          },
        ),
        title: Text(
          basename(video!.filePath),
          style: const TextStyle(fontSize: 20),
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
