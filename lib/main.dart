import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/database/create_playlist_data.dart';
import 'package:video_player_app/database/favourite_data.dart';
import 'package:video_player_app/database/most_played_data.dart';
import 'package:video_player_app/database/video_data.dart';
import 'package:video_player_app/widgets/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  await Hive.initFlutter();
  registerAdapters();
  await callDatabseFunctions();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

Future<void> callDatabseFunctions() async {
  await Hive.openBox<List<String>>('videos');
  await Hive.openBox<FavoriteData>('favorite_videos');
  await Hive.openBox<MostlyPlayedData>('mostly_played_data');
  await Hive.openBox<RecentlyPlayedData>('recently_played');
}

void registerAdapters() {
  Hive.registerAdapter(MostlyPlayedDataAdapter());
  Hive.registerAdapter(RecentlyPlayedDataAdapter());
  Hive.registerAdapter(FavoriteDataAdapter());
  Hive.registerAdapter(CreatePlaylistDataAdapter());
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
          appBarTheme: AppBarTheme(
              titleTextStyle: GoogleFonts.koulen(
                  color: kColorWhite,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
              actionsIconTheme: const IconThemeData(color: kColorWhite)),
          useMaterial3: true,
        ),
        home: const SplashScreenPage());
  }
}
