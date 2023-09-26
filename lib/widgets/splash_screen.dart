//

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player_app/Screens/mainpage.dart';
import 'package:video_player_app/constants.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:video_player_app/functions/path_functions.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  List<File> videoFiles = [];
  List<dynamic> videoData = [];
  bool? isGranted;
//
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

    //
    for (String data in videoData) {
      debugPrint(data);
    }
  }

  Future<void> delayAndCheckPermissions() async {
    await Future.delayed(const Duration(seconds: 3));
    _reqPermission();
  }

  Future<void> navigateToMainScreen() async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => MainPageScreen(
          videoFile: videoFiles,
        ),
      ),
    );
  }

  Future<void> _reqPermission() async {
    AndroidDeviceInfo build = await DeviceInfoPlugin().androidInfo;
    if (build.version.sdkInt >= 30) {
      var req = await Permission.manageExternalStorage.request();
      if (req.isGranted) {
        setState(() {
          isGranted = true;
        });
      } else {
        setState(() {
          isGranted = false;
        });
      }
    } else {
      if (await Permission.storage.isGranted) {
        setState(() {
          isGranted = true;
        });
      } else {
        var result = await Permission.storage.request();
        if (result.isGranted) {
          setState(() {
            isGranted = true;
          });
        } else {
          setState(() {
            isGranted = false;
          });
        }
      }
    }
    if (isGranted == true) {
      navigateToMainScreen();
    } else {
      openAppSettings();
    }
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
