import 'package:flutter/material.dart';
import 'package:video_player_app/constants.dart';

class SettingsAppBar extends StatelessWidget {
  const SettingsAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(24),
      ),
      child: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: kColorWhite),
        backgroundColor: kcolorDarkblue,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.info_outline),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                'About the App',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
