import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MostPlayedVideos extends StatefulWidget {
  const MostPlayedVideos({super.key});

  @override
  State<MostPlayedVideos> createState() => _MostPlayedVideosState();
}

class _MostPlayedVideosState extends State<MostPlayedVideos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(75),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(24),
          ),
          child: AppBar(
            automaticallyImplyLeading: true,
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            backgroundColor: const Color(0xF1003554),
            title: const Text(
              'Most Played Videos',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.search))
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(85, 0, 53, 84),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            blurStyle: BlurStyle.inner,
                            color: Colors.transparent,
                            spreadRadius: 5,
                            blurRadius: 10)
                      ],
                      color: Colors.grey.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: AssetImage('images/logo_full.png'),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, top: 15, bottom: 15),
                        child: Text(
                          'Recently Played Videos',
                          style: GoogleFonts.abel(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.shuffle,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Container(
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0xF1003554),
                          blurRadius: 10,
                          blurStyle: BlurStyle.outer),
                    ],
                    color: const Color(0xF1003554),
                    border: Border.all(
                      style: BorderStyle.solid,
                      color: const Color(0xF1003554),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'images/logo.png',
                      color: Colors.white,
                    ))),
            title: const Text('Video'),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xF1003554),
              fill: 0,
            ),
          ),
        ],
      ),
    );
  }
}
