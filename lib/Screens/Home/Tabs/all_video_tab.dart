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
  List<File> sortedFiles = [];
  void sortByNameAs() {
    setState(() {
      sortedFiles = List<File>.from(widget.video)
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
      sortedFiles = List<File>.from(widget.video)
        ..sort((a, b) {
          final filenameA = a.path.split(Platform.pathSeparator).last;
          final filenameB = b.path.split(Platform.pathSeparator).last;
          return filenameB.compareTo(filenameA);
        });
      selectedOption = SortingOption.nameDe; // Update the selected option
    });
  }

  @override
  void initState() {
    sortByNameAs();
    super.initState();
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
        (widget.video.isEmpty )
            ? const Center(child:  dataloading)
            : GridviewWidget(sortedFiles: widget.video)
      ],
    );
  }
}
