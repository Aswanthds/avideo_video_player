import 'package:flutter/material.dart';
import 'package:video_player_app/widgets/appbar_common.dart';

class RecentlyPlayedVideos extends StatefulWidget {
  const RecentlyPlayedVideos({super.key});

  @override
  State<RecentlyPlayedVideos> createState() => _RecentlyPlayedVideosState();
}

class _RecentlyPlayedVideosState extends State<RecentlyPlayedVideos> {
  showPopupMenu(Offset offset) async {
    double left = offset.dx;
    double top = offset.dy;
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(left, top, 30, 0),
      items: [
        const PopupMenuItem<Widget>(
          child: Row(
            children: [
              Icon(Icons.favorite_outline),
              Text('Remove from favourites'),
            ],
          ),
        ),
        const PopupMenuItem<Widget>(
          child: Row(
            children: [
              Icon(Icons.playlist_add),
              Text('Add to Playlist'),
            ],
          ),
        ),
        const PopupMenuItem<Widget>(
          child: Row(
            children: [
              Icon(Icons.info_sharp),
              Text('Info'),
            ],
          ),
        ),
      ],
      elevation: 8.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: AppbarCommon(
          title: 'Recently Played Videos', isHome: false,
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
                        image: AssetImage('assets/images/logo_full.png'),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20, top: 15, bottom: 15),
                        child: Text(
                          'Recently Played Videos',
                          style: TextStyle(
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
                      'assets/images/logo.png',
                      color: Colors.white,
                    ))),
            title: const Text('Video'),
            trailing: GestureDetector(
              onTapDown: (TapDownDetails details) =>
                  showPopupMenu(details.globalPosition),
              child: const Icon(
                Icons.more_vert,
                color: Color(0xF1003554),
                fill: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
