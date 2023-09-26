import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/screens/home/Tabs/widgets/video_tile_widget.dart';

class CameraTab extends StatefulWidget {
  final List<File> filesV;
  // final VideoGriedview videoGridView; // Add reference to the VideoGriedview

  const CameraTab({
    Key? key,
    required this.filesV,
  }) : super(key: key);

  @override
  State<CameraTab> createState() => _CameraTabState();
}

enum SortingOption { nameAs, nameDe }

class _CameraTabState extends State<CameraTab> {
  SortingOption selectedOption = SortingOption.nameAs; // Default sorting option

  void sortByNameAs() {
    setState(() {
      widget.filesV.sort((a, b) => (a.path).compareTo((b.path)));
    });
    // widget.videoGridView.sortAndRefreshThumbnails(); // Call the function here
  }

  void sortByNameDe() {
    setState(() {
      widget.filesV.sort((a, b) => (b.path).compareTo((a.path)));
    });
    // widget.videoGridView.sortAndRefreshThumbnails(); // Call the function here
  }

  List<File> getcameraonlyPath() {
    List<File> camera = [];
    for (File path in widget.filesV) {
      if (path.path.contains('Camera')) {
        camera.add(path);
      }
    }
    return camera;
  }

  @override
  Widget build(BuildContext context) {
    final cameraPath = getcameraonlyPath();
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
          child: (cameraPath.isEmpty)
              ? const Center(
                  child: Text('No video available'),
                )
              : GridView.builder(
                  shrinkWrap: true,
                  itemCount: cameraPath.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    final videoPath = cameraPath[index];

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
