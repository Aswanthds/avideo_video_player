import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/database/favourite_data.dart';
import 'package:video_player_app/widgets/VideoPlayer/video_player_widget.dart';

class VideoListTileWidget extends StatefulWidget {
  final FavoriteData video;
  final int index;
  final VideoDeleteCallback onDelete;

  const VideoListTileWidget({
    super.key,
    required this.video,
    required this.index,
    required this.onDelete,
  });

  @override
  State<VideoListTileWidget> createState() => _VideoListTileWidgetState();
}

typedef VideoDeleteCallback = void Function();

class _VideoListTileWidgetState extends State<VideoListTileWidget> {
  File? thumbnailFile;

  @override
  void initState() {
    super.initState();
    // Generate the thumbnail when the widget is created
    generateThumbnail(widget.video.filePath, widget.index);
  }

  Future<void> generateThumbnail(String path, int index) async {
    // Accept index parameter
    try {
      final file = await VideoCompress.getFileThumbnail(
        path,
        quality: 10,
        position: -1,
      );
      if (mounted) {
        setState(() {
          thumbnailFile = file;
        });
      }
    } catch (e) {
      debugPrint('Error generating thumbnail: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final videoFilePath = widget.video.filePath;
    showPopupMenu(Offset offset) async {
      double left = offset.dx;
      double top = offset.dy;
      await showMenu(
        context: context,
        position: RelativeRect.fromLTRB(left, top, 30, 0),
        items: [
          const PopupMenuItem<Widget>(
            child: Row(
              children: [
                Icon(Icons.favorite_outline),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Add to favorites'),
                ),
              ],
            ),
          ),
          const PopupMenuItem<Widget>(
            child: Row(
              children: [
                Icon(Icons.playlist_add),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Add to Playlist'),
                ),
              ],
            ),
          ),
          PopupMenuItem<Widget>(
              child: const Row(
                children: [
                  Icon(Icons.delete),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Remove from favorites'),
                  ),
                ],
              ),
              onTap: () => widget.onDelete()),
        ],
        elevation: 8.0,
      );
    }

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 5.0,
        top: 5.0,
      ),
      child: ListTile(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => VideoPlayerScreen(filesV: videoFilePath),
          ),
        ),
        leading: thumbnailFile != null
            ? Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: kcolorDarkblue,
                  border: Border.all(
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(thumbnailFile!),
                  ),
                ),
              )
            : Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                  ),
                )),
        title: Text(
          basename(videoFilePath),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 15,
              color: kcolorDarkblue,
              fontWeight: FontWeight.bold,
              fontFamily: 'NixieOne'),
        ),
        trailing: GestureDetector(
          onTapDown: (TapDownDetails details) {
            showPopupMenu(details.globalPosition);
          },
          child: const Icon(Icons.more_vert),
        ),
      ),
    );
  }
}
