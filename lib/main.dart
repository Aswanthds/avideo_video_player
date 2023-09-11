import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/database/recently_played.dart';
import 'package:video_player_app/database/video_data.dart';
import 'package:video_player_app/widgets/splash_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(VideoDataAdapter()); // Make sure to register the adapter
  await Hive.openBox<List<String>>('videos');
  RecentlyPlayed.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
