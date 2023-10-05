import 'package:flutter/material.dart';

const kcolorDarkblue = Color.fromARGB(238, 0, 53, 84);
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
const TextStyle appbar =
    TextStyle(color: kColorWhite, fontSize: 25, fontWeight: FontWeight.bold);

const TextStyle bottomNav = TextStyle(fontFamily: 'Koulen');

const TextStyle favorites = TextStyle(
    fontSize: 15,
    color: kcolorDarkblue,
    fontWeight: FontWeight.bold,
    fontFamily: 'NixieOne');
