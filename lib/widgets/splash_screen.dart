// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player_app/Screens/mainpage.dart';
import 'package:video_player_app/constants.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    checkPermissionsAndNavigate();
  }

  Future<void> checkPermissionsAndNavigate() async {
    PermissionStatus permissionStatus;
    final deviceInfo = await DeviceInfoPlugin().androidInfo;
    PermissionStatus result;
    final status = await Permission.videos.status;
    final statusi = await Permission.storage.status;

    if (deviceInfo.version.sdkInt >= 33) {
      permissionStatus = await Permission.videos.request();
      debugPrint(status.toString());
    } else {
      permissionStatus = await Permission.storage.request();
      debugPrint(statusi.toString());
    }

    if (permissionStatus.isGranted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainPageScreen()),
      );
    } else {
      deviceInfo.version.sdkInt >= 33
          ? (result = await Permission.videos.request())
          : (result = await Permission.storage.request());

      if (result.isGranted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const MainPageScreen()));
      } else if (result.isPermanentlyDenied) {
        openAppSettings();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/logo_full.png'),
          const CircularProgressIndicator.adaptive(
            valueColor: AlwaysStoppedAnimation(kColorIndigo),
            backgroundColor: kcolorDarkblue,
          )
        ],
      ),
    );
  }
}
