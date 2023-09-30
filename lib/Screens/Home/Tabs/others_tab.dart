import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/screens/home/Tabs/widgets/sorting_widget.dart';

class OthersTab extends StatefulWidget {
  final List<File> filesV;
  const OthersTab({super.key, required this.filesV});

  @override
  State<OthersTab> createState() => _OthersTabState();
}

enum SortingOption { nameAs, nameDe }

class _OthersTabState extends State<OthersTab> {
  SortingOption selectedOption = SortingOption.nameAs; //

  List<File> sortedFiles = []; // Maintain a separate sorted list
  @override
  void initState() {
    super.initState();
    sortedFiles = getdownloadsonlyPath();
    sortByNameAs(); // Initialize with the default sorting
  }

  List<File> getdownloadsonlyPath() {
    List<File> downloads = [];
    List<File> dummy = [];
    RegExp pattern = RegExp(r'Download|Camera|Screenrecording|WhatsApp');
    for (File path in widget.filesV) {
      if (pattern.hasMatch(path.path)) {
        dummy.add(path);
      } else {
        downloads.add(path);
      }
    }

    return downloads;
  }

   void sortByNameAs() {
    setState(() {
      sortedFiles = List<File>.from(getdownloadsonlyPath())
        ..sort((a, b) {
          final filenameA = a.path.split(Platform.pathSeparator).last;
          final filenameB = b.path.split(Platform.pathSeparator).last;
          return filenameA.compareTo(filenameB);
        });
      selectedOption = SortingOption.nameAs; // Update the selected option
    });
  }

  void sortByNameDe() {
    setState(() {
      sortedFiles = List<File>.from(getdownloadsonlyPath())
        ..sort((a, b) {
          final filenameA = a.path.split(Platform.pathSeparator).last;
          final filenameB = b.path.split(Platform.pathSeparator).last;
          return filenameB.compareTo(filenameA);
        });
      selectedOption = SortingOption.nameDe; // Update the selected option
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
       (sortedFiles.isEmpty)
            ? const Center(
                child: Text('No videos found'),
              )
            : GridviewWidget(sortedFiles: sortedFiles),
      ],
    );
  }
}
