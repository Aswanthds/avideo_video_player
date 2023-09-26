import 'package:flutter/material.dart';
import 'package:video_player_app/constants.dart';
import 'dart:io';

import 'package:video_player_app/screens/home/Tabs/widgets/video_tile_widget.dart';


class AllVideoTab extends StatefulWidget {
  final List<File> video;
  //final VideoGriedview videoGridView;
  const AllVideoTab({
    Key? key,
    required this.video,
  }) : super(key: key);

  @override
  State<AllVideoTab> createState() => _AllVideoTabState();
}

enum SortingOption { nameAs, nameDe }

class _AllVideoTabState extends State<AllVideoTab> {
  final ValueNotifier<File> thumbnailNotifier = ValueNotifier<File>(File(''));

  SortingOption selectedOption = SortingOption.nameAs; // Default sorting option

  void sortByNameAs() {
    setState(() {
      widget.video.sort((pat1, pat2) => (pat1.path).compareTo((pat2.path)));
    });
  }

  void sortByNameDe() {
    setState(() {
      widget.video.sort((a, b) => (b.path).compareTo((a.path)));
    });
  }

  @override
  void initState() {
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

              underline: const SizedBox(), //empty line

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
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: (widget.video.isEmpty)
              ? const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                  ),
                )
              : GridView.builder(
                  shrinkWrap: true,
                  itemCount: widget.video.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    final videoPath = widget.video[index];

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
