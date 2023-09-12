import 'package:flutter/material.dart';
import 'package:video_player_app/constants.dart';

class ThumbnailMostlyHeadingWidget extends StatelessWidget {


  const ThumbnailMostlyHeadingWidget({
    super.key,
    
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: kColorWhite30, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                fit: BoxFit.fitWidth,
                repeat: ImageRepeat.repeatX,
                image: AssetImage(
                  "assets/images/mostly.png",
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20, top: 15, bottom: 15),
                child: Text(
                  "Mostly Played Videos",
                  style: TextStyle(
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
      ),
    );
  }
}
