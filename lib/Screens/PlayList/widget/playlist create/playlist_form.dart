import 'package:flutter/material.dart';
import 'package:video_player_app/constants.dart';

import 'package:video_player_app/functions/create_playlist_functions.dart';

class PlaylistForm extends StatefulWidget {
  final String files;
  const PlaylistForm({super.key, required this.files});

  @override
  State<PlaylistForm> createState() => _PlaylistFormState();
}

class _PlaylistFormState extends State<PlaylistForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _playlistNameController = TextEditingController();

  @override
  void dispose() {
    _playlistNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _playlistNameController,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kcolorblack,
                      width: 3.0,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kcolorblack,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                labelText: 'Playlist Name',
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: kcolorblack),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a playlist name';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 20.0),
          const SizedBox(height: 20.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: kcolorblack,
            ),
            onPressed: () {
              String newPlaylistName = _playlistNameController.text;
              if (newPlaylistName.isNotEmpty) {
                CreatePlayListFunctions.createPlaylist(newPlaylistName);

                CreatePlayListFunctions.addVideoToPlaylist(
                    newPlaylistName, widget.files);

                Navigator.of(context).popUntil((route) => route.isFirst);
                ScaffoldMessenger.of(context)
                    .showSnackBar(postiveNewPlaylist); //
              }
            },
            child: const Text(
              'Create Playlist',
              style: TextStyle(
                color: kColorWhite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
