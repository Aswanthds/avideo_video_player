import 'package:flutter/material.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/widgets/home_tabbar.dart';

class AppbarCommon extends StatefulWidget {
  final String title;
  final bool isHome;
  final Widget navigation;
  const AppbarCommon({
    super.key,
    required this.title,
    required this.isHome,
    required this.navigation,
  });

  @override
  State<AppbarCommon> createState() => _AppbarCommonState();
}

class _AppbarCommonState extends State<AppbarCommon> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(24),
      ),
      child: AppBar(
        
          iconTheme: const IconThemeData(color: kColorWhite),
          backgroundColor: kcolorDarkblue,
          title: Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          actions: [
            IconButton(
                onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => widget.navigation,
                      ),
                    ),
                icon: const Icon(Icons.search))
          ],
          bottom: widget.isHome
              ? const PreferredSize(
                  preferredSize: Size.fromHeight(50), child: HomeTabBar())
              : null),
    );
  }
}

