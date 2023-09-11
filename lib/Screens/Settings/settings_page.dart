import 'package:flutter/material.dart';
import 'package:video_player_app/Screens/Settings/about_page.dart';
import 'package:video_player_app/Screens/Settings/privacy_screen.dart';
import 'package:video_player_app/Screens/Settings/widgets/setting_list.dart';
import 'package:video_player_app/constants.dart';

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
              backgroundColor: kcolorDarkblue,
              title: const Text(
                'Settings',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.search))
              ],
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
            const SettingsListWidget(
              title: 'Provide Feedback',
              icon: Icons.feedback,
              hasroute: false,
            ),
            const SettingsListWidget(
              title: 'Share app',
              icon: Icons.share,
              hasroute: false,
            )
          ],
        ));
  }
}
