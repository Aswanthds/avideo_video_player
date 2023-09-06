import 'package:flutter/material.dart';
import 'package:video_player_app/Screens/Home/widgets/folder_tab.dart';
import 'package:video_player_app/constants.dart';

class AppbarCommon extends StatefulWidget {
  final String title;
  final bool isHome;

  const AppbarCommon({
    super.key,
    required this.title,
    required this.isHome,
  });

  @override
  State<AppbarCommon> createState() => _AppbarCommonState();
}

class _AppbarCommonState extends State<AppbarCommon> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(24),
      ),
      child: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: kcolorblue,
          title: Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          ],
          bottom: widget.isHome
              ? const PreferredSize(
                  preferredSize: Size.fromHeight(50), child: HomeTabBar())
              : null),
    );
  }
}

class HomeTabBar extends StatelessWidget {
  const HomeTabBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.grey,
      isScrollable: true,
      labelStyle: TextStyle(color: Colors.white),
      indicatorColor: Colors.lightBlue,
      tabs: [
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
