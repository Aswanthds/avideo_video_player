import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player_app/constants.dart';

class ThumbnailMostlyHeadingWidget extends StatelessWidget {
  const ThumbnailMostlyHeadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.blue.withOpacity(0.4)),
          child: Center(
            child: Text(
              'Most Played ',
              style: GoogleFonts.cookie(
                color: kcolorblack,
                fontStyle: FontStyle.italic,
                fontSize: 70,
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.play_arrow,
                    color: kcolorblack,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.shuffle,
                    color: kcolorblack,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
