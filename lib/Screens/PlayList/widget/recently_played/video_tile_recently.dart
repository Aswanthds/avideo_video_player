import 'dart:io';

import 'package:google_fonts/google_fonts.dart';
import 'package:video_player_app/Screens/playlist/playlist%20videoplayer/VideoPlayer/video_player_widget.dart';
import 'package:video_player_app/database/recently_video_data.dart';
import 'package:video_player_app/functions/mostly_played_functions.dart';
import 'package:video_player_app/functions/recently_played_functions.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/screens/PlayList/playlist_page_screen.dart';
import 'package:video_player_app/screens/PlayList/widget/recently_played/recently_played_video_tile.dart';

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

class _RecentlyPlayedVideoTileWidgetState
    extends State<RecentlyPlayedVideoTileWidget> {
  @override
  Widget build(BuildContext context) {
    double? calculateProgress(double? current, double? full) {
      if (current == null ||
          full == null ||
          current.isNaN ||
          full.isNaN ||
          full <= 0) {
        return 0.0; // Return a default value (e.g., 0.0) when division is undefined
      }
      return current / full;
    }

    void deleteVideo(String videoPath) {
      RecentlyPlayed.deleteVideo(videoPath);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Video deleted'), // Customize the message
          duration: Duration(seconds: 2), // Customize the duration
          action: SnackBarAction(
            label: 'Undo', // You can add an undo action if needed
            onPressed: () {
              // Implement undo logic if needed
            },
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
            onTap: () {
              setState(() {
                deleteVideo(widget.files[widget.index].videoPath);
              });
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

    return (widget.index == -1)
        ? Center(
            child: Text('No videos'),
          )
        : ListTile(
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
            leading: Stack(
              children: [
                Container(
                  width: 100,
                  height: 160,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: kcolorblack,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: FileImage(widget.thumbnail),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: LinearProgressIndicator(
                      minHeight: 2,
                      value: calculateProgress(widget.current, widget.full),
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(kcolorDarkblue),
                      backgroundColor: kColorWhite54,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
            title: Text(
              basename(widget.files[widget.index].videoPath),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.nixieOne(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              '${(calculateProgress(widget.current, widget.full)! * 100).round()}%',
              style: GoogleFonts.nixieOne(),
            ),
            trailing: GestureDetector(
              onTapDown: (details) => showPopupMenu(details.globalPosition),
              child: const Icon(Icons.more_vert),
            ),
          );
  }
}
