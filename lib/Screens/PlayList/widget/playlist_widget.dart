import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player_app/constants.dart';

class PlayListWidget extends StatelessWidget {
  final String title;

  const PlayListWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  color: kcolorDarkblue,
                  blurRadius: 10,
                  blurStyle: BlurStyle.outer),
            ],
            color: kcolorDarkblue,
            border: Border.all(
              style: BorderStyle.solid,
              color: kcolorDarkblue,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/images/logo.png',
            color: kColorWhite,
          ),
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.nixieOne(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: kcolorDarkblue,
        fill: 0,
      ),
    );
  }
}
