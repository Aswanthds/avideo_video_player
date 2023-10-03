//

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/functions/favorites_functions.dart';
import 'package:video_player_app/widgets/addtoplaylist.dart';


class VideoPlayerAppBar extends StatefulWidget {
  const VideoPlayerAppBar({
    super.key,
    required this.filename,
    required this.controller,
  });

  final String filename;
  final VideoPlayerController controller;
  @override
  State<VideoPlayerAppBar> createState() => _VideoPlayerAppBarState();
}

class _VideoPlayerAppBarState extends State<VideoPlayerAppBar> {
  String? selectedPlaylist;
  @override
  Widget build(BuildContext context) {
    final String filenameShort = basename(widget.filename);
    return Container(
      width: MediaQuery.of(context).size.width,
      color: kcolorblack54,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            IconButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: kColorWhite,
                )),
            Expanded(
              child: Text(
                filenameShort,
                style: const TextStyle(
                  color: kColorWhite,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            GestureDetector(
              onTapDown: (details) {
                double left = details.globalPosition.dx;
                double top = details.globalPosition.dy;
                showMenu(
                  color: kcolorblack54,
                  context: context,
                  position: RelativeRect.fromLTRB(left, top + 20, 10, 0),
                  items: [
                    PopupMenuItem<Widget>(
                      child: const Row(
                        children: [
                          Icon(Icons.playlist_add, color: kColorWhite),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Add to Playlist',
                              style: TextStyle(color: kColorWhite),
                            ),
                          ),
                        ],
                      ),
                      onTap: () async {
                        await widget.controller.pause();
                        await showDialog(
                          context: context,
                          builder: (context) {
                            
                            return AddtoPlaylistDialog(
                              files: widget.filename,
                            );
                          },
                        );
                        await widget.controller.play();
                        await SystemChrome.setEnabledSystemUIMode(
                            SystemUiMode.immersive);
                      },
                    ),
                    PopupMenuItem<Widget>(
                        child: const Row(
                          children: [
                            Icon(Icons.favorite, color: kColorWhite),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Add to favorites',
                                style: TextStyle(color: kColorWhite),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          FavoriteFunctions.addToFavoritesList(widget.filename);
                        }),
                  ],
                  elevation: 8.0,
                );
              },
              child: const Icon(
                Icons.more_vert,
                color: kColorWhite,
              ),
            )
          ]),
    );
  }
}
