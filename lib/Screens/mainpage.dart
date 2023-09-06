import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:video_player_app/Screens/Settings/settings_page.dart';
import 'package:video_player_app/Screens/Favorites/favourites_page_scren.dart';
import 'package:video_player_app/Screens/Home/home_page_screen.dart';
import 'package:video_player_app/Screens/PlayList/playlist_page_screen.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/functions/db_functions.dart';

class MainPageScreen extends StatefulWidget {
  final List<Uint8List>? thumbnail;
  const MainPageScreen({Key? key, this.thumbnail}) : super(key: key);

  @override
  State<MainPageScreen> createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<MainPageScreen>
    with SingleTickerProviderStateMixin {
  int _bottomNavIndex = 0;
  List<File> videoFiles = [];
  List<dynamic> videoData = [];
  @override
  void initState() {
    super.initState();
    fetchAndShowVideos();
  }

  void fetchAndShowVideos() async {
    final fetchedVideos = await VideoFunctions.getPath();

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
          backgroundColor: const Color(0xF1003554),
          currentIndex: _bottomNavIndex,
          onTap: (i) => setState(() => _bottomNavIndex = i),
          items: [
            /// Home
            SalomonBottomBarItem(
                icon: const Icon(Icons.home),
                title: const Text("Home"),
                selectedColor: kColorAmber,
                unselectedColor: Colors.white),

            /// Likes
            SalomonBottomBarItem(
                icon: const Icon(Icons.playlist_play),
                title: const Text("Playlist"),
                selectedColor: kColorCyan,
                unselectedColor: Colors.white),

            /// Search
            SalomonBottomBarItem(
                icon: const Icon(Icons.favorite_outline),
                title: const Text("Favourites"),
                selectedColor: kColorOrange,
                unselectedColor: Colors.white),

            /// Profile
            SalomonBottomBarItem(
                icon: const Icon(Icons.settings),
                title: const Text("Settings"),
                selectedColor: kColorDeepOrange,
                unselectedColor: Colors.white),
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
