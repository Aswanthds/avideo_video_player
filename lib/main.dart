import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/database/favourite_data.dart';
import 'package:video_player_app/database/most_played_data.dart';
import 'package:video_player_app/functions/recently_played_functions.dart';
import 'package:video_player_app/database/video_data.dart';
import 'package:video_player_app/widgets/splash_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MostlyPlayedDataAdapter());
  Hive.registerAdapter(RecentlyPlayedDataAdapter());
  Hive.registerAdapter(FavoriteDataAdapter());
  await callDatabseFunctions();
  RecentlyPlayed.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

Future<void> callDatabseFunctions() async {
  await Hive.openBox<List<String>>('videos');
  await Hive.openBox<FavoriteData>('favorite_videos');
  await Hive.openBox<MostlyPlayedData>('mostly_played_data');
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
              titleTextStyle: TextStyle(color: kColorWhite, fontSize: 18),
              actionsIconTheme: IconThemeData(color: kColorWhite)),
          useMaterial3: true,
        ),
        home: const SplashScreenPage());
  }
}
