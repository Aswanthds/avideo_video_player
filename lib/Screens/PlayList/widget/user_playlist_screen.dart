import 'dart:io';
// ignore: unused_import
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/database/create_playlist_data.dart';
import 'package:video_player_app/functions/create_playlist_functions.dart';
import 'package:video_player_app/functions/favorites_functions.dart';
import 'package:video_player_app/functions/mostly_played_functions.dart';
import 'package:video_player_app/functions/recently_played_functions.dart';
import 'package:video_player_app/screens/PlayList/widget/user_playlist.dart/user_playlist.dart';

class PlaylistDetailPage extends StatefulWidget {
  final VideoPlaylist playlist;

  const PlaylistDetailPage({super.key, required this.playlist});

  @override
  State<PlaylistDetailPage> createState() => _PlaylistDetailPageState();
}

class _PlaylistDetailPageState extends State<PlaylistDetailPage> {
  List<File?> thumbnails = [];

  @override
  void initState() {
    updateThumbnails();
    super.initState();
  }

  Future<void> updateThumbnails() async {
    final list = widget.playlist.videos;

    for (final video in list!) {
      try {
        final thumbnail = await VideoCompress.getFileThumbnail(
          video,
          quality: 30,
          position: -1,
        );
        setState(() {
          thumbnails.add(thumbnail); // Add the thumbnail to the list
        });
      } catch (e) {
        debugPrint('Error generating thumbnail for $video: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kcolorDarkblue,
        title: Text(widget.playlist.name ?? ''),
        iconTheme: const IconThemeData(color: kColorWhite),
      ),
      body: ListView.builder(
        itemCount: widget.playlist.videos!.length,
        itemBuilder: (context, index) {
          final videoPath = widget.playlist.videos![index];

          return Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: thumbnails.isNotEmpty
                  ? ListTile(
                      leading: (thumbnails[index] != null)
                          ? Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: kcolorDarkblue,
                                border: Border.all(
                                  style: BorderStyle.solid,
                                ),
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(thumbnails[index]!),
                                ),
                              ),
                            )
                          : Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: kcolorDarkblue,
                                border: Border.all(
                                  style: BorderStyle.solid,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                      title: Text(basename(videoPath)),
                      onTap: () {
                        MostlyPlayedFunctions.addVideoPlayData(
                            widget.playlist.videos![index]);
                        RecentlyPlayed.onVideoClicked(
                            videoPath: widget.playlist.videos![index]);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => VideoPlaylistScreen(
                                videoPaths: widget.playlist,
                                currentIndex: index),
                          ),
                        );
                      },
                      trailing: GestureDetector(
                          onTapDown: (details) {
                            double left = details.globalPosition.dx;
                            double top = details.globalPosition.dy;
                            showMenu(
                              context: context,
                              position: RelativeRect.fromLTRB(left, top, 30, 0),
                              items: [
                                PopupMenuItem<Widget>(
                                    child: const Row(
                                      children: [
                                        Icon(Icons.favorite_outline),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text('Add to favorites'),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      FavoriteFunctions.addToFavoritesList(
                                          videoPath);

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: kColorCyan,
                                        duration: Duration(seconds: 2),
                                        content:
                                            Text('Video added to favorites'),
                                      ));
                                    }),
                                PopupMenuItem<Widget>(
                                  child: const Row(
                                    children: [
                                      Icon(Icons.playlist_remove),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('Remove from playlist'),
                                      ),
                                    ],
                                  ),
                                  onTap: () => showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Delete video ?'),
                                      content: const Text(
                                          "Are you sure ? if yes u cant undone"),
                                      actions: [
                                        TextButton.icon(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            icon: const Icon(Icons.remove),
                                            label: const Text('Cancel')),
                                        TextButton.icon(
                                          onPressed: () async {
                                            await CreatePlayListFunctions
                                                .deleteVideoFromPlaylist(
                                                    widget.playlist.name!,
                                                    widget.playlist
                                                        .videos![index]);
                                            setState(() {
                                              thumbnails.removeAt(index);
                                            });
                                            Navigator.of(context).pop();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    backgroundColor: kColorCyan,
                                                    content: Text(
                                                        'Video Deleted Sucesfully')));
                                          },
                                          icon: const Icon(
                                              Icons.delete_forever_outlined),
                                          label: const Text('Delete'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                              elevation: 8.0,
                            );
                          },
                          child: const Icon(Icons.more_vert)),
                    )
                  : const SizedBox());
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
