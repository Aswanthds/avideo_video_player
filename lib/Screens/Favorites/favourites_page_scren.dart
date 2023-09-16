import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player_app/Screens/favorites/widgets/playlist_thumbnal_widget.dart';
import 'package:video_player_app/database/favourite_data.dart';
import 'package:video_player_app/functions/favorites_functions.dart';
import 'package:video_player_app/Screens/Home/widgets/home_search_page.dart';
import 'package:video_player_app/constants.dart';

class FavouritesPageScreen extends StatefulWidget {
  const FavouritesPageScreen({super.key});

  @override
  State<FavouritesPageScreen> createState() => _FavouritesPageScreenState();
}

class _FavouritesPageScreenState extends State<FavouritesPageScreen> {
  final ValueNotifier<Uint8List?> thumbnailNotifier =
      ValueNotifier<Uint8List>(Uint8List(0));

  FavoriteData? path;
  final video = FavoriteFunctions.getFavoritesList();
  Future<FavoriteData> getVideopath() async {
    for (FavoriteData fvrt in video) {
      path = fvrt;
    }
    return path!;
  }

  Future<void> updateThumbnail() async {
    final path = await getVideopath();
    try {
      final thumbnailFile = await VideoCompress.getByteThumbnail(
        path.filePath,
        quality: 10,
        position: -1,
      );

      thumbnailNotifier.value = thumbnailFile!;
    } catch (e) {
      debugPrint('Error generating thumbnail: $e');
    }
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
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            actions: [
              IconButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            const HomeSearchPaage(text: 'Search videos..'),
                      )),
                  icon: const Icon(Icons.search))
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
          ],
        ),
      ),
    );
  }
}
