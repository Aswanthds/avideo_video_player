// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player_app/Screens/mainpage.dart';
import 'package:video_player_app/constants.dart';

import 'package:video_player_app/functions/path_functions.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  List<File> videoFiles = [];
  List<dynamic> videoData = [];

  @override
  void initState() {
    super.initState();
    delayAndCheckPermissions();
  }

  void fetchAndShowVideos() async {
    final fetchedVideos = await PathFunctions.getPath();

    setState(() {
      videoData = List<String>.from(fetchedVideos);
      videoFiles = fetchedVideos.map((path) => File(path)).toList();
    });

    debugPrint('All Video Data:');
    for (String data in videoData) {
      debugPrint(data);
    }
  }

  Future<void> delayAndCheckPermissions() async {
    await Future.delayed(const Duration(seconds: 3));
    checkPermissionsAndNavigate();
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
              content: const Text(
                  'Storage permission is required to use this app. Do you want to see why?'),
              actions: [
                TextButton(
                  onPressed: () => exit(0),
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () => checkPermissionsAndNavigate(),
                  child: const Text('Yes'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void navigateToMainScreen() async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => MainPageScreen(
          videoFile: videoFiles,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 100,
              width: 100,
            ),
            const CircularProgressIndicator(
              strokeWidth: 2.5,
            )
          ],
        ),
      ),
    );
  }
}
