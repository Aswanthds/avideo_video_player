import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  final ValueNotifier<List<MostlyPlayedData>> _dataNotifier =
      ValueNotifier<List<MostlyPlayedData>>([]);

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final data = await MostlyPlayedFunctions.getSortedVideoPlayData();
    _dataNotifier.value = data;
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
      // Handle the error gracefully, e.g., return a placeholder image
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable:
            Hive.box<MostlyPlayedData>('mostly_played_data').listenable(),
        builder: (context, data, child) {
          if (data.isEmpty) {
            return const Center(
              child: Text('No data available.'),
            );
          } else {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final box = data;
                final dataItem = box.values.toList();
                final item = dataItem[index];
                return ListTile(
                  leading: FutureBuilder<Uint8List?>(
                    future: generateThumbnail(item.videoPath!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return const Icon(Icons.error);
                      } else if (!snapshot.hasData) {
                        return const Icon(Icons.video_label);
                      } else {
                        return Container(
                          width: 80,
                          height: 50,
                          decoration: BoxDecoration(
                              color: kcolorblack54,
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: MemoryImage(snapshot.data!))),
                        );
                      }
                    },
                  ),
                  title: Text(
                    basename(item.videoPath!),
                    maxLines: 1,
                    style: GoogleFonts.nixieOne(
                      color: kcolorblack,
                    ),
                  ),
                  subtitle: Text('Play Count: ${item.playCount}'),
                  onTap: () {
                    MostlyPlayedFunctions.addVideoPlayData(item.videoPath!);
                    RecentlyPlayed.onVideoClicked(
                      videoPath: item.videoPath!,
                    );
                    RecentlyPlayed.checkHiveData();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          VideoPlayerScreen(filesV: item.videoPath!),
                    ));
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
