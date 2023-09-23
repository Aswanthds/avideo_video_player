import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path/path.dart';
import 'package:video_player_app/Screens/playlist/playlist%20videoplayer/VideoPlayer/video_player_widget.dart';
import 'package:video_player_app/database/create_playlist_data.dart';
import 'package:video_player_app/functions/create_playlist_functions.dart';
import 'package:video_player_app/screens/PlayList/widget/user_playlist.dart/user_playlist.dart';

class PlaylistDetailPage extends StatefulWidget {
  final VideoPlaylist playlist;

  PlaylistDetailPage({super.key, required this.playlist});

  @override
  State<PlaylistDetailPage> createState() => _PlaylistDetailPageState();
}

class _PlaylistDetailPageState extends State<PlaylistDetailPage> {
  // List<VideoPlaylist> playlists = [];

  // @override
  // void initState() {
  //   super.initState();
  //   loadPlaylists();
  // }

  // Future<void> loadPlaylists() async {
  //   final Box<VideoPlaylist> playlistBox =
  //       await Hive.openBox<VideoPlaylist>('playlists_data');
  //   setState(() {
  //     playlists = playlistBox.values.toList();
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.playlist.name ?? ''),
      ),
      body: ListView.builder(
        itemCount: widget.playlist.videos!.length,
        itemBuilder: (context, index) {
          final videoPath = widget.playlist.videos![index];
          return ListTile(
            onLongPress: () => CreatePlayListFunctions.deleteVideoFromPlaylist(
                widget.playlist.name!, widget.playlist.videos![index]),
            title: Text(basename(videoPath)),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => VideoPlaylistScreen(
                      videoPaths: widget.playlist, currentIndex: index),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
