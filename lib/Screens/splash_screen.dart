// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:video_player_app/Screens/mainpage.dart';
// import 'package:video_player_app/functions/db_functions.dart';

// class SplashScreenPage extends StatefulWidget {
//   const SplashScreenPage({super.key});

//   @override
//   State<SplashScreenPage> createState() => _SplashScreenPageState();
// }

// class _SplashScreenPageState extends State<SplashScreenPage> {
//   List<File> videoFiles = [];
//   List<dynamic> videoData = [];
//   List<Uint8List> thumbnails = [];
//   File? file;

//   @override
//   void initState() {
//     super.initState();
//     checkPermissionsAndNavigate();
//     fetchAndShowVideos();
//   }

//   void fetchAndShowVideos() async {
//     final fetchedVideos = await VideoFunctions.getPath();

//     setState(() {
//       videoData = List<String>.from(fetchedVideos);
//       videoFiles = fetchedVideos.map((path) => File(path)).toList();
//     });

//     print('All Video Data:');
//     for (String data in videoData) {
//       print(data);
//     }
//   }

//   Future<void> checkPermissionsAndNavigate() async {
//     final status = await Permission.storage.status;

//     if (status.isGranted) {
//       navigateToMainScreen();
//     } else {
//       final result = await Permission.storage.request();

//       if (result.isGranted) {
//         navigateToMainScreen();
//       } else {
//         showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               title: Text('Permission Denied'),
//               content: Text('Camera permission is required to use this app.'),
//               actions: [
//                 TextButton(
//                   onPressed: () => exit(0),
//                   child: Text('OK'),
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     }
//   }

//   void navigateToMainScreen() {
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(
//         builder: (context) => MainPageScreen(),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         children: [
//           Lottie.network(
//               'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/A.json'),
//           Text(
//             'Version 1.0.0',
//             style: TextStyle(
//               color: Colors.black,
//               decoration: TextDecoration.none,
//               fontSize: 12,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
