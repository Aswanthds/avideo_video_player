import 'package:flutter/material.dart';
import 'package:video_player_app/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class PlayListThumbnailWidget extends StatelessWidget {
  const PlayListThumbnailWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              blurStyle: BlurStyle.inner,
              color: Colors.transparent,
              spreadRadius: 5,
              blurRadius: 10,
            )
          ],
          color: Colors.blue.withOpacity(0.4),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            'Favorites',
            style: GoogleFonts.cookie(
              color: kcolorblack,
              fontStyle: FontStyle.italic,
              fontSize: 70,
            ),
          ),
        ),
      ),
    );
  }
}
