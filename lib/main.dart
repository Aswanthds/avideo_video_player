import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/database/create_playlist_data.dart';
import 'package:video_player_app/database/favourite_data.dart';
import 'package:video_player_app/database/most_played_data.dart';
import 'package:video_player_app/database/recently_video_data.dart';
import 'package:video_player_app/database/video_duration_adapter.dart';
import 'package:video_player_app/widgets/splash_screen.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();

  Hive.init(appDocumentDir.path);

  registerAdapters();
  await callDatabseFunctions();

  runApp(const MyApp());
}

Future<void> callDatabseFunctions() async {
  await Hive.openBox<List<String>>('videos');
  await Hive.openBox<FavoriteData>('favorite_videos');
  await Hive.openBox<MostlyPlayedData>('mostly_played_data');
  await Hive.openBox<RecentlyPlayedData>('recently_played');
  await Hive.openBox<VideoPlaylist>('playlists_data');
}

void registerAdapters() {
  Hive.registerAdapter(MostlyPlayedDataAdapter());
  Hive.registerAdapter(RecentlyPlayedDataAdapter());
  Hive.registerAdapter(FavoriteDataAdapter());
  Hive.registerAdapter<VideoPlaylist>(VideoPlaylistAdapter());
  Hive.registerAdapter(DurationAdapter());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.light,
          appBarTheme: const AppBarTheme(
            titleTextStyle: appbar,
            actionsIconTheme: IconThemeData(color: kColorWhite),
          ),
          useMaterial3: true,
        ),
        home: const SplashScreenPage());
  }
}
