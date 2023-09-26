import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/screens/home/Tabs/widgets/video_tile_widget.dart';

class DownloadTab extends StatefulWidget {
  final List<File> filesV;
  const DownloadTab({super.key, required this.filesV});

  @override
  State<DownloadTab> createState() => _DownloadTabState();
}

enum SortingOption { nameAs, nameDe }

class _DownloadTabState extends State<DownloadTab> {
  List<File> downloads = [];
  @override
  void initState() {
    super.initState();
  }

  final ValueNotifier<File> thumbnailNotifier = ValueNotifier<File>(File(''));
  Future<void> updateThumbnails() async {
    for (final videoFile in downloads) {
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
      downloads.sort((a, b) => (a.path).compareTo((b.path)));
    });
  }

  void sortByNameDe() {
    setState(() {
      downloads.sort((a, b) => (b.path).compareTo((a.path)));
    });
  }

  List<File> getdownloadsonlyPath() {
    List<File> downloads = [];
    for (File path in widget.filesV) {
      if (path.path.contains('Download')) {
        downloads.add(path);
      }
    }
    return downloads;
  }

  @override
  Widget build(BuildContext context) {
    final downloadpath = getdownloadsonlyPath();
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
          child: (downloadpath.isEmpty)
              ? const Center(
                  child: Text('No video available'),
                )
              : GridView.builder(
                  shrinkWrap: true,
                  itemCount: downloadpath.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    final videoPath = downloadpath[index];

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
