import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:video_player_app/Screens/playlist/playlist%20videoplayer/VideoPlayer/video_player_widget.dart';
import 'package:video_player_app/database/video_data.dart';
import 'package:video_player_app/functions/mostly_played_functions.dart';
import 'package:video_player_app/functions/recently_played_functions.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/functions/video_functions.dart';

class RecentlyPlayedVideoTile extends StatefulWidget {
  final List<RecentlyPlayedData> files;
  final int index;
  final File thumbnail;

  const RecentlyPlayedVideoTile({
    Key? key,
    required this.thumbnail,
    required this.files,
    required this.index,
  }) : super(key: key);

  @override
  State<RecentlyPlayedVideoTile> createState() =>
      _RecentlyPlayedVideoTileState();
}

class _RecentlyPlayedVideoTileState extends State<RecentlyPlayedVideoTile> {
  Future<void> loadVideoInfo() async {
    try {
      final info = await VideoFunctions.getVideoInfo(
          widget.files[widget.index].videoPath);
      videoInfoNotifier.value = info;
    } catch (e) {
      videoInfoNotifier.value = [];
    }
  }

  @override
  void didUpdateWidget(covariant RecentlyPlayedVideoTile oldWidget) {
    if (oldWidget.files != widget.files) {
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
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
              setState(() async {
                await RecentlyPlayed.deleteVideo(
                    widget.files[widget.index].videoPath);
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

    return Padding(
      padding: const EdgeInsets.only(
        left: 5,
        bottom: 10,
      ),
      child: ValueListenableBuilder(
        valueListenable: Hive.box<RecentlyPlayedData>('recently_played')
            .listenable(), // Listen to changes in the list
        builder: (context, recentlyPlayedList, child) {
          final box = recentlyPlayedList.values.toList();
          if (box.isEmpty) {
            return Center(
              child: Text('No data Available'),
            );
          }

          // if (widget.index >= 0 && widget.index < box.length) {

          // }
          final current =
              box[widget.index].current?.inMilliseconds.toDouble() ?? 0.0;
          final full = box[widget.index].full?.inMilliseconds.toDouble() ?? 0.0;

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
                      value: calculateProgress(current, full),
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
              '${(calculateProgress(current, full)! * 100).round()}%',
              style: GoogleFonts.nixieOne(),
            ),
            trailing: GestureDetector(
              onTapDown: (details) => showPopupMenu(details.globalPosition),
              child: const Icon(Icons.more_vert),
            ),
          );
        },
      ),
    );
  }
}
