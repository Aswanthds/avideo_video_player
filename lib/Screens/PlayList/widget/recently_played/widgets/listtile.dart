// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path/path.dart';
import 'package:video_player_app/Screens/PlayList/playlist%20videoplayer/VideoPlayer/video_player_widget.dart';
import 'package:video_player_app/Screens/PlayList/recent_played_videos_page.dart';
import 'package:video_player_app/Screens/PlayList/widget/recently_played/widgets/thumbnail.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/database/create_playlist_data.dart';
import 'package:video_player_app/database/recently_video_data.dart';
import 'package:video_player_app/functions/create_playlist_functions.dart';
import 'package:video_player_app/functions/mostly_played_functions.dart';
import 'package:video_player_app/functions/recently_played_functions.dart';

class ListTileRecentlyPlayed extends StatefulWidget {
  const ListTileRecentlyPlayed({
    super.key,
    required this.current,
    required this.full,
    required this.files,
    required this.index,
    required this.thumbnail,
  });

  final double current;
  final double full;
  final List<RecentlyPlayedData> files;
  final int index;
  final File thumbnail;

  @override
  State<ListTileRecentlyPlayed> createState() => _ListTileRecentlyPlayedState();
}

class _ListTileRecentlyPlayedState extends State<ListTileRecentlyPlayed> {
  String? selectedPlaylist;

  @override
  void initState() {
    super.initState();
    selectedPlaylist = '';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: kColorIndigo, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      color: Colors.grey.shade100,
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 12),
      child: ListTile(
        onTap: () {
          MostlyPlayedFunctions.addVideoPlayData(
              widget.files[widget.index].videoPath);
          RecentlyPlayed.onVideoClicked(
              videoPath: widget.files[widget.index].videoPath);
          RecentlyPlayed.checkHiveData();
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => RecentlyPlayedVideoScreen(
                      currentIndex: widget.index,
                      videoPaths: widget.files,
                    )),
          );
        },
        leading: ThumbnailRecentlyPlayed(
          thumbnail: widget.thumbnail,
          current: widget.current,
          full: widget.full,
        ),
        title: Text(
          basename(widget.files[widget.index].videoPath),
          maxLines: 1,
          style: const TextStyle(
            color: kcolorblack,
          ),
        ),
        subtitle: Text(
          '${(calculateProgress(widget.current, widget.full)! * 100).round()}%',
          style: const TextStyle(
            color: kcolorblack,
          ),
        ),
        trailing: CustomPopupMenu(
          onAddToPlaylistPressed: () {
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
                                          style:
                                              TextStyle(color: kcolorMintGreen),
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
                              newPlaylistName,
                              widget.files[widget.index].videoPath);

                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(postiveNewPlaylist); //
                        }
                        if (selectedPlaylist!.isNotEmpty) {
                          await CreatePlayListFunctions.addVideoToPlaylist(
                              selectedPlaylist ?? '',
                              widget.files[widget.index].videoPath);
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
          },
          onRemovePressed: () {
            RecentlyPlayed.deleteVideo(
                widget.files[widget.index].videoPath, widget.index);

            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const RecentlyPlayedVideosPage(),
            ));
            ScaffoldMessenger.of(context).showSnackBar(deleteMsg);
          },
        ),
      ),
    );
  }

  double? calculateProgress(double? current, double? full) {
    if (current == null ||
        full == null ||
        current.isNaN ||
        full.isNaN ||
        full <= 0) {
      return 0.0; //
    }
    return current / full;
  }
}

class CustomPopupMenu extends StatelessWidget {
  final VoidCallback? onAddToPlaylistPressed;
  final VoidCallback? onRemovePressed;

  const CustomPopupMenu({
    Key? key,
    this.onAddToPlaylistPressed,
    this.onRemovePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (BuildContext context) {
        return const [
          PopupMenuItem<String>(
            value: 'addToPlaylist',
            child: ListTile(
              leading: Icon(Icons.playlist_add),
              title: Text('Add to Playlist'),
            ),
          ),
          PopupMenuItem<String>(
            value: 'remove',
            child: ListTile(
              leading: Icon(Icons.remove),
              title: Text('Remove'),
            ),
          ),
        ];
      },
      onSelected: (String choice) {
        if (choice == 'addToPlaylist') {
          onAddToPlaylistPressed?.call();
        } else if (choice == 'remove') {
          onRemovePressed?.call();
        }
      },
    );
  }
}
