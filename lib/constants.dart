import 'package:flutter/material.dart';

const kColorSandal = Color.fromARGB(204, 236, 170, 88);
const kcolorMintGreen = Color.fromARGB(255, 102, 67, 201);
const kcolorblack = Colors.black;
const kcolorblack54 = Colors.black54;
final kcolorblack05 = Colors.black.withOpacity(0.5);
const kColorBlue = Colors.blue;
const kColorLightBlue = Colors.lightBlue;
const kColorblueAccent = Colors.blueAccent;
const kColorIndigo = Colors.indigo;
const kColorTeal = Colors.teal;
const kColorCyan = Colors.cyan;
const kColorWhite = Colors.white;
const kColorWhite70 = Colors.white70;
const kColorWhite30 = Colors.white30;
const kColorWhite12 = Colors.white12;
const kColorWhite54 = Colors.white54;
const kColorOrange = Colors.orange;
const kColorDeepOrange = Colors.deepOrange;
const kColorAmber = Colors.amber;
const kColorOrangeAccent = Colors.orangeAccent;

// No data available Texts

// const Widget nodata =
//     Text('No data available', style: TextStyle(color: kColorIndigo));
const Widget emptyPlaylist = Text('Created playlist appears here',
    style: TextStyle(color: kColorIndigo));

const Widget nodata = Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Icon(
      Icons.error_outline,
      size: 30,
      color: kColorIndigo,
    ),
    SizedBox(
      width: 10,
    ),
    Text('No videos are found !! ', style: TextStyle(color: kColorIndigo))
  ],
);
const Widget nodatarecently = Text(
  'Recently played videos are listed here',
  style: TextStyle(color: kcolorblack54),
);

const TextStyle appbar =
    TextStyle(color: kColorWhite, fontSize: 25, fontWeight: FontWeight.bold);

const TextStyle bottomNav = TextStyle(fontFamily: 'Koulen');

const TextStyle favorites = TextStyle(
  fontSize: 15,
  color: kColorWhite,
  fontWeight: FontWeight.bold,
);

const SnackBar deleteMsg = SnackBar(
  behavior: SnackBarBehavior.floating,
  backgroundColor: Color.fromARGB(255, 175, 78, 71),
  content: Text('Video removed sucesfully'), //
  duration: Duration(seconds: 2), //
);

const SnackBar deletePlaylistMsg = SnackBar(
  behavior: SnackBarBehavior.floating,
  backgroundColor: Color.fromARGB(255, 175, 78, 71),
  content: Text('Playlist Deleted'), //
  duration: Duration(seconds: 2), //
);

const SnackBar postivePlaylist = SnackBar(
  behavior: SnackBarBehavior.floating,
  backgroundColor: kColorIndigo,
  content: Text('Video added to playlist'), //
  duration: Duration(seconds: 2), //
);
const SnackBar postiveNewPlaylist = SnackBar(
  behavior: SnackBarBehavior.floating,
  backgroundColor: kColorIndigo,
  content: Text('Playlist ready !!!'), //
  duration: Duration(seconds: 2), //
);

const SnackBar positiveFavorites = SnackBar(
  behavior: SnackBarBehavior.floating,
  backgroundColor: kColorIndigo,
  content: Text('Video added to favorites'), //
  duration: Duration(seconds: 2), //
);

const SnackBar negativeFavorites = SnackBar(
  behavior: SnackBarBehavior.floating,
  backgroundColor: Color.fromARGB(255, 175, 78, 71),
  content: Text('Video removed from favorites'), //
  duration: Duration(seconds: 2), //
);
