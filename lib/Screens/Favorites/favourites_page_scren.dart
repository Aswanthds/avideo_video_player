import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:video_player_app/Screens/favorites/widgets/playlist_thumbnal_widget.dart';
import 'package:video_player_app/database/favourite_data.dart';
import 'package:video_player_app/functions/favorites_functions.dart';
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

  @override
  void initState() {
    super.initState();
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
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  fontFamily: 'Cookie'),
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const PlayListThumbnailWidget(),
          ValueListenableBuilder(
            valueListenable:
                Hive.box<FavoriteData>('favorite_videos').listenable(),
            builder: (context, Box<FavoriteData> box, _) {
              final playlists = box.values.toList();

              // Remove duplicate videos
              final uniqueVideos =
                  FavoriteFunctions.removeDuplicateVideos(playlists);

              if (uniqueVideos.isEmpty) {
                return Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width / 2 - 10,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_box_outlined,
                        color: kColorIndigo,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Add Video to favorites',
                        style: TextStyle(color: kColorIndigo),
                      ),
                    ],
                  ),
                );
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: uniqueVideos.length,
                  itemBuilder: (context, index) {
                    if (index < uniqueVideos.length) {
                      return VideoListTileWidget(
                        index: index,
                        video: uniqueVideos[index],
                      );
                    }
                    return const SizedBox();
                  },
                ),
              );
            },
          )

          // ValueListenableBuilder(
          //   valueListenable:
          //       Hive.box<FavoriteData>('favorite_videos').listenable(),
          //   builder: (context, Box<FavoriteData> box, _) {
          //     final playlists = box.values.toList();
          //     if (videos.isEmpty) {
          //       return Padding(
          //         padding: EdgeInsets.only(
          //             top: MediaQuery.of(context).size.width / 2 - 10),
          //         child: const Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Icon(
          //               Icons.add_box_outlined,
          //               color: kColorIndigo,
          //             ),
          //             SizedBox(
          //               width: 10,
          //             ),
          //             Text(
          //               'Add Video to favorites',
          //               style: TextStyle(color: kColorIndigo),
          //             ),
          //           ],
          //         ),
          //       );
          //     }
          //     return Expanded(
          //       child: ListView.builder(
          //         itemCount: videos.length,
          //         itemBuilder: (context, index) {
          //           if (index < videos.length) {
          //             return VideoListTileWidget(
          //               index: index,
          //               video: videos[index],
          //             );
          //           }
          //           return const SizedBox();
          //         },
          //       ),
          //     );
          //   },
          // )
        ],
      ),
    );
  }
}
