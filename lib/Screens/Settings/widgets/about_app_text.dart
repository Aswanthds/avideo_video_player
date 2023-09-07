import 'package:flutter/material.dart';
import 'package:video_player_app/constants.dart';

class AboutAppText extends StatelessWidget {
  const AboutAppText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        "AVideo Video Player app  is a user-friendly video player app designed to provide you with a seamless video playback experience. Whether you're watching movies, videos, or educational content, AVideo has you covered with its powerful features and intuitive interface.",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: kcolorblack54,
          fontSize: 18,
        ),
      ),
    );
  }
}
