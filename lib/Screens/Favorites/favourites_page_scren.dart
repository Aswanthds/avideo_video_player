import 'package:flutter/material.dart';

class FavouritesPageScreen extends StatefulWidget {
  const FavouritesPageScreen({super.key});

  @override
  State<FavouritesPageScreen> createState() => _FavouritesPageScreenState();
}

class _FavouritesPageScreenState extends State<FavouritesPageScreen> {
  @override
  Widget build(BuildContext context) {
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
        ],
        elevation: 8.0,
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(75),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(24),
          ),
          child: AppBar(
            backgroundColor: const Color(0xF1003554),
            title: const Text(
              'Favourites',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.search))
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(style: BorderStyle.solid, width: 0.5),
              borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            leading: const Icon(
              Icons.smart_display,
              size: 50,
            ),
            title: const Text(
              'Videos 1',
              style: TextStyle(fontSize: 20),
            ),
            trailing: GestureDetector(
              onTapDown: (TapDownDetails details) {
                showPopupMenu(details.globalPosition);
              },
              child: const Icon(Icons.more_vert),
            ),
          ),
        ),
      ),
    );
  }
}
