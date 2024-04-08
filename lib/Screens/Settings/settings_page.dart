import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:video_player_app/Screens/settings/about_page.dart';
import 'package:video_player_app/Screens/settings/privacy_screen.dart';
import 'package:video_player_app/Screens/settings/widgets/setting_list.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/functions/first_time.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(75),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(24),
            ),
            child: AppBar(
              backgroundColor: kcolorMintGreen,
              title: const Text(
                'Settings',
                style: TextStyle(
                  fontFamily: 'Cookie',
                  fontSize: 35,
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AboutPage(),
              )),
              child: const SettingsListWidget(
                title: 'About',
                icon: Icons.info_outline,
                hasroute: true,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const PrivacyScreen(),
              )),
              child: const SettingsListWidget(
                title: 'Privacy',
                icon: Icons.security_outlined,
                hasroute: true,
              ),
            ),
            GestureDetector(
              onTap: () => MySharedPreferences.inAppReviewApp(),
              child: const SettingsListWidget(
                title: 'Rate the App',
                icon: Icons.feedback,
                hasroute: false,
              ),
            ),
            GestureDetector(
              onTap: () async {
                shareApp();
              },
              child: const SettingsListWidget(
                title: 'Share app',
                icon: Icons.share,
                hasroute: false,
              ),
            )
          ],
        ));
  }

  Future<void> shareApp() async {
    // Set the app link and the message to be shared
    const String appLink =
        'https://play.google.com/store/apps/details?id=com.avideo.avideo_video_player';
    const String message = 'Avideo Video Player ';

    // Share the app link and message using the share dialog
    await FlutterShare.share(
        title: 'Share App', text: message, linkUrl: appLink);
  }
}
