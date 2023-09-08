import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player_app/Screens/Home/Tabs/widgets/menu_icon.dart';
import 'package:video_player_app/Screens/Home/Tabs/widgets/video_common_thumbnail.dart';
import 'package:video_player_app/widgets/VideoPlayer/video_player_widget.dart';
import 'package:video_player_app/widgets/videoplayer_widget.dart';

class VideoTileWidget extends StatefulWidget {
  final File videoFile;

  const VideoTileWidget({
    Key? key,
    required this.videoFile,
  }) : super(key: key);

  @override
  State<VideoTileWidget> createState() => _VideoTileWidgetState();
}

class _VideoTileWidgetState extends State<VideoTileWidget> {
  final ValueNotifier<Uint8List?> thumbnailNotifier =
      ValueNotifier<Uint8List>(Uint8List(0));

  @override
  void initState() {
    super.initState();
    updateThumbnail();
  }
Future<void> updateThumbnail() async {
    try {
      final thumbnailFile = await VideoCompress.getByteThumbnail(
        widget.videoFile.path,
        quality: 50,
        position: -1,
      );

      thumbnailNotifier.value = thumbnailFile!;
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
                  child: const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MenuIconWidget(
                          title: 'Add to PlayList',
                          icon: Icons.playlist_add,
                        ),
                        MenuIconWidget(
                          title: 'Add to Favorites',
                          icon: Icons.favorite,
                        ),
                        MenuIconWidget(
                          title: 'Share Video',
                          icon: Icons.ios_share,
                        ),
                        MenuIconWidget(
                          title: 'Info',
                          icon: Icons.info_outlined,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]);
          },
        );
      },
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              VideoPlayerScreen(filesV: widget.videoFile.path),
        ));
      },
      child: VideoThumbnailCommon(
          thumbnailNotifier: thumbnailNotifier, widget: widget),
    );
  }
}
