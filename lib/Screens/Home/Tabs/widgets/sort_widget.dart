import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:video_player_app/constants.dart';

class SortWidget extends StatefulWidget {
  final List<File> video;
  const SortWidget({
    super.key,
    required this.video,
  });

  @override
  State<SortWidget> createState() => _SortWidgetState();
}

enum SortingOption { nameAs, nameDe, duration }

class _SortWidgetState extends State<SortWidget> {
  SortingOption selectedOption = SortingOption.nameAs; // Default sorting option

  void sortByNameAs() {
    setState(() {
      widget.video.sort((a, b) => basename(a.path).compareTo(basename(b.path)));
    });
  }

  void sortByNameDe() {
    setState(() {
      widget.video.sort((a, b) => basename(b.path).compareTo(basename(a.path)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: DropdownButton<SortingOption>(
          value: selectedOption,

          underline: Container(), //empty line

          dropdownColor: kColorWhite,
          iconEnabledColor: kcolorDarkblue,
          style: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.bold, color: kcolorblack),
          borderRadius: BorderRadius.circular(10),
          onChanged: (SortingOption? newValue) {
            setState(() {
              selectedOption = newValue!;
              // Sort your video list here based on newValue
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
    );
  }
}
