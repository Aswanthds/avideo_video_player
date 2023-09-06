import 'package:flutter/material.dart';
import 'package:video_player_app/Screens/Favorites/widgets/playlist_thumbnal_widget.dart';
import 'package:video_player_app/Screens/Favorites/widgets/video_listtile_widget.dart';

class FavouritesPageScreen extends StatefulWidget {
  const FavouritesPageScreen({super.key});

  @override
  State<FavouritesPageScreen> createState() => _FavouritesPageScreenState();
}

class _FavouritesPageScreenState extends State<FavouritesPageScreen> {
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
              'Favourites',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.search))
            ],
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            PlayListThumbnailWidget(),
            SizedBox(
              height: 20,
            ),
            VideoListTileWidget(),
          ],
        ),
      ),
    );
  }
}
