import 'package:flutter/material.dart';
import 'package:video_player_app/Screens/home/widgets/folder_tab.dart';
import 'package:video_player_app/constants.dart';

class HomeTabBar extends StatelessWidget {
  final TabController controller;
  const HomeTabBar({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      labelColor: kcolorblack,
      unselectedLabelColor: kColorWhite,
      isScrollable: true,
      labelStyle: const TextStyle(color: kColorWhite),
      indicatorColor: Colors.lightBlue,
      tabs: const [
        FolderTab(
          foldername: 'All',
          icon: Icon(Icons.video_collection),
        ),
        FolderTab(
          foldername: 'Camera',
          icon: Icon(Icons.camera_alt),
        ),
        FolderTab(
          foldername: 'Download',
          icon: Icon(Icons.download),
        ),
        FolderTab(
          foldername: 'Screenrecords',
          icon: Icon(Icons.radio_button_checked_rounded),
        ),
        FolderTab(
            foldername: 'Whatsapp',
            icon: Image(
              image: AssetImage('assets/images/bg.png'),
              height: 24,
              color: kColorWhite,
            )),
        FolderTab(
          foldername: 'Others',
          icon: Icon(Icons.video_label),
        ),
      ],
    );
  }
}
