import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path/path.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/database/most_played_data.dart';
import 'package:video_player_app/functions/mostly_played_functions.dart';
import 'package:video_player_app/functions/recently_played_functions.dart';
import 'package:video_player_app/widgets/VideoPlayer/video_player_widget.dart';

class MostlyPlayedListScreen extends StatelessWidget {
  const MostlyPlayedListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<MostlyPlayedData>>(
        future: MostlyPlayedFunctions.getSortedVideoPlayData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No data available.'),
            );
          } else {
            // Data is available, display it using ListView.builder
            List<MostlyPlayedData> data = snapshot.data!;

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];

                return ListTile(
                  leading: Icon(Icons.video_library),
                  title: Text(
                    basename(item.videoPath!),
                    style: TextStyle(color: kcolorblack),
                  ),
                  subtitle: Text('Play Count: ${item.playCount}'),
                  onTap: () {
                    MostlyPlayedFunctions.addVideoPlayData(item.videoPath!);
                    RecentlyPlayed.onVideoClicked(item.videoPath!);
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
