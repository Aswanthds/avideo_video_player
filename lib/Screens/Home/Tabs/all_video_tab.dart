import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:video_player_app/constants.dart';
import 'dart:io';
import 'package:video_player_app/screens/home/Tabs/widgets/video_tile_widget.dart';

class AllVideoTab extends StatefulWidget {
  final List<File> video;
  const AllVideoTab({Key? key, required this.video}) : super(key: key);

  @override
  State<AllVideoTab> createState() => _AllVideoTabState();
}

enum SortingOption { nameAs, nameDe }

class _AllVideoTabState extends State<AllVideoTab> {
  @override
  void didUpdateWidget(covariant AllVideoTab oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

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
    return Stack(
      children: [
        Positioned(
          top: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: DropdownButton<SortingOption>(
              value: selectedOption,

              underline: SizedBox(), //empty line

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
        (widget.video.isEmpty)
            ? const Center(
                child: Text('No video available'),
              )
            : Padding(
                padding: const EdgeInsets.only(top: 40),
                child: GridView.builder(
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
