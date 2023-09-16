import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:video_player_app/constants.dart';

class VideoPlayerAppBar extends StatelessWidget {
  const VideoPlayerAppBar({
    super.key,
    required this.filename,
  });

  final String filename;

  @override
  Widget build(BuildContext context) {
    final String filenameShort = basename(filename);
    return Container(
      width: MediaQuery.of(context).size.width,
      color: kcolorblack54,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            IconButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: kColorWhite,
                )),
            Expanded(
              child: Text(
                filenameShort,
                style: const TextStyle(
                  color: kColorWhite,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const Icon(
              Icons.more_vert,
              color: kColorWhite,
            )
          ]),
    );
  }
}
