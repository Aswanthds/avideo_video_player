// ignore_for_file: use_build_context_synchronously

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    bool permissionStatus;
    final deviceInfo = await DeviceInfoPlugin().androidInfo;
    PermissionStatus result;

    if (deviceInfo.version.sdkInt >= 33) {
      permissionStatus = await Permission.videos.request().isGranted;
    } else {
      permissionStatus = await Permission.storage.request().isGranted;
    }

    if (permissionStatus == true) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainPageScreen()),
      );
    } else {
      deviceInfo.version.sdkInt > 32
          ? (result = await Permission.videos.request())
          : (result = await Permission.storage.request());

      if (result.isGranted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainPageScreen()),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.isFirst) {
      Center(
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
      );
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
          ? Center(
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
            )
          : Padding(
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
                        style: TextStyle(
                            color: kcolorDarkblue, fontFamily: 'OpenSans'),
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
            ),
    );
  }
}
