import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:video_player_app/Screens/splash_screen.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox<List<String>>('videos');
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
              titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
              actionsIconTheme: IconThemeData(color: Colors.white)),
          useMaterial3: true,
        ),
        home: SplashScreenPage());
  }
}
