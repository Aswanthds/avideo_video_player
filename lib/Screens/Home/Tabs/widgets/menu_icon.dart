import 'package:flutter/material.dart';
import 'package:video_player_app/constants.dart';

class MenuIconWidget extends StatelessWidget {
  final String title;

  final IconData icon;

  const MenuIconWidget({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
      child: Column(
        children: [
          CircleAvatar(
              radius: 20,
              backgroundColor: kColorTeal,
              child: Center(
                child: Icon(
                  icon,
                  color: kColorWhite,
                ),
              )),
          Text(
            title,
            maxLines: 1,
            style: const TextStyle(
              fontSize: 18,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
