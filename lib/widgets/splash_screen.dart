// ignore_for_file: use_build_context_synchronously

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player_app/Screens/mainpage.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/widgets/app_intro_logo.dart';
import 'package:video_player_app/widgets/welcome_screen.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    checkFirstTimeLaunch();
  }

  Future<void> checkFirstTimeLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstTime = prefs.getBool('isFirstTime') ?? true;

    if (isFirstTime) {
      // If it's the first launch, navigate to the welcome page
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => WelcomePage(
          isFirst: isFirstTime,
        ),
      ));
    } else {
      // If not the first launch, navigate directly to the main screen
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainPageScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Your splash screen UI
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

  @override
  void initState() {
    super.initState();
    if (widget.isFirst) {
      const AppIntroLogo();
      checkPermissionsAndNavigate();
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainPageScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite,
      body: widget.isFirst
          ?  const AppIntroLogo()
          :  const WelcomeScreenWidget(),
    );
  }
}
