import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:video_player_app/widgets/videoplayer_widget.dart';

class ScreenRecordsTab extends StatefulWidget {
  final List<File> filesV;
  const ScreenRecordsTab({super.key, required this.filesV});

  @override
  State<ScreenRecordsTab> createState() => _ScreenRecordsTabState();
}

class _ScreenRecordsTabState extends State<ScreenRecordsTab> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: widget.filesV.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        final videoPath = widget.filesV[index];
        final videoFileName = basename(videoPath.path);
        //final videoFile = videoFiles[index];

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => VideoPlayerScreen(
                        filesV: videoPath.path,
                      )),
            ),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(style: BorderStyle.solid, width: 0.5),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  const Icon(
                    Icons.smart_display_rounded,
                    size: 120,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      videoFileName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
