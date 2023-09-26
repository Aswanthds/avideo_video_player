import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/screens/home/Tabs/widgets/video_tile_widget.dart';

class OthersTab extends StatefulWidget {
  final List<File> filesV;
  const OthersTab({super.key, required this.filesV});

  @override
  State<OthersTab> createState() => _OthersTabState();
}

enum SortingOption { nameAs, nameDe }

class _OthersTabState extends State<OthersTab> {
  List<File> others = [];
  List<File> displayedFiles = []; //

  @override
  void initState() {
    super.initState();
    displayedFiles = getdownloadsonlyPath();
  }

  List<File> getdownloadsonlyPath() {
    final List<File> result = [];
    for (File path in widget.filesV) {
      if (path.path.contains('Download') ||
          path.path.contains('WhatsApp') ||
          path.path.contains('Screenshots') ||
          path.path.contains('Camera')) {
        //
      } else {
        result.add(path);
      }
    }
    return result;
  }

  SortingOption selectedOption = SortingOption.nameAs; //

  void sortByNameAs() {
    setState(() {
      displayedFiles.sort((a, b) => (a.path).compareTo(b.path));
    });
  }

  void sortByNameDe() {
    setState(() {
      displayedFiles
          .sort((a, b) => basename(b.path).compareTo(basename(a.path)));
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  selectedOption = newValue!;
                  //
                  if (selectedOption == SortingOption.nameAs) {
                    sortByNameAs();
                  } else if (selectedOption == SortingOption.nameDe) {
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
          child: (displayedFiles.isEmpty)
              ? const Center(
                  child: Text('No video available'),
                )
              : GridView.builder(
                  shrinkWrap: true,
                  itemCount: displayedFiles.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    final videoPath = displayedFiles[index];

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
