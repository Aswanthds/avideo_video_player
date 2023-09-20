/*
url_launcher: ^6.1.14


import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:video_player_app/constants.dart';

class ContactUsText extends StatelessWidget {
  final String email;
  final String displayText;

  const ContactUsText(
      {super.key, required this.email, required this.displayText});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(
        style: const TextStyle(height: 1.5),
        children: [
          TextSpan(
            text: '$displayText ',
            style: const TextStyle(
              fontSize: 20,
              color: kcolorblack54,
            ),
          ),
          TextSpan(
            text: email,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.blue,
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


*/