import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:video_player_app/Screens/Home/Tabs/widgets/video_tile_widget.dart';
import 'package:video_player_app/constants.dart';

class VideoThumbnailCommon extends StatelessWidget {
  const VideoThumbnailCommon({
    super.key,
    required this.thumbnailNotifier, required this.videoFile, 
     
  });

  final ValueNotifier<Uint8List?> thumbnailNotifier;
  final File videoFile;
  

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ValueListenableBuilder<Uint8List?>(
            valueListenable: thumbnailNotifier,
            builder: (context, thumbnail, child) {
              if (thumbnail!.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: kcolorDarkblue,
                  ),
                );
              } else {
                return Stack(
                  children: [
                    Container(
                      width: 160,
                      height: 100,
                      decoration: BoxDecoration(
                        color: kcolorDarkblue,
                        border: Border.all(
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          image: MemoryImage(
                            thumbnail,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              basename(videoFile.path),
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
    );
  }
}
