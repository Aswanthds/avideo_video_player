import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:video_player_app/Screens/Settings/settings_page.dart';
import 'package:video_player_app/Screens/Favorites/favourites_page_scren.dart';
import 'package:video_player_app/Screens/Home/home_page_screen.dart';
import 'package:video_player_app/Screens/PlayList/playlist_page_screen.dart';

class MainPageScreen extends StatefulWidget {
  final List<File> videoFiles;
  final List<Uint8List>? thumbnail;
  const MainPageScreen({Key? key, this.thumbnail, required this.videoFiles}) : super(key: key);

  @override
  State<MainPageScreen> createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<MainPageScreen>
    with SingleTickerProviderStateMixin {
  int _bottomNavIndex = 0;

  @override
  void initState() {
    super.initState();
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
                selectedColor: Colors.amberAccent,
                unselectedColor: Colors.white),

            /// Likes
            SalomonBottomBarItem(
                icon: const Icon(Icons.playlist_play),
                title: const Text("Playlist"),
                selectedColor: Colors.green,
                unselectedColor: Colors.white),

            /// Search
            SalomonBottomBarItem(
                icon: const Icon(Icons.favorite_outline),
                title: const Text("Favourites"),
                selectedColor: Colors.orange,
                unselectedColor: Colors.white),

            /// Profile
            SalomonBottomBarItem(
                icon: const Icon(Icons.settings),
                title: const Text("Settings"),
                selectedColor: Colors.red,
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
          filesV: widget.videoFiles,
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
