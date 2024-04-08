import 'dart:io';

import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:video_player_app/Screens/settings/settings_page.dart';
import 'package:video_player_app/Screens/favorites/favourites_page_scren.dart';
import 'package:video_player_app/Screens/Home/home_page_screen.dart';
import 'package:video_player_app/Screens/playlist/playlist_page_screen.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/functions/path_functions.dart';

class MainPageScreen extends StatefulWidget {
  const MainPageScreen({Key? key}) : super(key: key);

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
    try {
      final fetchedVideos = await PathFunctions.getVideoPathsAsync();

      setState(() {
        videoData = List<String>.from(fetchedVideos);
        videoFiles = fetchedVideos.map((path) => File(path)).toList();
      });

      debugPrint('All Video Data fetched sucesss');
    } catch (e) {
      debugPrint('Not fetched error $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPage(),
      bottomNavigationBar: ClipRRect(
        child: SalomonBottomBar(
          backgroundColor: kcolorMintGreen,
          currentIndex: _bottomNavIndex,
          onTap: (i) => setState(() => _bottomNavIndex = i),
          items: [
            /// Home
            SalomonBottomBarItem(
                icon: const Icon(Icons.home),
                title: const Text("Home", style: bottomNav),
                selectedColor: kcolorblack,
                unselectedColor: kColorWhite),

            /// Likes
            SalomonBottomBarItem(
                icon: const Icon(Icons.playlist_play),
                title: const Text(
                  "Playlist",
                  style: bottomNav,
                ),
                selectedColor: kcolorblack,
                unselectedColor: kColorWhite),

            /// Search
            SalomonBottomBarItem(
                icon: const Icon(Icons.favorite_outline),
                title: const Text("Favourites", style: bottomNav),
                selectedColor: kcolorblack,
                unselectedColor: kColorWhite),

            /// Profile
            SalomonBottomBarItem(
                icon: const Icon(Icons.settings),
                title: const Text(
                  "Settings",
                  style: bottomNav,
                ),
                selectedColor: kcolorblack,
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
