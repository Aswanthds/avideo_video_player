import 'package:flutter/material.dart';
import 'package:video_player_app/Screens/settings/privacy_heading_widget.dart';
//import 'package:video_player_app/Screens/settings/widgets/contactus.dart';
import 'package:video_player_app/Screens/settings/widgets/privacy_text_widget.dart';
import 'package:video_player_app/constants.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: kColorWhite),
        title: const Text('Privacy Statement'),
        backgroundColor: kcolorDarkblue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            PrivacyHeadingWidgget(),
            PrivacyTextWidget(
                heading: 'Video Content',
                content:
                    'Our App is designed to provide you with a seamless video playback experience for video files already stored on your device. We do not collect, store, or transmit any personal information or video content to our servers or third parties'),
            PrivacyTextWidget(
              heading: 'Permissions',
              content:
                  "To function properly, our App may require certain permissions on your device, such as access to your device's storage to locate and play video files. These permissions are solely used for the intended purpose of video playback and do not grant access to your personal files or data.",
            ),
            PrivacyTextWidget(
              heading: "Data Security",
              content:
                  "We take reasonable measures to ensure the security and privacy of your video content while using our App. However, we do not collect or store any of your video files or personal information.",
            ),
            PrivacyTextWidget(
              heading: "Third-Party Services",
              content:
                  "Our App may use third-party services or libraries for video playback and related features. These services may have their own privacy policies, and we encourage you to review them for more information about their data handling practices.",
            ),
            PrivacyTextWidget(
              heading: "Changes to this Privacy Statement",
              content:
                  "We may update this Privacy Statement to reflect changes in our App's features or practices. We encourage you to periodically review this Privacy Statement for any updates.",
            ),
            SizedBox(height: 20),
            Text(
              "By using our App, you agree to the practices described in this Privacy Statement.",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
