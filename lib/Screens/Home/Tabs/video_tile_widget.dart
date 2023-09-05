import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player_app/functions/compress_fns.dart';
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
        quality: 50,
        position: -1,
      );
      thumbnailNotifier.value = thumbnailFile;
    } catch (e) {
      print('Error generating thumbnail: $e');
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
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ValueListenableBuilder(
                valueListenable: thumbnailNotifier,
                builder: (context, thumbnail, child) => Container(
                    width: 160,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                          image: FileImage(
                            thumbnail,
                          ),
                        )))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                basename(widget.videoFile.path),
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
    );
  }
}

class MenuIconWidget extends StatelessWidget {
  final String title;

  final IconData icon;

  const MenuIconWidget({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
      child: Column(
        children: [
          CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey,
              child: Center(child: Icon(icon))),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
