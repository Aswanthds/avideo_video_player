// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/screens/mainpage.dart';

class WelcomeScreenWidget extends StatefulWidget {
  const WelcomeScreenWidget({
    super.key,
  });

  @override
  State<WelcomeScreenWidget> createState() => _WelcomeScreenWidgetState();
}

class _WelcomeScreenWidgetState extends State<WelcomeScreenWidget> {
   @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = const Duration(seconds: 8);
    return  Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const MainPageScreen()));
  }
  @override
  Widget build(BuildContext context) {
    Future<void> checkPermissionsAndNavigate() async {
      PermissionStatus permissionStatus;
      final deviceInfo = await DeviceInfoPlugin().androidInfo;
      PermissionStatus result;

      if (deviceInfo.version.sdkInt >= 33) {
        permissionStatus = await Permission.videos.request();
      } else {
        permissionStatus = await Permission.storage.request();
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
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MainPageScreen()),
          );
        } else {
          openAppSettings();
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 30,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 75,
                ),
                Image.asset(
                  'assets/images/title2.png',
                  height: 75,
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                'Welcome to Avideo Video Player App!',
                style: TextStyle(color: kcolorDarkblue, fontFamily: 'OpenSans'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kcolorDarkblue,
                ),
                onPressed: () {
                  checkPermissionsAndNavigate();
                },
                child: const Text(
                  'Get Started',
                  style: TextStyle(color: kColorWhite),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
