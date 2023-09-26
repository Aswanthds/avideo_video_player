import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_compress/video_compress.dart';
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

  final ValueNotifier<File> thumbnailNotifier = ValueNotifier<File>(File(''));

  Future<void> updateThumbnails(List<File> files) async {
    for (final videoFile in files) {
      try {
        final thumbnailFile = await VideoCompress.getFileThumbnail(
          videoFile.path,
          quality: 30,
          position: 0,
        );
        setState(() {
          thumbnailNotifier.value = thumbnailFile;
        });
      } catch (e) {
        debugPrint('Error generating thumbnail: $e');
      }
    }
  }

  SortingOption selectedOption = SortingOption.nameAs; //

  void sortByNameAs() {
    setState(() {
      selectedOption = SortingOption.nameAs;
      displayedFiles = [...widget.filesV];
      displayedFiles.sort((a, b) => (a.path).compareTo((b.path)));
      updateThumbnails(displayedFiles);
    });
  }

  void sortByNameDe() {
    setState(() {
      selectedOption = SortingOption.nameDe;
      displayedFiles = [...widget.filesV];
      displayedFiles.sort((a, b) => (b.path).compareTo((a.path)));
      updateThumbnails(displayedFiles);
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
            itemCount: displayedFiles.length,
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
