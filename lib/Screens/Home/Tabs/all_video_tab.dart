import 'package:flutter/material.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/screens/home/Tabs/widgets/sorting_widget.dart';
import 'dart:io';

class AllVideoTab extends StatefulWidget {
  final List<File> video;
  //
  const AllVideoTab({
    Key? key,
    required this.video,
  }) : super(key: key);

  @override
  State<AllVideoTab> createState() => _AllVideoTabState();
}

enum SortingOption { nameAs, nameDe }

class _AllVideoTabState extends State<AllVideoTab> {
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
    for (File path in widget.video) {
      if (path.path.contains('WhatsApp')) {
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
    //final paths = separatePaths();
    return Stack(
      children: [
        sortingWidget(),
        sortedFiles.isEmpty
            ? const Center(child: nodata)
            : GridviewWidget(sortedFiles: sortedFiles),
      ],
    );
  }

  Positioned sortingWidget() {
    return Positioned(
      top: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: DropdownButton<SortingOption>(
          value: selectedOption,
          underline: const SizedBox(), //
          dropdownColor: kColorWhite,
          iconEnabledColor: kcolorMintGreen,
          style: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.bold, color: kcolorblack),
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
    );
  }
}


