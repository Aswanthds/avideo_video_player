import 'dart:io';
// ignore: unused_import
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player_app/Screens/Home/widgets/home_search_page.dart';
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

enum SortingOption { nameAs, nameDe }

class _PlaylistDetailPageState extends State<PlaylistDetailPage> {
  Map<String, File?> thumbnails = {};

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
          thumbnails[video] = thumbnail; // Associate video path with thumbnail
        });
      } catch (e) {
        debugPrint('Error generating thumbnail for $video: $e');
      }
    }
  }

  SortingOption selectedOption = SortingOption.nameAs; // Default sorting option

  void sortByNameAs() {
    setState(() {
      widget.playlist.videos!.sort((pat1, pat2) => (pat1).compareTo((pat2)));
    });
  }

  void sortByNameDe() {
    setState(() {
      widget.playlist.videos!.sort((a, b) => (b).compareTo((a)));
    });
  }

  List<File> stringtoFile() {
    final list = widget.playlist.videos!.map((e) => File(e)).toList();
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kcolorDarkblue,
        title: Text(widget.playlist.name ?? ''),
        iconTheme: const IconThemeData(color: kColorWhite),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => HomeSearchPaage(
                      files: stringtoFile(),
                      text: 'Search in ${widget.playlist.name ?? ''}',
                    ),
                  )),
              icon: const Icon(Icons.search))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              // Your additional container goes here
              height: 120, // Adjust the height as needed
              decoration: BoxDecoration(
                  color: kColorAmber,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(style: BorderStyle.solid)),
              child: Center(
                child: Text(
                  widget.playlist.name ?? '',
                  style: const TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cookie'),
                ),
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: DropdownButton<SortingOption>(
                      value: selectedOption,

                      underline: const SizedBox(), //empty line

                      dropdownColor: kColorWhite,
                      iconEnabledColor: kcolorDarkblue,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: kcolorblack),
                      borderRadius: BorderRadius.circular(10),
                      onChanged: (SortingOption? newValue) {
                        setState(() {
                          selectedOption = newValue!;
                          // Sort your video list here based on newValue
                          if (selectedOption == SortingOption.nameAs) {
                            sortByNameAs();
                          } else if (selectedOption == SortingOption.nameDe) {
                            sortByNameDe();
                          }
                        });
                      },
                      items: const [
                        DropdownMenuItem(
                          value: SortingOption.nameAs,
                          child: Text(
                            ' (A ➔ Z)',
                          ),
                        ),
                        DropdownMenuItem(
                          value: SortingOption.nameDe,
                          child: Text('(Z ➔ A)'),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: ListView.builder(
                    itemCount: widget.playlist.videos!.length,
                    itemBuilder: (context, index) {
                      final videoPath = widget.playlist.videos![index];
                      final thumbnail = thumbnails[videoPath];

                      return Padding(
                          padding:
                              const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: (thumbnails.isNotEmpty ||
                                  widget.playlist.videos != null)
                              ? ListTile(
                                  leading: (thumbnail != null)
                                      ? Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            color: kcolorDarkblue,
                                            border: Border.all(
                                              style: BorderStyle.solid,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: FileImage(thumbnail),
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                  title: Text(basename(videoPath)),
                                  onTap: () {
                                    MostlyPlayedFunctions.addVideoPlayData(
                                        videoPath);
                                    RecentlyPlayed.onVideoClicked(
                                        videoPath: videoPath);
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            VideoPlaylistScreen(
                                          videoPaths: widget.playlist,
                                          currentIndex: index,
                                        ),
                                      ),
                                    );
                                  },
                                  trailing: GestureDetector(
                                      onTapDown: (details) {
                                        double left = details.globalPosition.dx;
                                        double top = details.globalPosition.dy;
                                        showMenu(
                                          context: context,
                                          position: RelativeRect.fromLTRB(
                                              left, top, 30, 0),
                                          items: [
                                            PopupMenuItem<Widget>(
                                                child: const Row(
                                                  children: [
                                                    Icon(
                                                        Icons.favorite_outline),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Text(
                                                          'Add to favorites'),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  FavoriteFunctions
                                                      .addToFavoritesList(
                                                          videoPath);

                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    backgroundColor: kColorCyan,
                                                    duration:
                                                        Duration(seconds: 2),
                                                    content: Text(
                                                        'Video added to favorites'),
                                                  ));
                                                }),
                                            PopupMenuItem<Widget>(
                                              child: const Row(
                                                children: [
                                                  Icon(Icons.playlist_remove),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                        'Remove from playlist'),
                                                  ),
                                                ],
                                              ),
                                              onTap: () => showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                  title: const Text(
                                                      'Delete video ?'),
                                                  content: const Text(
                                                      "Are you sure ? if yes u cant undone"),
                                                  actions: [
                                                    TextButton.icon(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        icon: const Icon(
                                                            Icons.remove),
                                                        label: const Text(
                                                            'Cancel')),
                                                    TextButton.icon(
                                                      onPressed: () async {
                                                        CreatePlayListFunctions
                                                            .deleteVideoFromPlaylist(
                                                                widget.playlist
                                                                    .name!,
                                                                videoPath);
                                                        setState(() {
                                                          thumbnails.remove(
                                                              videoPath);
                                                        });
                                                        Navigator.of(context)
                                                            .pop();
                                                        ScaffoldMessenger
                                                                .of(context)
                                                            .showSnackBar(const SnackBar(
                                                                behavior: SnackBarBehavior
                                                                    .floating,
                                                                backgroundColor:
                                                                    kColorCyan,
                                                                content: Text(
                                                                    'Video Deleted Successfully')));
                                                      },
                                                      icon: const Icon(Icons
                                                          .delete_forever_outlined),
                                                      label:
                                                          const Text('Delete'),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}