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
  final String text;
  const HomeSearchPaage({Key? key, this.files, required this.text})
      : super(key: key);

  @override
  State<HomeSearchPaage> createState() => _HomeSearchPaageState();
}

class _HomeSearchPaageState extends State<HomeSearchPaage> {
  final TextEditingController _controller = TextEditingController();
  ValueNotifier<String> textNotifier = ValueNotifier('');
  List<String> filteredFiles = [];

  Widget _buildResults() {
    return ListView.builder(
      itemCount: filteredFiles.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.video_library),
          title: Text(
            basename(filteredFiles[index]),
            style: const TextStyle(color: kcolorblack),
          ),
          onTap: () {
            MostlyPlayedFunctions.addVideoPlayData(filteredFiles[index]);
            RecentlyPlayed.onVideoClicked(
              videoPath: filteredFiles[index],
            );
            RecentlyPlayed.checkHiveData();
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  VideoPlayerScreen(filesV: filteredFiles[index]),
            ));
          },
        );
      },
    );
  }

  void _updateFilteredFiles() {
    final List<String> inputWords = textNotifier.value.toLowerCase().split(' ');

    filteredFiles = widget.files
            ?.where((file) {
              final fileName = basename(file.path).toLowerCase();
              return inputWords.every((word) => fileName.contains(word));
            })
            .map((file) => file.path)
            .toList() ??
        [];

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back)),
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            top: 10,
          ),
          child: SearchWidget(
            controller: _controller,
            hint: widget.text,
          ),
        ),
      ),
      body: SafeArea(
        child: _buildResults(),
      ),
    );
  }
}
