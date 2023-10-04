import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player_app/constants.dart';

class ThumbnailRecentlyPlayed extends StatefulWidget {
  const ThumbnailRecentlyPlayed({
    super.key,
    required this.thumbnail, required this.current, required this.full,
  });

    final File thumbnail;
     final double current;
  final double full;

  @override
  State<ThumbnailRecentlyPlayed> createState() => _ThumbnailRecentlyPlayedState();
}

class _ThumbnailRecentlyPlayedState extends State<ThumbnailRecentlyPlayed> {
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
