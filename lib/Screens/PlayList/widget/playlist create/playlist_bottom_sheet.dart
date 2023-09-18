import 'package:flutter/material.dart';
import 'package:video_player_app/Screens/playlist/widget/playlist%20create/playlist_form.dart';


class PlaylistBottomSheet extends StatelessWidget {
  final String playlistName;
  final IconData playlistIcon;

  const PlaylistBottomSheet({super.key, 
    required this.playlistName,
    required this.playlistIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: AlertDialog(
        contentPadding: EdgeInsets.zero, // Remove default padding
        content: SizedBox(
          height: 300, // Match the container height
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  playlistName,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              const Divider(), // Add a divider for separation
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: PlaylistForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
