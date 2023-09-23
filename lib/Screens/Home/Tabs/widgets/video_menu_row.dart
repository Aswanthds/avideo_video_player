import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path/path.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player_app/Screens/Home/Tabs/widgets/menu_icon.dart';
import 'package:video_player_app/Screens/Home/Tabs/widgets/video_info_dialog.dart';
import 'package:video_player_app/database/create_playlist_data.dart';
import 'package:video_player_app/functions/create_playlist_functions.dart';
import 'package:video_player_app/functions/favorites_functions.dart';
import 'package:video_player_app/functions/video_functions.dart';

class VideoMenuRow extends StatefulWidget {
  final String path;

  const VideoMenuRow(
    this.path, {
    Key? key,
  }) : super(key: key);

  @override
  State<VideoMenuRow> createState() => _VideoMenuRowState();
}

class _VideoMenuRowState extends State<VideoMenuRow> {
  String? selectedPlaylist;
  Future<void> loadVideoInfo() async {
    try {
      final info = await VideoFunctions.getVideoInfo(widget.path);
      videoInfoNotifier.value = info;
    } catch (e) {
      videoInfoNotifier.value = [];
    }
  }

  @override
  void initState() {
    super.initState();
    selectedPlaylist = null;
    loadVideoInfo();
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
              addtoPlaylistDialog(context);
            },
            child: const MenuIconWidget(
              title: 'Add to Playlist',
              icon: Icons.playlist_add,
            ),
          ),
          GestureDetector(
            onTap: () {
              FavoriteFunctions.addToFavoritesList(widget.path);
              Navigator.of(context).pop();
            },
            child: const MenuIconWidget(
              title: 'Add to Favorites',
              icon: Icons.favorite,
            ),
          ),
          const MenuIconWidget(
            title: 'Share Video',
            icon: Icons.ios_share,
          ),
          GestureDetector(
            onTap: () => showDialog(
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

  Future<void> addtoPlaylistDialog(
    BuildContext context,
  ) async {
    final box = await Hive.openBox<VideoPlaylist>('playlists');

    String newPlaylistName = '';
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ValueListenableBuilder(
                valueListenable:
                    Hive.box<VideoPlaylist>('playlists_data').listenable(),
                builder: (context, Box<VideoPlaylist> box, _) {
                  final playlistNames =
                      box.values.map((playlist) => playlist.name).toList();
                  selectedPlaylist =
                      selectedPlaylist = playlistNames.isNotEmpty ? null : null;
                  debugPrint(playlistNames[0]);

                  return DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText:
                          'Choose', // Specify the hint text using InputDecoration
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
                        value: null,
                        child: Text("None"),
                      ),
                      ...playlistNames
                          .map<DropdownMenuItem<String>>((String? value) {
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
                Navigator.pop(context); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                // Handle creation of a new playlist
                if (newPlaylistName.isNotEmpty) {
                  await CreatePlayListFunctions.createPlaylist(newPlaylistName);

                  await CreatePlayListFunctions.addVideoToPlaylist(
                      newPlaylistName, widget.path);

                  Navigator.pop(context); // Close the dialog
                }
                if (selectedPlaylist != null) {
                  await CreatePlayListFunctions.addVideoToPlaylist(
                      selectedPlaylist!, widget.path);
                  Navigator.pop(context);
                }
              },
              child: const Text("Add to playlist"),
            ),
          ],
        );
      },
    );
  }

  Future<void> showAddToPlaylistDialog(
      BuildContext context, String videoPath) async {
    // Initialize an empty string to hold the new playlist name
  }
}
