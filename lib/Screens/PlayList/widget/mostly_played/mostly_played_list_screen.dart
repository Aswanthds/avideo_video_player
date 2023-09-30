import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path/path.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/database/most_played_data.dart';
import 'package:video_player_app/functions/mostly_played_functions.dart';
import 'package:video_player_app/functions/recently_played_functions.dart';
import 'package:video_player_app/widgets/VideoPlayer/video_player_widget.dart';

class MostlyPlayedListScreen extends StatefulWidget {
  const MostlyPlayedListScreen({Key? key}) : super(key: key);

  @override
  State<MostlyPlayedListScreen> createState() => _MostlyPlayedListScreenState();
}

class _MostlyPlayedListScreenState extends State<MostlyPlayedListScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<Uint8List?> generateThumbnail(String path) async {
    try {
      final thumbnailFile = await VideoCompress.getByteThumbnail(
        path,
        quality: 10,
        position: -1,
      );
      return thumbnailFile;
    } catch (e) {
      debugPrint('Error generating thumbnail: $e');
      //
      return null;
    }
  }

  bool isVideoFileExists(String path) {
    final file = File(path);
    return file.existsSync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable:
            Hive.box<MostlyPlayedData>('mostly_played_data').listenable(),
        builder: (context, data, child) {
           if (data.isEmpty) {
            return const Center(child: nodata);
          } else {
            final dataItem = data.values.toList();

            final filteredDataItem = dataItem
                .where((item) =>
                    item.playCount > 2 && isVideoFileExists(item.videoPath!))
                .toList();

            filteredDataItem.sort((a, b) => b.playCount.compareTo(a.playCount));
            return (filteredDataItem.isNotEmpty)
                ? ListView.builder(
                    itemCount: filteredDataItem.length,
                    itemBuilder: (context, index) {
                      final item = filteredDataItem[index];
                      return (item.videoPath!.isNotEmpty)
                          ? ListTile(
                              leading: FutureBuilder<Uint8List?>(
                                future: generateThumbnail(item.videoPath!),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return const Icon(Icons.error);
                                  } else if (!snapshot.hasData) {
                                    return const SizedBox();
                                  } else {
                                    return Container(
                                      width: 80,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: kcolorblack54,
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: MemoryImage(snapshot.data!),
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                              title: Text(
                                basename(item.videoPath!),
                                maxLines: 1,
                                style: const TextStyle(
                                  color: kcolorblack,
                                ),
                              ),
                              subtitle: Text('Play Count: ${item.playCount}'),
                              onTap: () {
                                MostlyPlayedFunctions.addVideoPlayData(
                                    item.videoPath!);
                                RecentlyPlayed.onVideoClicked(
                                  videoPath: item.videoPath!,
                                );
                                RecentlyPlayed.checkHiveData();
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => VideoPlayerScreen(
                                    filesV: item.videoPath!,
                                  ),
                                ));
                              },
                            )
                          : const SizedBox();
                    },
                  )
                : const Center(child: nodata);
          }
        },
      ),
    );
  }
}
