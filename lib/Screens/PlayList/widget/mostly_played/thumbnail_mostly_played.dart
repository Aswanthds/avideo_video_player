import 'package:flutter/material.dart';
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
              borderRadius: BorderRadius.circular(20), color: kColorSandal),
          child: const Center(
            child: Text(
              'Most Played ',
              style: TextStyle(
                fontFamily: 'Cookie',
                color: kcolorblack,
                fontStyle: FontStyle.italic,
                fontSize: 70,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
