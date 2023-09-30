// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:video_player_app/Screens/playlist/playlist%20videoplayer/VideoPlayer/video_player_widget.dart';
import 'package:video_player_app/database/create_playlist_data.dart';
import 'package:video_player_app/database/recently_video_data.dart';
import 'package:video_player_app/functions/create_playlist_functions.dart';
import 'package:video_player_app/functions/mostly_played_functions.dart';
import 'package:video_player_app/functions/recently_played_functions.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:video_player_app/constants.dart';

class RecentlyPlayedVideoTileWidget extends StatefulWidget {
  const RecentlyPlayedVideoTileWidget({
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
  State<RecentlyPlayedVideoTileWidget> createState() =>
      _RecentlyPlayedVideoTileWidgetState();
}

class _RecentlyPlayedVideoTileWidgetState
    extends State<RecentlyPlayedVideoTileWidget> {
  String selectedPlaylist = '';
  @override
  Widget build(BuildContext context) {
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

    void deleteVideo(String videoPath) {
      RecentlyPlayed.deleteVideo(videoPath);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: kcolorblack05,
          content: const Text('Video deleted'), //
          duration: const Duration(seconds: 2), //
          action: SnackBarAction(
            label: 'Close',
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      );
    }

    Future<void> addtoPlaylistDialog(
      BuildContext context,
    ) async {
      final box = await Hive.openBox<VideoPlaylist>('playlists_data');
      String newPlaylistName = '';
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: kcolorblack54,
            //
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ValueListenableBuilder(
                  valueListenable: box.listenable(),
                  builder: (context, Box<VideoPlaylist> box, _) {
                    final playlistNames =
                        box.values.map((playlist) => playlist.name).toList();
                    selectedPlaylist =
                        selectedPlaylist = playlistNames.isNotEmpty ? '' : '';
                    //

                    return (playlistNames.isEmpty || playlistNames[0] == null)
                        ? const SizedBox(
                            height: 20,
                          )
                        : Theme(
                            data: Theme.of(context).copyWith(
                              canvasColor: kcolorblack54,
                            ),
                            child: DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
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
                                    style: TextStyle(color: kColorWhite),
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
                                        style:
                                            const TextStyle(color: kColorWhite),
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
                  style: const TextStyle(color: kColorWhite),
                  onChanged: (value) {
                    newPlaylistName = value;
                  },
                  decoration: const InputDecoration(
                    hintText: "New Playlist Name",
                    hintStyle: TextStyle(color: kColorWhite),
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
                        newPlaylistName, widget.files[widget.index].videoPath);

                    Navigator.of(context).popUntil((route) => route.isFirst);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: kcolorblack05,
                        content: const Text('Video added to playlist'), //
                        duration: const Duration(seconds: 2), //
                      ),
                    ); //
                  }
                  if (selectedPlaylist.isNotEmpty) {
                    await CreatePlayListFunctions.addVideoToPlaylist(
                        selectedPlaylist, widget.files[widget.index].videoPath);
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        clipBehavior: Clip.antiAlias,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: kColorDeepOrange,
                        content: Text('Video added to playlist'), //
                        duration: Duration(seconds: 2), //
                      ),
                    );
                  }
                },
                child: const Text("Add to playlist"),
              ),
            ],
          );
        },
      );
    }

    showPopupMenu(Offset offset) async {
      double left = offset.dx;
      double top = offset.dy;
      await showMenu(
        context: context,
        position: RelativeRect.fromLTRB(left, top, 30, 0),
        items: [
          PopupMenuItem<Widget>(
              child: const Row(
                children: [
                  Icon(Icons.playlist_add),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Add to Playlist'),
                  ),
                ],
              ),
              onTap: () {
                addtoPlaylistDialog(
                  context,
                );
              }),
          PopupMenuItem<Widget>(
            onTap: () {
              deleteVideo(widget.files[widget.index].videoPath);
              Navigator.of(context).pop();
              setState(() {});
            },
            child: const Row(
              children: [
                Icon(Icons.remove),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Remove'),
                ),
              ],
            ),
          ),
        ],
        elevation: 8.0,
      );
    }

    return ListTile(
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
            ),
          ),
        );
      },
      leading: Stack(
        children: [
          (widget.thumbnail.path.isNotEmpty)
              ? Container(
                  width: 100,
                  height: 160,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: kcolorblack,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: FileImage(widget.thumbnail),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: LinearProgressIndicator(
                      minHeight: 2,
                      value: calculateProgress(widget.current, widget.full),
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(kcolorDarkblue),
                      backgroundColor: kColorWhite54,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                )
              : Container(
                  width: 100,
                  height: 160,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: kcolorblack,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    image: const DecorationImage(
                      image:
                          AssetImage('assets/images/thumbnail_placeholder.jpg'),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                )
        ],
      ),
      title: Text(basename(widget.files[widget.index].videoPath),
          maxLines: 1, overflow: TextOverflow.ellipsis, style: favorites),
      subtitle: Text(
        '${(calculateProgress(widget.current, widget.full)! * 100).round()}%',
        style: const TextStyle(),
      ),
      trailing: GestureDetector(
        onTapDown: (details) => showPopupMenu(details.globalPosition),
        child: const Icon(Icons.more_vert),
      ),
    );
  }
}
