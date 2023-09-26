import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player_app/Screens/Home/Tabs/all_video_tab.dart';
import 'package:video_player_app/Screens/Home/Tabs/camera_tab.dart';
import 'package:video_player_app/Screens/Home/Tabs/download_tab.dart';
import 'package:video_player_app/Screens/Home/Tabs/others_tab.dart';
import 'package:video_player_app/Screens/Home/Tabs/screenshots_tab.dart';
import 'package:video_player_app/Screens/Home/Tabs/whatsapp_tab.dart';
import 'package:video_player_app/Screens/Home/widgets/home_search_page.dart';
import 'package:video_player_app/functions/path_functions.dart';
import 'package:video_player_app/widgets/appbar_common.dart';

class HomePageScreen extends StatefulWidget {
  final List<File> filesV;
  const HomePageScreen({super.key, required this.filesV});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  List<String> paths = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: AppbarCommon(
            title: 'Avideo Video Player',
            isHome: true,
            navigation:
                HomeSearchPaage(files: widget.filesV, text: 'Search videos'),
          ),
        ),
        body: TabBarView(
          children: [
            AllVideoTab(
              video: widget.filesV,
            ),
            CameraTab(filesV: widget.filesV),
            DownloadTab(filesV: widget.filesV),
            ScreenRecordsTab(filesV: widget.filesV),
            WhatsappTab(filesV: widget.filesV),
            OthersTab(filesV: widget.filesV)
          ],
        ),
      ),
    );
  }
}
