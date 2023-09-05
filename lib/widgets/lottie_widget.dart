import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player_app/Screens/mainpage.dart';
import 'package:video_player_app/functions/db_functions.dart';

class LottiePage extends StatefulWidget {
  const LottiePage({super.key});

  @override
  State<LottiePage>  createState() => _LottiePageState();
}

class _LottiePageState extends State<LottiePage> {
  List<File> videoFiles = [];
  List<dynamic> videoData = [];
  List<Uint8List> thumbnails = [];
  File? file;

  @override
  void initState() {
    super.initState();
    checkPermissionsAndNavigate();
    fetchAndShowVideos();
  }

  void fetchAndShowVideos() async {
    final fetchedVideos = await VideoFunctions.getPath();

    setState(() {
      videoData = List<String>.from(fetchedVideos);
      videoFiles = fetchedVideos.map((path) => File(path)).toList();
    });

    debugPrint('All Video Data:');
    for (String data in videoData) {
      debugPrint(data);
    }
  }

  Future<void> checkPermissionsAndNavigate() async {
    final status = await Permission.storage.status;

    if (status.isGranted) {
      navigateToMainScreen();
    } else {
      final result = await Permission.storage.request();

      if (result.isGranted) {
        navigateToMainScreen();
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Permission Denied'),
              content: const Text('Camera permission is required to use this app.'),
              actions: [
                TextButton(
                  onPressed: () => exit(0),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void navigateToMainScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => MainPageScreen(videoFiles: videoFiles,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Lottie.asset(
            'assets/lottie/loading.json',
            repeat: true,
            reverse: true,
            animate: true,
          ),
        ),
      ),
    );
  }
}
