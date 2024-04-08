// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path/path.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/database/create_playlist_data.dart';
import 'package:video_player_app/functions/create_playlist_functions.dart';
import 'package:video_player_app/functions/favorites_functions.dart';
import 'package:video_player_app/widgets/VideoPlayer/video_player_body.dart';

class VideoPlayerAppbar extends StatefulWidget {
  const VideoPlayerAppbar({
    super.key,
    required this.filename,
    required this.widget,
    required this.isRotated,
  });

  final String filename;
  final VideoPlayerBody widget;
  final bool isRotated;

  @override
  State<VideoPlayerAppbar> createState() => _VideoPlayerAppbarState();
}

class _VideoPlayerAppbarState extends State<VideoPlayerAppbar> {
  String? selectedPlaylist;
  @override
  void initState() {
    super.initState();
    selectedPlaylist = '';
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      child: Container(
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
                  basename(widget.filename),
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
                          await widget.widget.controller.pause();
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
                                                data:
                                                    Theme.of(context).copyWith(
                                                  canvasColor: kColorWhite,
                                                ),
                                                child: DropdownButtonFormField<
                                                    String>(
                                                  decoration:
                                                      const InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color:
                                                                  kcolorblack,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color:
                                                                  kcolorblack,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                  ),
                                                  value: selectedPlaylist,
                                                  onChanged:
                                                      (String? newValue) {
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
                                      style: const TextStyle(
                                          color: kcolorMintGreen),
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
                                            .addVideoToPlaylist(newPlaylistName,
                                                widget.widget.filesV);

                                        Navigator.of(context).pop();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                                postiveNewPlaylist); //
                                      }
                                      if (selectedPlaylist!.isNotEmpty) {
                                        await CreatePlayListFunctions
                                            .addVideoToPlaylist(
                                                selectedPlaylist ?? '',
                                                widget.widget.filesV);
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

                          await widget.widget.controller.play();
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
                            FavoriteFunctions.addToFavoritesList(
                                widget.widget.filesV);
                          }),
                      // PopupMenuItem<Widget>(
                      //     child: const Row(
                      //       children: [
                      //         Icon(Icons.favorite, color: kColorWhite ),
                      //         Padding(
                      //           padding: EdgeInsets.all(8.0),
                      //           child: Text(
                      //             'Add to favorites',
                      //             style: TextStyle(color: kColorWhite ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //     onTap: ()  {
                      //       final share = await  Share.shareXFiles(
                      //         [
                      //           XFile(
                      //             '/storage/emulated/0/DCIM/Camera/VID-20230930-WA0002.mp4',
                      //             mimeType: 'video/mp4',
                      //           )
                      //         ],
                      //       );

                      //       // Share the video file using the SharePlus.share() method.
                      //     })
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
      ),
    );
  }
}


//  GestureDetector(
//             onTap: ()  {
//                Uri videoUri = FileProvider.getUriForFile(
//                   context,
//                   getApplicationContext().getPackageName(),
//                   File(widget.videoPath));

//                Share.shareXFiles([XFile(widget.path.path)],
//                   text: 'Check out this video!');
//             },
//             child: MenuIconWidget(
//               icon: Icons.share,
//               title: "Share ",
//             ),
//           ),