// ignore_for_file: use_build_context_synchronously

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
  bool? permissionGranted;

//navigateToMainScreen();
  @override
  void initState() {
    super.initState();
    _getStoragePermission();
  }

  void fetchAndShowVideos() async {
    final fetchedVideos = await PathFunctions.getVideoPathsAsync();

    setState(() {
      videoData = List<String>.from(fetchedVideos);
      videoFiles = fetchedVideos.map((path) => File(path)).toList();
    });

    // debugPrint('All Video Data:');
    for (String data in videoData) {
      debugPrint(data);
    }
  }

  // Future<void> delayAndCheckPermissions() async {
  //   await Future.delayed(const Duration(seconds: 3));
  //   _getStoragePermission();
  // }

  Future<void> navigateToMainScreen() async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => MainPageScreen(
          videoFile: videoFiles,
        ),
      ),
    );
  }

  Future<void> _getStoragePermission() async {
    DeviceInfoPlugin plugin = DeviceInfoPlugin();
    AndroidDeviceInfo android = await plugin.androidInfo;
    if (android.version.sdkInt < 33) {
      final res = await Permission.storage.shouldShowRequestRationale;
      if (await Permission.storage.request().isGranted && res) {
        setState(() {
          permissionGranted = true;
        });
        navigateToMainScreen();
      } else if (await Permission.storage.request().isPermanentlyDenied &&
          res) {
        await openAppSettings();
      } else if (await Permission.storage.request().isDenied && res) {
        setState(() {
          permissionGranted = false;
        });
      }
    } else {
      if (await Permission.videos.request().isGranted) {
        setState(() {
          permissionGranted = true;
        });
      } else if (await Permission.videos.request().isPermanentlyDenied) {
        await openAppSettings();
      } else if (await Permission.videos.request().isDenied) {
        setState(() {
          permissionGranted = false;
        });
      }
    }
    if (permissionGranted == true) {
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
