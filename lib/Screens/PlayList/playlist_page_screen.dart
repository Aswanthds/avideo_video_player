import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:video_player_app/Screens/playlist/most_played_videos.dart';
import 'package:video_player_app/Screens/playlist/recent_played_videos_page.dart';
import 'package:video_player_app/Screens/playlist/widget/playlist%20create/playlist_bottom_sheet.dart';
import 'package:video_player_app/Screens/playlist/widget/playlist_widget.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/database/create_playlist_data.dart';
import 'package:video_player_app/functions/create_playlist_functions.dart';
import 'package:video_player_app/screens/PlayList/widget/user_playlist_screen.dart';

class PlaylistPageScreen extends StatefulWidget {
  const PlaylistPageScreen({
    super.key,
  });

  @override
  State<PlaylistPageScreen> createState() => _PlaylistPageScreenState();
}

class _PlaylistPageScreenState extends State<PlaylistPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(75),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(24),
          ),
          child: AppBar(
            automaticallyImplyLeading: false,
            iconTheme: const IconThemeData(color: kColorWhite),
            backgroundColor: kcolorDarkblue,
            title: const Text(
              'Playlists',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  fontFamily: 'Cookie'),
            ),
            actions: [
              IconButton(
                  onPressed: () => showDialog(
                        context: context,
                        builder: (context) => const PlaylistBottomSheet(
                          playlistIcon: Icons.abc,
                          playlistName: 'Create a playlist',
                        ),
                      ),
                  icon: const Icon(Icons.add_box))
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const RecentlyPlayedVideosPage())),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: PlayListWidget(
                  title: 'Recently Played Videos ',
                ),
              )),
          InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MostPlayedVideos())),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: PlayListWidget(
                  title: 'Most Played Videos ',
                ),
              )),
          Expanded(
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kColorWhite12,
                  ),
                  child: const PlaylistListWidget())),
        ],
      ),
    );
  }
}

class PlaylistListWidget extends StatefulWidget {
  const PlaylistListWidget({Key? key}) : super(key: key);

  @override
  State<PlaylistListWidget> createState() => _PlaylistListWidgetState();
}

class _PlaylistListWidgetState extends State<PlaylistListWidget> {
  List<VideoPlaylist> playlists = [];
  @override
  void initState() {
    super.initState();
    loadPlaylists();
  }

  Future<void> loadPlaylists() async {
    final Box<VideoPlaylist> playlistBox =
        await Hive.openBox<VideoPlaylist>('playlists_data');
    final Set<String> uniquePaths =
        <String>{}; // Use a Set to keep track of unique paths

    // Iterate through playlistBox and add unique paths to the set
    for (final playlist in playlistBox.values) {
      uniquePaths.addAll(playlist.videos!);
    }

    final List<VideoPlaylist> uniquePlaylists = uniquePaths.map((path) {
      return VideoPlaylist(
        name: 'Playlist', // You can set a default name here if needed
        videos: [path],
      );
    }).toList();

    setState(() {
      playlists = uniquePlaylists;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<VideoPlaylist>('playlists_data').listenable(),
      builder: (context, Box<VideoPlaylist> box, _) {
        final playlists = box.values.toList();

        return ListView.builder(
          itemCount: playlists.length,
          itemBuilder: (context, index) {
            final playlist = playlists[index];

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: const Text('Are you sure ?'),
                      actions: [
                        TextButton.icon(
                          onPressed: () {
                            CreatePlayListFunctions.deletePlaylist(
                                playlist.name!);
                            Navigator.of(context).pop();
                          },
                          label: const Text('Delete'),
                          icon: const Icon(Icons.delete_forever_outlined),
                        )
                      ],
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      clipBehavior: Clip.antiAlias,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: kColorCyan,
                      content: Text(
                          'Video added to playlist'), // Customize the message
                      duration: Duration(seconds: 2), // Customize the duration
                    ),
                  );
                },
                leading: Container(
                  decoration: BoxDecoration(
                      color: kcolorDarkblue,
                      border: Border.all(
                        style: BorderStyle.solid,
                        color: kcolorDarkblue,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20)),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.playlist_play,
                      color: kColorWhite,
                      size: 40,
                    ),
                  ),
                ),
                title: Text(
                  playlist.name ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PlaylistDetailPage(
                      playlist: playlist,
                    ),
                  ));
                },
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_ios),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
