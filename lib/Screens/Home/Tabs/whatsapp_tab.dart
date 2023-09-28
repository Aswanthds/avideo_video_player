import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/screens/home/Tabs/widgets/video_tile_widget.dart';

class WhatsappTab extends StatefulWidget {
  final List<File> filesV;
  const WhatsappTab({super.key, required this.filesV});

  @override
  State<WhatsappTab> createState() => _WhatsappTabState();
}

enum SortingOption { nameAs, nameDe }

class _WhatsappTabState extends State<WhatsappTab> {
  List<File> displayedFiles = []; //

  @override
  void initState() {
    super.initState();
    sortByNameAs(); //
  }

  SortingOption selectedOption = SortingOption.nameAs; //

  void sortByNameAs() {
    setState(() {
      widget.filesV.sort((a, b) => (a.path).compareTo((b.path)));
    });
  }

  void sortByNameDe() {
    setState(() {
      widget.filesV.sort((a, b) => (b.path).compareTo((a.path)));
    });
  }

  List<File> separatePaths() {
    for (final path in widget.filesV) {
      if (path.path.contains('WhatsApp')) {
        displayedFiles.add(path);
      }
    }
    return displayedFiles;
  }

  @override
  Widget build(BuildContext context) {
    final paths = separatePaths();
    return Stack(
      children: [
        Positioned(
          top: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: DropdownButton<SortingOption>(
              value: selectedOption,
              underline: const SizedBox(), //
              dropdownColor: kColorWhite,
              iconEnabledColor: kcolorDarkblue,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: kcolorblack),
              borderRadius: BorderRadius.circular(10),
              onChanged: (SortingOption? newValue) {
                setState(() {
                  //
                  if (newValue == SortingOption.nameAs) {
                    sortByNameAs();
                  } else if (newValue == SortingOption.nameDe) {
                    sortByNameDe();
                  }
                });
              },
              items: const [
                DropdownMenuItem(
                  value: SortingOption.nameAs,
                  child: Text(
                    ' (A ➔ Z)',
                  ),
                ),
                DropdownMenuItem(
                  value: SortingOption.nameDe,
                  child: Text('(Z ➔ A)'),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: paths.length,
            itemBuilder: (context, index) {
              final videoPath = paths[index];

              return Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                ),
                child: VideoTileWidget(
                  videoFile: videoPath,
                  index: index,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
