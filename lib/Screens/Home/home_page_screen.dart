import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player_app/Screens/Home/Tabs/camera_tab.dart';
import 'package:video_player_app/Screens/Home/Tabs/download_tab.dart';
import 'package:video_player_app/Screens/Home/Tabs/others_tab.dart';
import 'package:video_player_app/Screens/Home/Tabs/screenshots_tab.dart';
import 'package:video_player_app/Screens/Home/Tabs/whatsapp_tab.dart';

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
      length: 5,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(24),
            ),
            child: AppBar(
              backgroundColor: const Color(0xF1003554),
              title: const Text(
                'AVideo Video Player',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.search))
              ],
              bottom: const TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                isScrollable: true,
                labelStyle: TextStyle(color: Colors.white),
                indicatorColor: Colors.lightBlue,
                tabs:
                    // _folderinString.map((folder) => Tab(text: folder)).toList(),
                    [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.camera_alt),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Camera'),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.download),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Download'),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.radio_button_checked_rounded),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Screenrecords'),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.wechat_sharp),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Whatsapp'),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.video_label),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Others'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
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
