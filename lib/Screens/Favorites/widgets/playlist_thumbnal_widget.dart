import 'package:flutter/material.dart';

class PlayListThumbnailWidget extends StatelessWidget {
  final ImageProvider? thumbnailImage; // ImageProvider to display the thumbnail

  const PlayListThumbnailWidget({
    super.key,
    this.thumbnailImage, // Pass the thumbnail image as a parameter
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
                blurRadius: 10,
              )
            ],
            color: Colors.grey.withOpacity(0.4),
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              // Use the passed thumbnailImage as the image source
              image:
                  thumbnailImage ?? AssetImage('assets/images/favourites.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
