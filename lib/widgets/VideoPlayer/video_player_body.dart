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
import 'package:video_player_app/widgets/VideoPlayer/video_player_controls.dart';

class VideoPlayerBody extends StatefulWidget {
  final VideoPlayerController controller;
  final String filesV;
  final bool showVolumeSlider;
  final double volumeLevel;
  final ValueChanged<double> onVolumeChanged;
  final Duration fullduration;

  const VideoPlayerBody({
    super.key,
    required this.controller,
    required this.showVolumeSlider,
    required this.volumeLevel,
    required this.onVolumeChanged,
    required this.filesV,
    required this.fullduration,
  });

  @override
  State<VideoPlayerBody> createState() => _VideoPlayerBodyState();
}

class _VideoPlayerBodyState extends State<VideoPlayerBody> {
  bool isrotated = false;
  bool isFullScreen = false;
  bool areControlsVisible = true;
  String? selectedPlaylist;

  Future<void> _toggleRotation() async {
    setState(() async {
      isrotated = !isrotated;
      if (isrotated) {
        await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
        await SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
        ]);
      } else {
        await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      }
    });
  }

  @override
  void initState() {
    selectedPlaylist = ' ';
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  void dispose() {
    super.dispose();

    untoggleRotation();
  }

  void toggleControlsVisibility() {
    setState(() {
      areControlsVisible = !areControlsVisible;
    });
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
                                selectedPlaylist = newValue;
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
                                ...playlistNames.map<DropdownMenuItem<String>>(
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
                  await CreatePlayListFunctions.createPlaylist(newPlaylistName);

                  await CreatePlayListFunctions.addVideoToPlaylist(
                      newPlaylistName, widget.filesV);

                  Navigator.of(context).popUntil((route) => route.isFirst);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: kColorCyan,
                      content: Text('Video added to playlist'), //
                      duration: Duration(seconds: 2), //
                    ),
                  ); //
                }
                if (selectedPlaylist!.isNotEmpty) {
                  await CreatePlayListFunctions.addVideoToPlaylist(
                      selectedPlaylist!, widget.filesV);
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

  @override
  Widget build(BuildContext context) {
    final filename = basename(widget.filesV);
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onDoubleTap: toggleControlsVisibility,
          child: InteractiveViewer(
            maxScale: 5,
            minScale: 1,
            child: Align(
              alignment:
                  areControlsVisible ? Alignment.center : Alignment.center,
              child: AspectRatio(
                aspectRatio: widget.controller.value.aspectRatio,
                child: VideoPlayer(widget.controller),
              ),
            ),
          ),
        ),
        Positioned(
          right: isrotated ? 50 : 0,
          bottom: isrotated ? 120 : 150,
          child: Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
                color: Colors.black26, borderRadius: BorderRadius.circular(20)),
            child: FloatingActionButton(
              backgroundColor: Colors.transparent,
              onPressed: () => _toggleRotation(),
              child: Icon(
                isrotated
                    ? Icons.screen_rotation_outlined
                    : Icons.screen_rotation_outlined,
                color: kColorWhite,
              ),
            ),
          ),
        ),
        if (areControlsVisible)
          VideoPlayerControls(
            controller: widget.controller,
            fullDuration: widget.fullduration,
            isrotated: isrotated,
            volume: widget.volumeLevel,
            onVolumeChanged: widget.onVolumeChanged,
          ),
        if (areControlsVisible)
          Positioned(
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
                        filename,
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
                          position:
                              RelativeRect.fromLTRB(left, top + 20, 10, 0),
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
                                await addtoPlaylistDialog(context);
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
                                  FavoriteFunctions.addToFavoritesList(
                                      widget.filesV);
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
            ),
          ),
      ],
    );
  }

  Future<void> untoggleRotation() async {
    //
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }
}
