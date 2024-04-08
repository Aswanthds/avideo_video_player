import 'package:flutter/material.dart';
import 'package:video_player_app/constants.dart';

class PlayListWidget extends StatelessWidget {
  final String title;

  const PlayListWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: Container(
            decoration: BoxDecoration(
                color: kColorSandal,
                border: Border.all(
                  style: BorderStyle.solid,
                  color: kcolorMintGreen,
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
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: kcolorMintGreen,
            fill: 0,
          ),
        ),
      ),
    );
  }
}
