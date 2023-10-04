import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/database/recently_video_data.dart';
import 'package:video_player_app/functions/mostly_played_functions.dart';
import 'package:video_player_app/functions/recently_played_functions.dart';
import 'package:video_player_app/screens/PlayList/playlist%20videoplayer/VideoPlayer/video_player_widget.dart';
import 'package:video_player_app/screens/PlayList/widget/recently_played/widgets/thumbnail.dart';
import 'package:video_player_app/widgets/addtoplaylist.dart';

class RecentlyPlayedVideoTileWidget extends StatefulWidget {
  const RecentlyPlayedVideoTileWidget({
    super.key,
    required this.current,
    required this.full,
    required this.files,
    required this.index,
    required this.thumbnail,
  });

  final double current;
  final double full;
  final List<RecentlyPlayedData> files;
  final int index;
  final File thumbnail;

  @override
  State<RecentlyPlayedVideoTileWidget> createState() =>
      _RecentlyPlayedVideoTileWidgetState();
}

class _RecentlyPlayedVideoTileWidgetState extends State<RecentlyPlayedVideoTileWidget> {
  String selectedPlaylist = '';
  @override
  Widget build(BuildContext context) {
     void deleteVideo(String videoPath) {
      RecentlyPlayed.deleteVideo(videoPath);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: kcolorblack05,
          content: const Text('Video deleted'), //
          duration: const Duration(seconds: 2), //
          action: SnackBarAction(
            label: 'Close',
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      );
    }

    showPopupMenu(Offset offset) async {
      double left = offset.dx;
      double top = offset.dy;
      await showMenu(
        context: context,
        position: RelativeRect.fromLTRB(left, top, 30, 0),
        items: [
          PopupMenuItem<Widget>(
              child: const Row(
                children: [
                  Icon(Icons.playlist_add),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Add to Playlist'),
                  ),
                ],
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AddtoPlaylistDialog(
                      files: widget.files[widget.index].videoPath,
                    );
                  },
                );
              }),
          PopupMenuItem<Widget>(
            onTap: () {
              deleteVideo(widget.files[widget.index].videoPath);
              Navigator.of(context).pop();
              setState(() {});
            },
            child: const Row(
              children: [
                Icon(Icons.remove),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Remove'),
                ),
              ],
            ),
          ),
        ],
        elevation: 8.0,
      );
    }
    

  
    return ListTile(
      onTap: () {
        MostlyPlayedFunctions.addVideoPlayData(
            widget.files[widget.index].videoPath);
        RecentlyPlayed.onVideoClicked(
            videoPath: widget.files[widget.index].videoPath);
        RecentlyPlayed.checkHiveData();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => RecentlyPlayedVideoScreen(
              currentIndex: widget.index,
              videoPaths: widget.files,
            ),
          ),
        );
      },
      leading: ThumbnailRecentlyPlayed(
        current : widget.current , full: widget.full,
        thumbnail: widget.thumbnail
      ),
      title: Text(basename(widget.files[widget.index].videoPath),
          maxLines: 1, overflow: TextOverflow.ellipsis, style: favorites),
      subtitle: Text(
        '${(calculateProgress(widget.current, widget.full)! * 100).round()}%',
        style: const TextStyle(),
      ),
      trailing: GestureDetector(
        onTapDown: (details) => showPopupMenu(details.globalPosition),
        child: const Icon(Icons.more_vert),
      ),
    );
  }

  double? calculateProgress(double? current, double? full) {
    if (current == null ||
        full == null ||
        current.isNaN ||
        full.isNaN ||
        full <= 0) {
      return 0.0; //
    }
    return current / full;
  }
}




