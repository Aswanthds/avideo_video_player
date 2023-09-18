import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:video_player_app/Screens/Home/Tabs/widgets/video_tile_widget.dart';

class AllVideoTab extends StatefulWidget {
  final List<File> video;
  const AllVideoTab({Key? key, required this.video}) : super(key: key);

  @override
  State<AllVideoTab> createState() => _AllVideoTabState();
}

enum SortingOption { nameAs, nameDe, duration }

class _AllVideoTabState extends State<AllVideoTab> {
  SortingOption selectedOption = SortingOption.nameAs; // Default sorting option
  void sortByNameAs() async {
    widget.video.sort((a, b) => basename(a.path).compareTo(basename(b.path)));
  }

  void sortByNameDe() async {
    widget.video.sort((a, b) => basename(b.path).compareTo(basename(a.path)));
  }
 
  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: DropdownButton<SortingOption>(
            value: selectedOption,
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
                child: Text('Sort by Name (A ➔ Z)'),
              ),
              DropdownMenuItem(
                value: SortingOption.nameDe,
                child: Text('Sort by Name (Z ➔ A)'),
              ),
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
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
