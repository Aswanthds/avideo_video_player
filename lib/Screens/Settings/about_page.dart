import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:video_player_app/constants.dart';

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

  Widget _infoTile(String title, String subtitle) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      subtitle: Text(
        subtitle.isEmpty ? 'Not set' : subtitle,
        style: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 15,
        ),
      ),
    );
  }

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
            automaticallyImplyLeading: true,
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: const Color(0xF1003554),
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.info_outline),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'About the App',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 100,
              ),
              Image.asset(
                'assets/images/title2.png',
                height: 100,
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "AVideo Video Player app  is a user-friendly video player app designed to provide you with a seamless video playback experience. Whether you're watching movies, videos, or educational content, AVideo has you covered with its powerful features and intuitive interface.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kcolorblack54,
                fontSize: 18,
              ),
            ),
          ),
          _infoTile('App name', packageInfo!.appName),
          _infoTile('Package name', packageInfo!.packageName),
          _infoTile('App version', packageInfo!.version),
          _infoTile('Build number', packageInfo!.buildNumber),
          _infoTile('Build signature', packageInfo!.buildSignature),
          _infoTile(
            'Installer store',
            packageInfo!.installerStore ?? 'not available',
          ),
        ],
      ),
    );
  }
}
