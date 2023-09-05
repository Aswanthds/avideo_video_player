import 'dart:io';
import 'dart:typed_data';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:video_player_app/Screens/mainpage.dart';
import 'package:video_player_app/functions/db_functions.dart';
import 'package:page_transition/page_transition.dart';


class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  List<File> videoFiles = [];
  List<dynamic> videoData = [];
  List<Uint8List> thumbnails = [];
  File? file;

  @override
  void initState() {
    super.initState();
    fetchAndShowVideos();
   
  }

  void fetchAndShowVideos() async {
    final fetchedVideos = await getPath();

    setState(() {
      videoData = List<String>.from(fetchedVideos);
      videoFiles = fetchedVideos.map((path) => File(path)).toList();
    });

    print('All Video Data:');
    for (String data in videoData) {
      print(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedSplashScreen(
            splashIconSize: 100,
            pageTransitionType: PageTransitionType.fade,
            duration: 3000,
            splash: const Image(image: AssetImage('images/logo_full.png')),
            nextScreen: MainPageScreen(filesV: videoFiles),
            splashTransition: SplashTransition.scaleTransition,
            backgroundColor: Colors.white),
        const Positioned(
          bottom: 30,
          left: 150,
          child: Text(
            'Version 1.0.0',
            style: TextStyle(
              color: Colors.black,
              decoration: TextDecoration.none,
              fontSize: 12,
            ),
          ),
        )
      ],
    );
  }
}
