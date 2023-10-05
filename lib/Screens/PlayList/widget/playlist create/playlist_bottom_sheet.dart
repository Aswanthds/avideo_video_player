import 'package:flutter/material.dart';
import 'package:video_player_app/Screens/playlist/widget/playlist%20create/playlist_form.dart';
import 'package:video_player_app/constants.dart';

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
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: kcolorblack,
                style: BorderStyle.solid,
                width: 3.0,
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.playlistName,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(),
                PlaylistForm(files: widget.playlistName),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
