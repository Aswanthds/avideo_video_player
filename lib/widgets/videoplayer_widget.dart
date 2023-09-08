// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:path/path.dart';
// import 'package:video_player/video_player.dart';
// import 'package:video_player_app/constants.dart';

// class VideoPlayerScreen extends StatefulWidget {
//   final String filesV;
//   const VideoPlayerScreen({super.key, required this.filesV});

//   @override
//   State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
// }

// class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
//   late VideoPlayerController _controller;
//   double _volumeLevel = 1.0;
//   bool _showVolumeSlider = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.file(File(widget.filesV));
//     _controller.initialize().then((_) {
//       setState(() {});
//     });
//   }

//   void toggleVolumeSlider() {
//     setState(() {
//       _showVolumeSlider = !_showVolumeSlider;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final filename = basename(widget.filesV);
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: const IconThemeData(color: kColorWhite),
//         backgroundColor: Colors.transparent,
//         title: Text(filename),
//         actions: const [Icon(Icons.more_vert)],
//       ),
//       backgroundColor: kcolorblack,
//       body: GestureDetector(
//         onHorizontalDragUpdate: (details) {
//           // Detect swiping gestures on the left side of the screen.
//           if (details.localPosition.dx <
//               MediaQuery.of(context).size.width / 2) {
//             toggleVolumeSlider();
//           }
//         },
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             AspectRatio(
//               aspectRatio: _controller.value.aspectRatio,
//               child: VideoPlayer(_controller),
//             ),
//             if (_showVolumeSlider)
//               Positioned(
//                 top: 50,
//                 left: 20,
//                 child: Container(
//                   width: 100,
//                   child: Transform.rotate(
//                     angle: -90 * (3.14 / 180), 
//                     child: Slider(
//                       value: _volumeLevel,
//                       onChanged: (newValue) {
//                         setState(() {
//                           _volumeLevel = newValue;
//                           _controller.setVolume(newValue);
//                         });
//                       },
//                       min: 0.0,
//                       max: 1.0,
//                       divisions: 100,
//                       label: 'Volume: ${(_volumeLevel * 100).round()}%',
//                     ),
//                   ),
//                 ),
//               ),
//             Positioned(
//               right: 0,
//               bottom: 120,
//               child: Container(
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(50),
//                     color: kcolorblack54),
//                 child: IconButton(
//                     onPressed: () {},
//                     icon: const Icon(
//                       Icons.fullscreen,
//                       color: kColorWhite,
//                     )),
//               ),
//             ),
//             Align(
//               alignment: AlignmentDirectional.bottomStart,
//               child: Container(
//                 height: 120,
//                 decoration: const BoxDecoration(
//                   color: kcolorblack54,
//                 ),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(
//                           left: 20.0, right: 20, top: 20, bottom: 10),
//                       child: VideoProgressIndicator(
//                         _controller,
//                         colors: const VideoProgressColors(
//                           playedColor: Colors.blue,
//                           backgroundColor: Colors.grey,
//                         ),
//                         allowScrubbing: true,
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         IconButton(
//                           onPressed: () {
//                             // Handle forward action
//                           },
//                           icon: const Icon(
//                             Icons.replay_10,
//                             size: 32.0,
//                             color: kColorWhite,
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             // Handle forward action
//                           },
//                           icon: const Icon(
//                             Icons.skip_previous,
//                             size: 32.0,
//                             color: kColorWhite,
//                           ),
//                         ),
                        // GestureDetector(
                        //   onTap: () {
                        //     setState(() {
                        //       if (_controller.value.isPlaying) {
                        //         _controller.pause();
                        //       } else {
                        //         _controller.play();
                        //       }
                        //     });
                        //   },
                        //   child: Icon(
                        //     _controller.value.isPlaying
                        //         ? Icons.pause_circle_outline
                        //         : Icons.play_circle_outline,
                        //     size: 72.0,
                        //     color: kColorWhite,
                        //   ),
                        // ),
//                         IconButton(
//                           onPressed: () {
//                             // Handle next action
//                           },
//                           icon: const Icon(
//                             Icons.skip_next,
//                             size: 32.0,
//                             color: kColorWhite,
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             // Handle forward action
//                           },
//                           icon: const Icon(
//                             Icons.forward_10,
//                             size: 32.0,
//                             color: kColorWhite,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }
// }
