import 'package:flutter/material.dart';
import 'package:video_player_app/constants.dart';

class CustomAppBar extends StatelessWidget {
  final String filename;
  final VoidCallback toggleVolumeSlider;

  const CustomAppBar({
    super.key,
    required this.filename,
    required this.toggleVolumeSlider,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: kColorWhite),
      backgroundColor: Colors.transparent,
      title: Text(filename),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Container(
          child: Row(
            children: [
              IconButton(
                onPressed: toggleVolumeSlider,
                icon: Icon(
                  Icons.volume_up,
                  color: kColorWhite,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
    );
  }
}
