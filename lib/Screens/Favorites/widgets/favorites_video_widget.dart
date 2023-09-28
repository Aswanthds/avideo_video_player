//

// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path/path.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/database/create_playlist_data.dart';
import 'package:video_player_app/database/favourite_data.dart';
import 'package:video_player_app/functions/create_playlist_functions.dart';
import 'package:video_player_app/functions/favorites_functions.dart';
import 'package:video_player_app/widgets/VideoPlayer/video_player_widget.dart';

class VideoListTileWidget extends StatefulWidget {
  final FavoriteData video;
  final int index;

  const VideoListTileWidget({
    super.key,
    required this.video,
    required this.index,
  });

  @override
  State<VideoListTileWidget> createState() => _VideoListTileWidgetState();
}

typedef VideoDeleteCallback = void Function();

class _VideoListTileWidgetState extends State<VideoListTileWidget> {
  File? thumbnailFile;

  @override
  void initState() {
    super.initState();
    //
    generateThumbnail(widget.video.filePath, widget.index);
  }

  String? selectedPlaylist;
  Future<void> generateThumbnail(String path, int index) async {
    //
    try {
      final file = await VideoCompress.getFileThumbnail(
        path,
        quality: 10,
        position: -1,
      );
      if (mounted) {
        setState(() {
          thumbnailFile = file;
        });
      }
    } catch (e) {
      debugPrint('Error generating thumbnail: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final videoFilePath = widget.video.filePath;
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
            },
          ),
          PopupMenuItem<Widget>(
              child: const Row(
                children: [
                  Icon(Icons.delete),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Remove from favorites'),
                  ),
                ],
              ),
              onTap: () {
                if (mounted) {
                  setState(() {
                    FavoriteFunctions.deleteVideo(
                        widget.video.filePath, widget.index);
                  });
                }
              }),
        ],
        elevation: 8.0,
      );
    }

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 5.0,
        top: 5.0,
      ),
      child: ListTile(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => VideoPlayerScreen(filesV: videoFilePath),
          ),
        ),
        leading: thumbnailFile != null
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
                    image: FileImage(thumbnailFile!),
                  ),
                ),
              )
            : Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                  ),
                )),
        title: Text(
          basename(videoFilePath),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              fontSize: 15,
              color: kcolorDarkblue,
              fontWeight: FontWeight.bold,
              fontFamily: 'NixieOne'),
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

  Future<void> addtoPlaylistDialog(
    BuildContext context,
  ) async {
    final box = await Hive.openBox<VideoPlaylist>('playlists_data');

    String newPlaylistName = '';
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
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
                      : DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Choose', //
                          ),
                          value: selectedPlaylist,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedPlaylist = newValue;
                              debugPrint(newValue);
                            });
                          },
                          items: [
                            const DropdownMenuItem<String>(
                              value: '',
                              child: Text("None"),
                            ),
                            if (box.isNotEmpty)
                              ...playlistNames.map<DropdownMenuItem<String>>(
                                  (String? value) {
                                return DropdownMenuItem<String>(
                                  value: value!,
                                  child: Text(value),
                                );
                              }).toList(),
                          ],
                        );
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                onChanged: (value) {
                  newPlaylistName = value;
                },
                decoration: const InputDecoration(
                  hintText: "New Playlist Name",
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
                  await CreatePlayListFunctions.createPlaylist(newPlaylistName);
                  Navigator.of(context).popUntil((route) => route.isFirst);

                  await CreatePlayListFunctions.addVideoToPlaylist(
                      newPlaylistName, widget.video.filePath);

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
                if (selectedPlaylist!.isNotEmpty) {
                  await CreatePlayListFunctions.addVideoToPlaylist(
                      selectedPlaylist!, widget.video.filePath);
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(
                      clipBehavior: Clip.antiAlias,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: kcolorblack05,
                      content: const Text('Video added to playlist'), //
                      duration: const Duration(seconds: 2), //
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
}
