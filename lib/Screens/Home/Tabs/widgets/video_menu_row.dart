import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
    loadVideoInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () async {
            Navigator.of(context).pop();
            final box = await Hive.openBox<CreatePlaylistData>('playlists');
            List<CreatePlaylistData> naem = [];
            naem.add(CreatePlaylistData(name: box.name));

            String newPlaylistName = '';
            addtoPlaylistDialog(context, box, newPlaylistName);
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
    );
  }

  Future<dynamic> addtoPlaylistDialog(BuildContext context, Box<CreatePlaylistData> box, String newPlaylistName) {
    return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Add to Playlist"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AlreadyPlaylist(),
                    TextField(
                      onChanged: (value) {
                        newPlaylistName =
                            value; // Update the new playlist name
                      },
                      decoration: const InputDecoration(
                          labelText: "New Playlist Name"),
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
                        await CreatePlayListFunctions.createPlaylist(
                            newPlaylistName);
                        CreatePlayListFunctions.addVideoToPlaylist(
                            newPlaylistName, widget.path);
                        Navigator.pop(context); // Close the dialog
                      }
                    },
                    child: const Text("Create and Add"),
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

class AlreadyPlaylist extends StatelessWidget {
  const AlreadyPlaylist({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<CreatePlaylistData>('playlists').listenable(),
      builder: (context, Box<CreatePlaylistData> box, _) {
        final playlistNames =
            box.values.map((playlist) => playlist.name).toList();
        String? selectedPlaylist =
            playlistNames.isNotEmpty ? playlistNames[0] : null;

        return DropdownButton<String>(
          value: selectedPlaylist,
          onChanged: (String? newValue) {
            // Handle playlist selection here
            selectedPlaylist = newValue;
          },
          items: playlistNames.map<DropdownMenuItem<String>>((String? value) {
            return DropdownMenuItem<String>(
              value: value!,
              child: Text(value),
            );
          }).toList(),
        );
      },
    );
  }
}
