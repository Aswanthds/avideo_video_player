import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/functions/mostly_played_functions.dart';
import 'package:video_player_app/functions/recently_played_functions.dart';
import 'package:video_player_app/widgets/VideoPlayer/video_player_widget.dart';
import 'package:video_player_app/widgets/search_widget.dart';

class HomeSearchPaage extends StatefulWidget {
  final List<File>? files;
  final TabController? controller;
  final int? tabIndex;

  const HomeSearchPaage({
    Key? key,
    this.files,
    this.controller,
    this.tabIndex,
  }) : super(key: key);

  @override
  State<HomeSearchPaage> createState() => _HomeSearchPaageState();
}

class _HomeSearchPaageState extends State<HomeSearchPaage> {
  final TextEditingController _controller = TextEditingController();
  ValueNotifier<String> textNotifier = ValueNotifier('');
  List<String> filteredFiles = [];

  List<File> cameraFiles = [];
  List<File> whatsappFiles = [];
  List<File> screenshotsFiles = [];
  List<File> downloadFiles = [];
  List<File> dummy = [];
  List<File> othersFiles = [];

  void separatePaths() {
    RegExp cameraPattern = RegExp(r'Camera');
    RegExp whatsappPattern = RegExp(r'WhatsApp');
    RegExp screenPattern = RegExp(r'Screenre');
    RegExp downloadsPattern = RegExp(r'Download');

    for (File path in widget.files!) {
      if (cameraPattern.hasMatch(path.path)) {
        cameraFiles.add(path);
      } else if (whatsappPattern.hasMatch(path.path)) {
        whatsappFiles.add(path);
      } else if (screenPattern.hasMatch(path.path)) {
        screenshotsFiles.add(path);
      } else if (downloadsPattern.hasMatch(path.path)) {
        downloadFiles.add(path);
      } else {
        othersFiles.add(path);
      }
    }

    debugPrint('Camera Files: ${cameraFiles.length}');
    debugPrint('WhatsApp Files: ${whatsappFiles.length}');
  }

  List<File> _getCurrentTabFiles(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return widget.files ?? [];
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

  Widget _buildResults(BuildContext context) {
    return filteredFiles.isEmpty
        ? const SizedBox()
        : ListView.builder(
            itemCount: filteredFiles.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.video_library),
                title: Text(
                  basename(filteredFiles[index]),
                  style: const TextStyle(color: kcolorblack),
                ),
                onTap: () {
                  _onVideoTap(filteredFiles[index], context);
                },
              );
            },
          );
  }

  void _onVideoTap(String videoPath,BuildContext context) {
    MostlyPlayedFunctions.addVideoPlayData(videoPath);
    RecentlyPlayed.onVideoClicked(videoPath: videoPath);
    RecentlyPlayed.checkHiveData();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VideoPlayerScreen(filesV: videoPath),
      ),
    );
  }

  void _updateFilteredFiles() {
    final List<String> inputWords = textNotifier.value.toLowerCase().split(' ');

    final List<File> currentTabFiles =
        _getCurrentTabFiles(widget.controller!.index);

    filteredFiles = currentTabFiles
        .where((file) {
          final fileName = basename(file.path).toLowerCase();
          return inputWords.every((word) => fileName.contains(word));
        })
        .map((file) => file.path)
        .toList();

    textNotifier.value = textNotifier.value;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    separatePaths();
    _getCurrentTabFiles(widget.controller!.index);
    _controller.addListener(() {
      textNotifier.value = _controller.text;
      _updateFilteredFiles();
    });
    _updateFilteredFiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: _buildResults(context),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leadingWidth: 30,
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back),
      ),
      centerTitle: false,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          top: 10,
        ),
        child: SearchWidget(
          controller: _controller,
          hint: 'Search videos',
        ),
      ),
    );
  }
}
