import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:video_player_app/Screens/settings/settings_page.dart';
import 'package:video_player_app/Screens/favorites/favourites_page_scren.dart';
import 'package:video_player_app/Screens/Home/home_page_screen.dart';
import 'package:video_player_app/Screens/playlist/playlist_page_screen.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/functions/path_functions.dart';

class MainPageScreen extends StatefulWidget {
  final List<File> videoFile;
  final List<Uint8List>? thumbnail;
  const MainPageScreen({Key? key, this.thumbnail, required this.videoFile})
      : super(key: key);

  @override
  State<MainPageScreen> createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<MainPageScreen>
    with SingleTickerProviderStateMixin {
  int _bottomNavIndex = 0;
  List<File> videoFiles = [];
  List<String> videoData = [];
  @override
  void initState() {
    super.initState();
    fetchAndShowVideos();
  }

  void fetchAndShowVideos() async {
    final fetchedVideos = await PathFunctions.getPath();

    setState(() {
      videoData = List<String>.from(fetchedVideos);
      videoFiles = fetchedVideos.map((path) => File(path)).toList();
    });

    debugPrint('All Video Data:');
    for (String data in videoData) {
      debugPrint(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPage(),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: SalomonBottomBar(
          backgroundColor: kcolorDarkblue,
          currentIndex: _bottomNavIndex,
          onTap: (i) => setState(() => _bottomNavIndex = i),
          items: [
            //
            SalomonBottomBarItem(
                icon: const Icon(Icons.home),
                title: const Text(
                  "Home",
                  style: TextStyle(fontFamily: 'Koulen'),
                ),
                selectedColor: kColorAmber,
                unselectedColor: kColorWhite),

            //
            SalomonBottomBarItem(
                icon: const Icon(Icons.playlist_play),
                title: const Text(
                  "Playlist",
                  style: TextStyle(fontFamily: 'Koulen'),
                ),
                selectedColor: kColorCyan,
                unselectedColor: kColorWhite),

            //
            SalomonBottomBarItem(
                icon: const Icon(Icons.favorite_outline),
                title: const Text(
                  "Favourites",
                  style: TextStyle(fontFamily: 'Koulen'),
                ),
                selectedColor: kColorOrange,
                unselectedColor: kColorWhite),

            //
            SalomonBottomBarItem(
                icon: const Icon(Icons.settings),
                title: const Text(
                  "Settings",
                  style: TextStyle(fontFamily: 'Koulen'),
                ),
                selectedColor: kColorDeepOrange,
                unselectedColor: kColorWhite),
          ],
        ),
      ),
    );
  }

  Widget _buildPage() {
    switch (_bottomNavIndex) {
      case 0:
        return HomePageScreen(
          filesV: videoFiles,
        );
      case 1:
        return const PlaylistPageScreen();
      case 2:
        return const FavouritesPageScreen();
      case 3:
        return const SettingsPage();
      default:
        return Container();
    }
  }
}
