import 'package:flutter/material.dart';
import 'package:video_player_app/constants.dart';

class ThumbnailRecentlyHeadingWidget extends StatelessWidget {
  const ThumbnailRecentlyHeadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: kColorWhite, borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: kColorSandal),
        child: const Center(
          child: Text(
            'RecentlyPlayed',
            style: TextStyle(
              fontFamily: 'Cookie',
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
