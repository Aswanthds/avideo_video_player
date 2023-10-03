// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/database/create_playlist_data.dart';
import 'package:video_player_app/functions/create_playlist_functions.dart';

class AddtoPlaylistDialog extends StatefulWidget {

  final String files;
  const AddtoPlaylistDialog({
    super.key,
    required this.files,
    //required this.index,
  });

  @override
  State<AddtoPlaylistDialog> createState() => _AddtoPlaylistDialogState();
}

class _AddtoPlaylistDialogState extends State<AddtoPlaylistDialog> {
//final RecentlyPlayedVideoTileWidget parent;
  // final box = await Hive.openBox<VideoPlaylist>('playlists_data');
  String? selectedPlaylist ;
  @override
  void initState() {
    selectedPlaylist = ' ';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    String newPlaylistName = '';
    return AlertDialog(
      backgroundColor: kcolorblack54,
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
                                .map<DropdownMenuItem<String>>((String? value) {
                              return DropdownMenuItem<String>(
                                value: value!,
                                child: Text(
                                  value,
                                  style: const TextStyle(color: kColorWhite),
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

              await CreatePlayListFunctions.addVideoToPlaylist(newPlaylistName,
                  widget.files);

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
              await CreatePlayListFunctions.addVideoToPlaylist(selectedPlaylist ?? '',
                  widget.files);
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
  }
}
