import 'package:flutter/material.dart';
import 'package:video_player_app/constants.dart';

class PlayListHeadingWidget extends StatelessWidget {
  final String title;
  final String imgPath;

  const PlayListHeadingWidget({
    super.key,
    required this.title,
    required this.imgPath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: 350,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  blurStyle: BlurStyle.inner,
                  color: Colors.transparent,
                  spreadRadius: 5,
                  blurRadius: 10)
            ],
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                imgPath,
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 15, bottom: 15),
              child: Text(
                title,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kcolorblack),
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.play_arrow,
                    color: kcolorblack,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.shuffle,
                    color: kcolorblack,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
