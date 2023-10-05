import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/functions/mostly_played_functions.dart';
import 'package:video_player_app/functions/recently_played_functions.dart';
import 'package:video_player_app/widgets/VideoPlayer/video_player_widget.dart';
import 'package:video_player_app/widgets/search_widget.dart';

class PlayListSearch extends StatefulWidget {
  final List<File>? files;


  const PlayListSearch({
    Key? key,
    this.files,
  }) : super(key: key);

  @override
  State<PlayListSearch> createState() => _PlayListSearchState();
}

class _PlayListSearchState extends State<PlayListSearch> {
  final TextEditingController _controller = TextEditingController();
  ValueNotifier<String> textNotifier = ValueNotifier('');
  List<String> filteredFiles = [];

  Widget _buildResults(BuildContext context) {
    return filteredFiles.isEmpty
        ? const Center(child: nodata)
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

  void _onVideoTap(String videoPath, BuildContext context) {
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

    filteredFiles = widget.files!
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
