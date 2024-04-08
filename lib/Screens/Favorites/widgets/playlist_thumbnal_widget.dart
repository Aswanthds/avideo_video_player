import 'package:flutter/material.dart';
import 'package:video_player_app/constants.dart';

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
          color: kColorSandal,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Center(
          child: Text(
            'Favorites',
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
