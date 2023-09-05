import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedMonth = DateFormat('dd-MMM-yyy').format(now);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Privacy Statement'),
        backgroundColor: const Color(0xF1003554),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
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
            const SizedBox(height: 20),
            const Text(
              "Video Content",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Our App is designed to provide you with a seamless video playback experience for video files already stored on your device. We do not collect, store, or transmit any personal information or video content to our servers or third parties.",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text(
              "Permissions",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "To function properly, our App may require certain permissions on your device, such as access to your device's storage to locate and play video files. These permissions are solely used for the intended purpose of video playback and do not grant access to your personal files or data.",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text(
              "Data Security",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "We take reasonable measures to ensure the security and privacy of your video content while using our App. However, we do not collect or store any of your video files or personal information.",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text(
              "Third-Party Services",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Our App may use third-party services or libraries for video playback and related features. These services may have their own privacy policies, and we encourage you to review them for more information about their data handling practices.",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text(
              "Changes to this Privacy Statement",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "We may update this Privacy Statement to reflect changes in our App's features or practices. We encourage you to periodically review this Privacy Statement for any updates.",
              style: TextStyle(fontSize: 18),
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
            const EmailHyperlinkWidget(
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

class EmailHyperlinkWidget extends StatelessWidget {
  final String email;
  final String displayText;

  const EmailHyperlinkWidget({super.key, required this.email, required this.displayText});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$displayText ',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black, // Customize text style as needed
            ),
          ),
          TextSpan(
            text: email,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.blue, // Hyperlink color
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                final Uri emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: email,
                );
                final String emailAddress = emailLaunchUri.toString();
                if (await canLaunchUrlString(emailAddress)) {
                  await launchUrlString(emailAddress);
                } else {
                  throw 'Could not mail $emailAddress';
                }
              },
          ),
        ],
      ),
    );
  }
}
