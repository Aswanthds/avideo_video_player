import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MostPlayedPage extends StatefulWidget {
  const MostPlayedPage({super.key});

  @override
  State<MostPlayedPage> createState() => _MostPlayedPageState();
}

class _MostPlayedPageState extends State<MostPlayedPage> {
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
              'Playlists',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.search))
            ],
          ),
        ),
      ),
      body:  ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(85, 0, 53, 84),
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
                      image: DecorationImage(
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
                              icon: Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
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
         
        ],
      ),
    );
  }
}
