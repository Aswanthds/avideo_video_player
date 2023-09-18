import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player_app/Screens/home/Tabs/widgets/video_menu_row.dart';
import 'package:video_player_app/Screens/home/Tabs/widgets/video_common_thumbnail.dart';
import 'package:video_player_app/functions/mostly_played_functions.dart';
import 'package:video_player_app/functions/recently_played_functions.dart';
import 'package:video_player_app/widgets/VideoPlayer/video_player_widget.dart';

class VideoTileWidget extends StatefulWidget {
  final File videoFile;
  final int index;

  const VideoTileWidget({
    Key? key,
    required this.videoFile,
    required this.index,
  }) : super(key: key);

  @override
  State<VideoTileWidget> createState() => _VideoTileWidgetState();
}

class _VideoTileWidgetState extends State<VideoTileWidget> {
  final ValueNotifier<File> thumbnailNotifier = ValueNotifier<File>(File(''));

  @override
  void initState() {
    super.initState();
    updateThumbnail();
  }

  Future<void> updateThumbnail() async {
    try {
      final thumbnailFile = await VideoCompress.getFileThumbnail(
        widget.videoFile.path,
        quality: 10,
        position: -1,
      );

      thumbnailNotifier.value = thumbnailFile;
    } catch (e) {
      debugPrint('Error generating thumbnail: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Wrap(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: VideoMenuRow(
                      widget.videoFile.path,
                    ),
                  ),
                ),
              ),
            ]);
          },
        );
      },
      onTap: () {
        MostlyPlayedFunctions.addVideoPlayData(widget.videoFile.path);
        RecentlyPlayed.onVideoClicked(videoPath: widget.videoFile.path);
        RecentlyPlayed.checkHiveData();
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              VideoPlayerScreen(filesV: widget.videoFile.path),
        ));
      },
      child: VideoThumbnailCommon(
        thumbnailNotifier: thumbnailNotifier,
        videoFile: widget.videoFile,
      ),
    );
  }
}
