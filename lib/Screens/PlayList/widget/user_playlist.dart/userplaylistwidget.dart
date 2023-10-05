//

// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/database/create_playlist_data.dart';
import 'package:video_player_app/functions/create_playlist_functions.dart';
import 'package:video_player_app/screens/PlayList/widget/user_playlist.dart/user_playlist_screen.dart';

class PlaylistListWidget extends StatefulWidget {
  const PlaylistListWidget({Key? key}) : super(key: key);

  @override
  State<PlaylistListWidget> createState() => _PlaylistListWidgetState();
}

class _PlaylistListWidgetState extends State<PlaylistListWidget> {
  List<VideoPlaylist> playlistsV = [];
  @override
  void initState() {
    super.initState();
    loadPlaylists();
  }

  Future<void> loadPlaylists() async {
    final Box<VideoPlaylist> playlistBox =
        await Hive.openBox<VideoPlaylist>('playlists_data');
    final Set<String> validPaths = <String>{};

    // Filter out non-existent video paths
    for (final playlist in playlistBox.values) {
      final List<String>? videos = playlist.videos;
      if (videos != null) {
        for (final videoPath in videos) {
          final File videoFile = File(videoPath);
          if (videoFile.existsSync()) {
            validPaths.add(videoPath);
          }
        }
      }
    }

    final List<VideoPlaylist> playlistsWithValidPaths = [];

    for (final playlist in playlistBox.values) {
      final List<String>? videos = playlist.videos;
      if (videos != null) {
        final List<String> validVideos = videos
            .where((videoPath) => validPaths.contains(videoPath))
            .toList();
        if (validVideos.isNotEmpty) {
          final VideoPlaylist validPlaylist = VideoPlaylist(
            name: playlist.name, // Preserve the original playlist name
            videos: validVideos,
          );
          playlistsWithValidPaths.add(validPlaylist);
        }
      }
    }

    setState(() {
      playlistsV = playlistsWithValidPaths;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10, top: 15),
          child: Text(
            'Created Playlists',
            style: TextStyle(
                fontSize: 20,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
                  child: ValueListenableBuilder(
                    valueListenable:
                        Hive.box<VideoPlaylist>('playlists_data').listenable(),
                    builder: (context, Box<VideoPlaylist> box, _) {
                      final playlists = box.values.toList();

                      return playlists.isEmpty
                          ? const Center(
                              child: emptyPlaylist
                            )
                          : ListView.builder(
                              itemCount: playlists.length,
                              itemBuilder: (context, index) {
                                if (playlists.isNotEmpty && index >= 0) {
                                  final playlist = playlists[index];
                                  return Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              style: BorderStyle.solid),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ListTile(
                                            leading: Container(
                                              decoration: BoxDecoration(
                                                  color: kcolorDarkblue,
                                                  border: Border.all(
                                                    style: BorderStyle.solid,
                                                    color: kcolorDarkblue,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: const Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: Icon(
                                                  Icons.playlist_play,
                                                  color: kColorWhite,
                                                  size: 35,
                                                ),
                                              ),
                                            ),
                                            title: Text(
                                              playlist.name ?? '',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    PlaylistDetailPage(
                                                  playlist: playlist,
                                                ),
                                              ));
                                            },
                                            trailing: GestureDetector(
                                                onTapDown: (details) {
                                                  showMenu(
                                                    context: context,
                                                    position:
                                                        RelativeRect.fromLTRB(
                                                            details
                                                                .globalPosition
                                                                .dx,
                                                            details
                                                                .globalPosition
                                                                .dy,
                                                            30,
                                                            0),
                                                    items: [
                                                      PopupMenuItem<Widget>(
                                                        child: const Row(
                                                          children: [
                                                            Icon(Icons
                                                                .playlist_remove),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                  'Delete Playlist'),
                                                            ),
                                                          ],
                                                        ),
                                                        onTap: () {
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    AlertDialog(
                                                              content: const Text(
                                                                  'Are you sure ?'),
                                                              actions: [
                                                                TextButton.icon(
                                                                  onPressed:
                                                                      () {
                                                                    CreatePlayListFunctions.deletePlaylist(
                                                                        playlist
                                                                            .name!);
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  label: const Text(
                                                                      'Delete'),
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .delete_forever_outlined),
                                                                )
                                                              ],
                                                            ),
                                                          ).then((value) =>
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  clipBehavior:
                                                                      Clip.antiAlias,
                                                                  behavior:
                                                                      SnackBarBehavior
                                                                          .floating,
                                                                  backgroundColor:
                                                                      kcolorblack05,
                                                                  content:
                                                                      const Text(
                                                                          'Playlist deleted'), //
                                                                  duration: const Duration(
                                                                      seconds:
                                                                          2), //
                                                                ),
                                                              ));
                                                        },
                                                      ),
                                                      PopupMenuItem<Widget>(
                                                        child: const Row(
                                                          children: [
                                                            Icon(Icons
                                                                .playlist_remove),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                  'Rename Playlist'),
                                                            ),
                                                          ],
                                                        ),
                                                        onTap: () {
                                                          showRenamePlaylistDialog(
                                                              context,
                                                              playlist.name ??
                                                                  '');
                                                        },
                                                      )
                                                    ],
                                                  );
                                                },
                                                child: const Icon(
                                                    Icons.more_vert)),
                                          ),
                                        ),
                                      ));
                                }
                                return null;
                              },
                            );
                    },
                  ),
                ),
              ),
      ],
    );
  }

  Future<void> showRenamePlaylistDialog(
      BuildContext context, String currentName) async {
    String? newName = currentName;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Rename Playlist'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Current Name: $currentName'),
              TextField(
                onChanged: (value) {
                  newName = value;
                },
                decoration: const InputDecoration(
                  labelText: 'New Name',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (newName != null && newName!.isNotEmpty) {
                  //
                  await CreatePlayListFunctions.updatePlaylistName(
                      currentName, newName!);
                  Navigator.of(context).pop(); //
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: kcolorblack54,
                      dismissDirection: DismissDirection.startToEnd,
                      content: Text('Playlist renamed to $newName'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
