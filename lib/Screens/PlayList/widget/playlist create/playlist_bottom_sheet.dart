import 'package:flutter/material.dart';
import 'package:video_player_app/Screens/playlist/widget/playlist%20create/playlist_form.dart';

class PlaylistBottomSheet extends StatefulWidget {
  final String playlistName;
  final IconData playlistIcon;

  const PlaylistBottomSheet({
    super.key,
    required this.playlistName,
    required this.playlistIcon,
  });

  @override
  State<PlaylistBottomSheet> createState() => _PlaylistBottomSheetState();
}

class _PlaylistBottomSheetState extends State<PlaylistBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: AlertDialog(
        contentPadding: EdgeInsets.zero, //
        content: SizedBox(
          height: 300, //
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.playlistName,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              const Divider(),
              const PlaylistForm(),
            ],
          ),
        ),
      ),
    );
  }
}
