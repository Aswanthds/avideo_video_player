import 'package:flutter/material.dart';

import 'package:video_player_app/functions/create_playlist_functions.dart';

class PlaylistForm extends StatefulWidget {
  const PlaylistForm({super.key});

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
          TextFormField(
            controller: _playlistNameController,
            decoration: const InputDecoration(
                labelText: 'Playlist Name', border: OutlineInputBorder()),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a playlist name';
              }
              return null;
            },
          ),
          const SizedBox(height: 20.0),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                String playlistName = _playlistNameController.text;

                _formKey.currentState!.reset();
                CreatePlayListFunctions.createPlaylist(playlistName);

                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Playlist created: $playlistName')),
                );
              }
            },
            child: const Text('Create Playlist'),
          ),
        ],
      ),
    );
  }
}
