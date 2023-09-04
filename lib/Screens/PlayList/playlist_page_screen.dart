import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player_app/Screens/PlayList/recent_played_videos.dart';
import 'package:video_player_app/Screens/Settings/privacy_screen.dart';

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
              backgroundColor: const Color(0xF1003554),
              title: const Text(
                'Playlists',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.search))
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MostPlayedPage())),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              const BoxShadow(
                                  color: Color(0xF1003554),
                                  blurRadius: 10,
                                  blurStyle: BlurStyle.outer),
                            ],
                            color: const Color(0xF1003554),
                            border: Border.all(
                              style: BorderStyle.solid,
                              color: const Color(0xF1003554),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'images/logo.png',
                              color: Colors.white,
                            ))),
                    title: Text('Video'),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xF1003554),
                      fill: 0,
                    ),
                  ),
                )),
          ],
        ));
  }
}
