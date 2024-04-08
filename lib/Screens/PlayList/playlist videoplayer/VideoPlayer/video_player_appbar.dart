//

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path/path.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/database/create_playlist_data.dart';
import 'package:video_player_app/functions/create_playlist_functions.dart';
import 'package:video_player_app/functions/favorites_functions.dart';

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
                            String newPlaylistName = '';
                            return AlertDialog(
                              backgroundColor: kColorWhite,
                              content: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ValueListenableBuilder(
                                    valueListenable: Hive.box<VideoPlaylist>(
                                            'playlists_data')
                                        .listenable(),
                                    builder:
                                        (context, Box<VideoPlaylist> box, _) {
                                      final playlistNames = box.values
                                          .map((playlist) => playlist.name)
                                          .toList();
                                      selectedPlaylist = selectedPlaylist =
                                          playlistNames.isNotEmpty ? '' : '';
                                      //

                                      return (playlistNames.isEmpty ||
                                              playlistNames[0] == null)
                                          ? const SizedBox(
                                              height: 20,
                                            )
                                          : Theme(
                                              data: Theme.of(context).copyWith(
                                                canvasColor: kColorWhite,
                                              ),
                                              child: DropdownButtonFormField<
                                                  String>(
                                                decoration:
                                                    const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: kcolorblack,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20))),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: kcolorblack,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20))),
                                                ),
                                                value: selectedPlaylist,
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    selectedPlaylist =
                                                        newValue ?? '';
                                                    debugPrint(newValue);
                                                  });
                                                },
                                                items: [
                                                  const DropdownMenuItem<
                                                      String>(
                                                    value: '',
                                                    child: Text(
                                                      "None",
                                                      style: TextStyle(
                                                          color:
                                                              kcolorMintGreen),
                                                    ),
                                                  ),
                                                  if (box.isNotEmpty)
                                                    ...playlistNames.map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String? value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value!,
                                                        child: Text(
                                                          value,
                                                          style: const TextStyle(
                                                              color:
                                                                  kcolorMintGreen),
                                                        ),
                                                      );
                                                    }).toList(),
                                                ],
                                              ),
                                            );
                                    },
                                  ),
                                  const SizedBox(height: 20.0),
                                  TextFormField(
                                    style:
                                        const TextStyle(color: kcolorMintGreen),
                                    onChanged: (value) {
                                      newPlaylistName = value;
                                    },
                                    decoration: const InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: kcolorblack,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: kcolorblack,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      hintText: "New Playlist Name",
                                      hintStyle:
                                          TextStyle(color: kcolorMintGreen),
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); //
                                  },
                                  child: const Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    //
                                    if (newPlaylistName.isNotEmpty) {
                                      await CreatePlayListFunctions
                                          .createPlaylist(newPlaylistName);

                                      await CreatePlayListFunctions
                                          .addVideoToPlaylist(
                                              newPlaylistName, widget.filename);

                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(postiveNewPlaylist); //
                                    }
                                    if (selectedPlaylist!.isNotEmpty) {
                                      await CreatePlayListFunctions
                                          .addVideoToPlaylist(
                                              selectedPlaylist ?? '',
                                              widget.filename);
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(postivePlaylist);
                                    }
                                  },
                                  child: const Text("Add to playlist"),
                                ),
                              ],
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
