import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/functions/mostly_played_functions.dart';
import 'package:video_player_app/functions/recently_played_functions.dart';
import 'package:video_player_app/screens/PlayList/playlist%20videoplayer/VideoPlayer/video_player_widget.dart';
import 'package:video_player_app/screens/PlayList/widget/recently_played/video_tile_recently.dart';
import 'package:video_player_app/screens/PlayList/widget/recently_played/widgets/thumbnail.dart';
import 'package:video_player_app/widgets/addtoplaylist.dart';


class ListTileRecentlyPlayed extends StatefulWidget {
  const ListTileRecentlyPlayed({
    super.key,
    required this.widget,
  });

  final RecentlyPlayedVideoTileWidget widget;

  @override
  State<ListTileRecentlyPlayed> createState() => _ListTileRecentlyPlayedState();
}

class _ListTileRecentlyPlayedState extends State<ListTileRecentlyPlayed> {
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
                      files: widget.widget.files[widget.widget.index].videoPath,
                    );
                  },
                );
              }),
          PopupMenuItem<Widget>(
            onTap: () {
              deleteVideo(widget.widget.files[widget.widget.index].videoPath);
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
            widget.widget.files[widget.widget.index].videoPath);
        RecentlyPlayed.onVideoClicked(
            videoPath: widget.widget.files[widget.widget.index].videoPath);
        RecentlyPlayed.checkHiveData();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => RecentlyPlayedVideoScreen(
              currentIndex: widget.widget.index,
              videoPaths: widget.widget.files,
            ),
          ),
        );
      },
      leading: ThumbnailRecentlyPlayed(
        widget: widget.widget,
      ),
      title: Text(basename(widget.widget.files[widget.widget.index].videoPath),
          maxLines: 1, overflow: TextOverflow.ellipsis, style: favorites),
      subtitle: Text(
        '${(calculateProgress(widget.widget.current, widget.widget.full)! * 100).round()}%',
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
