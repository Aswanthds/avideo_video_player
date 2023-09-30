import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player_app/Screens/Home/Tabs/all_video_tab.dart';
import 'package:video_player_app/Screens/Home/Tabs/camera_tab.dart';
import 'package:video_player_app/Screens/Home/Tabs/download_tab.dart';
import 'package:video_player_app/Screens/Home/Tabs/others_tab.dart';
import 'package:video_player_app/Screens/Home/Tabs/screenshots_tab.dart';
import 'package:video_player_app/Screens/Home/Tabs/whatsapp_tab.dart';
import 'package:video_player_app/Screens/Home/widgets/home_search_page.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/widgets/home_tabbar.dart';

class HomePageScreen extends StatefulWidget {
  final List<File> filesV;

  const HomePageScreen({
    super.key,
    required this.filesV,
  });

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

List<File>? searchfiles;

class _HomePageScreenState extends State<HomePageScreen>
    with TickerProviderStateMixin {
  TabController? _controller;

  List<File> cameraFiles = [];
  List<File> whatsappFiles = [];
  List<File> screenshotsFiles = [];
  List<File> downloadFiles = [];
  List<File> othersFiles = [];
  @override
  void initState() {
    super.initState();
    separatePaths();
    _controller = TabController(length: 6, vsync: this);
    _getCurrentTabFiles(_controller!.index);
  }

  void separatePaths() {
    RegExp cameraPattern = RegExp('Camera');
    RegExp whatsappPattern = RegExp('WhatsApp');
    RegExp screenPattern = RegExp('Screenre');
    RegExp downloadsPattern = RegExp('Download');
    RegExp othersPattern = RegExp('Camera');

    for (final path in widget.filesV) {
      if (cameraPattern.hasMatch(path.path)) {
        cameraFiles.add(path);
      } else if (whatsappPattern.hasMatch(path.path)) {
        whatsappFiles.add(path);
      } else if (screenPattern.hasMatch(path.path)) {
        screenshotsFiles.add(path);
      } else if (downloadsPattern.hasMatch(path.path)) {
        downloadFiles.add(path);
      } else if (othersPattern.hasMatch(path.path)) {
        othersFiles.add(path);
      }
    }

    debugPrint('Camera Files: ${cameraFiles.length}');
    debugPrint('WhatsApp Files: ${whatsappFiles.length}');
  }

  List<File> _getCurrentTabFiles(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return widget.filesV;
      case 1:
        return cameraFiles;
      case 2:
        return downloadFiles;
      case 3:
        return screenshotsFiles;
      case 4:
        return whatsappFiles;
      case 5:
        return othersFiles;
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: AppBar(
            iconTheme: const IconThemeData(color: kColorWhite),
            backgroundColor: kcolorDarkblue,
            // ignore: prefer_const_constructors
            title: Text(
              'Avideo Video Player',
              style: const TextStyle(
                fontFamily: 'Cookie',
                fontSize: 35,
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HomeSearchPaage(
                            files: _getCurrentTabFiles(_controller!.index),
                          ),
                        ),
                      ),
                  icon: const Icon(Icons.search))
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: HomeTabBar(
                controller: _controller!,
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: _controller,
          physics: const NeverScrollableScrollPhysics(),
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
        ));
  }
}
