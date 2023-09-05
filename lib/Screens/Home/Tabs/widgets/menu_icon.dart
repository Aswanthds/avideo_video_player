import 'package:flutter/material.dart';

class MenuIconWidget extends StatelessWidget {
  final String title;

  final IconData icon;

  const MenuIconWidget({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
      child: Column(
        children: [
          CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey,
              child: Center(child: Icon(icon))),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
