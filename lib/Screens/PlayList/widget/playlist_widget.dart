import 'package:flutter/material.dart';

class PlayListWidget extends StatelessWidget {
  final String title;

  const PlayListWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
          ),
        ),
      ),
      title: Text(title),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Color(0xF1003554),
        fill: 0,
      ),
    );
  }
}
