// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player_app/Screens/Home/Tabs/widgets/menu_icon.dart';
import 'package:video_player_app/Screens/Home/Tabs/widgets/video_info_dialog.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/database/create_playlist_data.dart';
import 'package:video_player_app/functions/create_playlist_functions.dart';
import 'package:video_player_app/functions/favorites_functions.dart';
import 'package:video_player_app/functions/video_functions.dart';

class VideoMenuRow extends StatefulWidget {
  final File path;

  const VideoMenuRow(
    this.path, {
    Key? key,
  }) : super(key: key);

  @override
  State<VideoMenuRow> createState() => _VideoMenuRowState();
}

class _VideoMenuRowState extends State<VideoMenuRow> {
  Future<void> loadVideoInfo() async {
    try {
      final info = await VideoFunctions.getVideoInfo(widget.path.path);
      videoInfoNotifier.value = info;
    } catch (e) {
      videoInfoNotifier.value = [];
    }
  }

  String? selectedPlaylist;
  @override
  void initState() {
    selectedPlaylist = ' ';
    loadVideoInfo();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () async {
              showDialog(
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
                          valueListenable:
                              Hive.box<VideoPlaylist>('playlists_data')
                                  .listenable(),
                          builder: (context, Box<VideoPlaylist> box, _) {
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
                                    child: DropdownButtonFormField<String>(
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
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
                                      ),
                                      value: selectedPlaylist,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedPlaylist = newValue ?? '';
                                          debugPrint(newValue);
                                        });
                                      },
                                      items: [
                                        const DropdownMenuItem<String>(
                                          value: '',
                                          child: Text(
                                            "None",
                                            style: TextStyle(
                                                color: kcolorMintGreen),
                                          ),
                                        ),
                                        if (box.isNotEmpty)
                                          ...playlistNames
                                              .map<DropdownMenuItem<String>>(
                                                  (String? value) {
                                            return DropdownMenuItem<String>(
                                              value: value!,
                                              child: Text(
                                                value,
                                                style: const TextStyle(
                                                    color: kcolorMintGreen),
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
                          style: const TextStyle(color: kcolorMintGreen),
                          onChanged: (value) {
                            newPlaylistName = value;
                          },
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: kcolorblack,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: kcolorblack,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            hintText: "New Playlist Name",
                            hintStyle: TextStyle(color: kcolorMintGreen),
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
                            await CreatePlayListFunctions.createPlaylist(
                                newPlaylistName);

                            await CreatePlayListFunctions.addVideoToPlaylist(
                                newPlaylistName, widget.path.path);

                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(postiveNewPlaylist); //
                          }
                          if (selectedPlaylist!.isNotEmpty) {
                            await CreatePlayListFunctions.addVideoToPlaylist(
                                selectedPlaylist ?? '', widget.path.path);
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
              ScaffoldMessenger.of(context).showSnackBar(postivePlaylist);
            },
            child: const MenuIconWidget(
              title: 'Add to Playlist',
              icon: Icons.playlist_add,
            ),
          ),
          GestureDetector(
            onTap: () {
              FavoriteFunctions.addToFavoritesList(widget.path.path);
              Navigator.of(context).popUntil(
                (route) => route.isFirst,
              );

              ScaffoldMessenger.of(context).showSnackBar(positiveFavorites);
            },
            child: const MenuIconWidget(
              title: 'Add to Favorites',
              icon: Icons.favorite,
            ),
          ),
          GestureDetector(
            onTap: () => showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return ValueListenableBuilder<List<MediaInfo>>(
                  valueListenable: videoInfoNotifier,
                  builder: (context, info, _) {
                    return VideoInfoDialog(
                      info: info,
                    );
                  },
                );
              },
            ),
            child: const MenuIconWidget(
              title: 'Video Info',
              icon: Icons.info_outlined,
            ),
          ),
        ],
      ),
    );
  }
}
