import 'package:flutter/material.dart';
import 'package:video_player_app/Screens/playlist/widget/playlist%20create/playlist_form.dart';


class PlaylistBottomSheet extends StatelessWidget {
  final String playlistName;
  final IconData playlistIcon;

  PlaylistBottomSheet({
    required this.playlistName,
    required this.playlistIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: AlertDialog(
        contentPadding: EdgeInsets.zero, // Remove default padding
        content: Container(
          height: 300, // Match the container height
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  playlistName,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Divider(), // Add a divider for separation
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PlaylistForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
