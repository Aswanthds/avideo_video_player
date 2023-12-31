import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:video_player_app/Screens/settings/widgets/about_info_tile.dart';
import 'package:video_player_app/Screens/settings/widgets/about_logo_widget.dart';
import 'package:video_player_app/Screens/settings/widgets/about_app_text.dart';
import 'package:video_player_app/Screens/settings/widgets/settings_appbar.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  PackageInfo? packageInfo;

  @override
  void initState() {
    super.initState();
    _getdetailsApp();
  }

  _getdetailsApp() async {
    var info = await PackageInfo.fromPlatform();

    setState(() {
      packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: SettingsAppBar(),
      ),
      body: ListView(
        children: [
          const AboutLogoWidget(),
          const AboutAppText(),
          AboutInfoTile(title: 'App name', subtitle: packageInfo!.appName),
          AboutInfoTile(title: 'App version', subtitle: packageInfo!.version),
        ],
      ),
    );
  }
}
