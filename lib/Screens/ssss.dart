// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:video_compress/video_compress.dart';

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, this.title}) : super(key: key);

//   final String? title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   String _counter = 'video';

//   Future<void> _compressVideo() async {
//     var file;
//     if (Platform.isMacOS) {
//       final typeGroup = XTypeGroup(label: 'videos', extensions: ['mov', 'mp4']);
//       file = await openFile(acceptedTypeGroups: [typeGroup]);
//     } else {
//       final picker = ImagePicker();
//       var pickedFile = await picker.pickVideo(source: ImageSource.gallery);
//       file = File(pickedFile!.path);
//     }
//     if (file == null) {
//       return;
//     }
//     await VideoCompress.setLogLevel(0);
//     final info = await VideoCompress.compressVideo(
//       file.path,
//       quality: VideoQuality.MediumQuality,
//       deleteOrigin: false,
//       includeAudio: true,
//     );
//     print(info!.path);
//     setState(() {
//       _counter = info.path!;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title!),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//             InkWell(
//                 child: Icon(
//                   Icons.cancel,
//                   size: 55,
//                 ),
//                 onTap: () {
//                   VideoCompress.cancelCompression();
//                 }),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => VideoThumbnail()),
//                 );
//               },
//               child: Text('Test thumbnail'),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async => _compressVideo(),
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
