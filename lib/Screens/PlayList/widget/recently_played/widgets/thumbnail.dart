import 'package:flutter/material.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/screens/PlayList/widget/recently_played/video_tile_recently.dart';

class ThumbnailRecentlyPlayed extends StatelessWidget {
  const ThumbnailRecentlyPlayed({
    super.key,
    required this.widget,
  });

  final RecentlyPlayedVideoTileWidget widget;

  @override
  Widget build(BuildContext context) {
    double? calculateProgress(double? current, double? full) {
      if (current == null ||
          full == null ||
          current.isNaN ||
          full.isNaN ||
          full <= 0) {
        return 0.0; //
      }
      return current / full;
    }

    return Stack(
      children: [
        (widget.thumbnail.path.isNotEmpty)
            ? Container(
                width: 100,
                height: 160,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: kcolorblack,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: FileImage(widget.thumbnail),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: LinearProgressIndicator(
                    minHeight: 2,
                    value: calculateProgress(widget.current, widget.full),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(kcolorDarkblue),
                    backgroundColor: kColorWhite54,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              )
            : Container(
                width: 100,
                height: 160,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: kcolorblack,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  image: const DecorationImage(
                    image:
                        AssetImage('assets/images/thumbnail_placeholder.jpg'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              )
      ],
    );
  }
}
