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

class _HomePageScreenState extends State<HomePageScreen>
    with TickerProviderStateMixin {
  TabController? _controller;


  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 6, vsync: this);
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
                            files: widget.filesV,
                            controller : _controller,
                            tabIndex : _controller!.index,
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
