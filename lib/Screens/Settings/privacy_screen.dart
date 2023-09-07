import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:video_player_app/Screens/Settings/widgets/contactus.dart';
import 'package:video_player_app/Screens/Settings/widgets/privacy_text_widget.dart';
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
          children: [
            PrivacyHeadingWidgget(),
            const PrivacyTextWidget(
                heading: 'Video Content',
                content:
                    'Our App is designed to provide you with a seamless video playback experience for video files already stored on your device. We do not collect, store, or transmit any personal information or video content to our servers or third parties'),
            const PrivacyTextWidget(
              heading: 'Permissions',
              content:
                  "To function properly, our App may require certain permissions on your device, such as access to your device's storage to locate and play video files. These permissions are solely used for the intended purpose of video playback and do not grant access to your personal files or data.",
            ),
            const PrivacyTextWidget(
              heading: "Data Security",
              content:
                  "We take reasonable measures to ensure the security and privacy of your video content while using our App. However, we do not collect or store any of your video files or personal information.",
            ),
            const PrivacyTextWidget(
              heading: "Third-Party Services",
              content:
                  "Our App may use third-party services or libraries for video playback and related features. These services may have their own privacy policies, and we encourage you to review them for more information about their data handling practices.",
            ),
            const PrivacyTextWidget(
              heading: "Changes to this Privacy Statement",
              content:
                  "We may update this Privacy Statement to reflect changes in our App's features or practices. We encourage you to periodically review this Privacy Statement for any updates.",
            ),
            const SizedBox(height: 20),
            const Text(
              "Contact Us",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const ContactUsText(
              email: 'worldofaswanth@gmail.com',
              displayText:
                  "If you have any questions or concerns about our App's privacy practices, please contact us at ",
            ),
            const SizedBox(height: 20),
            const Text(
              "By using our App, you agree to the practices described in this Privacy Statement.",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

class PrivacyHeadingWidgget extends StatelessWidget {
  const PrivacyHeadingWidgget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final _date = DateTime(2023, 9, 7);
    String formattedMonth = DateFormat('dd-MMM-yyy').format(_date);
    return Column(
      children: [
        Center(
          child: Column(
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 100,
              ),
              const SizedBox(height: 20),
              const Text(
                "Privacy Statement",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "Last Updated: $formattedMonth",
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          "The Developer respects your privacy and is committed to protecting your personal information. This Privacy Statement outlines how we handle video content and user data in AVideo video player app",
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
