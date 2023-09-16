import 'package:flutter/material.dart';
import 'package:video_player_app/Screens/home/widgets/folder_tab.dart';
import 'package:video_player_app/constants.dart';

class HomeTabBar extends StatelessWidget {
  const HomeTabBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      labelColor: kColorWhite,
      unselectedLabelColor: Colors.grey,
      isScrollable: true,
      labelStyle: TextStyle(color: kColorWhite),
      indicatorColor: Colors.lightBlue,
      tabs: [
        FolderTab(
          foldername: 'All',
          icon: Icons.video_collection,
        ),
        FolderTab(
          foldername: 'Camera',
          icon: Icons.camera_alt,
        ),
        FolderTab(
          foldername: 'Download',
          icon: Icons.download,
        ),
        FolderTab(
          foldername: 'Screenrecords',
          icon: Icons.radio_button_checked_rounded,
        ),
        FolderTab(
          foldername: 'Whatsapp',
          icon: Icons.wechat_sharp,
        ),
        FolderTab(
          foldername: 'Others',
          icon: Icons.video_label,
        ),
      ],
    );
  }
}
