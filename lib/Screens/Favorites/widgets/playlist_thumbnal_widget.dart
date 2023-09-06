import 'package:flutter/material.dart';

class PlayListThumbnailWidget extends StatelessWidget {
  const PlayListThumbnailWidget({
    super.key,
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
                  blurRadius: 10)
            ],
            color: Colors.grey.withOpacity(0.4),
            borderRadius: BorderRadius.circular(20),
            image: const DecorationImage(
              image: AssetImage('assets/images/favourites.png'),
            ),
          ),
        ),
       
      ],
    );
  }
}
