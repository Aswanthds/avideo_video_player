// ignore_for_file: use_build_context_synchronously

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player_app/Screens/mainpage.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/widgets/app_intro_logo.dart';

class WelcomePage extends StatefulWidget {
  final bool isFirst;
  const WelcomePage({Key? key, required this.isFirst}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
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
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainPageScreen()),
        );
      } else if (result.isPermanentlyDenied) {
        openAppSettings();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    checkPermissionsAndNavigate();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kColorWhite,
      body: AppIntroLogo(),
    );
  }
}
