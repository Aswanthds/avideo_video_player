import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player_app/Screens/favorites/widgets/playlist_thumbnal_widget.dart';
import 'package:video_player_app/database/favourite_data.dart';
import 'package:video_player_app/functions/favorites_functions.dart';
import 'package:video_player_app/Screens/Home/widgets/home_search_page.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/screens/favorites/widgets/favorites_video_widget.dart';

class FavouritesPageScreen extends StatefulWidget {
  const FavouritesPageScreen({super.key});

  @override
  State<FavouritesPageScreen> createState() => _FavouritesPageScreenState();
}

class _FavouritesPageScreenState extends State<FavouritesPageScreen> {
  final ValueNotifier<Uint8List?> thumbnailNotifier =
      ValueNotifier<Uint8List>(Uint8List(0));

  List<FavoriteData> videos = [];

  Future<void> updateThumbnails() async {
    final list = await FavoriteFunctions.getFavoritesList();
    setState(() {
      videos = list;
    });
    for (final video in videos) {
      try {
        final thumbnailFile = await VideoCompress.getByteThumbnail(
          video.filePath,
          quality: 10,
          position: -1,
        );
        thumbnailNotifier.value = thumbnailFile;
      } catch (e) {
        debugPrint('Error generating thumbnail for ${video.filePath}: $e');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    updateThumbnails();
  }

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
            backgroundColor: kcolorDarkblue,
            title: const Text(
              'Favourites',
              // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HomeSearchPaage(
                        text: 'Search videos..',
                        files: videos.map((e) => File(e.filePath)).toList(),
                      ),
                    ));
                  },
                  icon: const Icon(Icons.search))
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const PlayListThumbnailWidget(),
          Expanded(
            child: ListView.builder(
              itemCount: videos.length,
              itemBuilder: (context, index) {
                final video = videos[index];
                return VideoListTileWidget(video: video);
              },
            ),
          ),
        ],
      ),
    );
  }
}
