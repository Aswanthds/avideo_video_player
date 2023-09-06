import 'package:flutter/material.dart';

class FolderTab extends StatelessWidget {
  final String foldername;
  final IconData icon;

  const FolderTab({
    super.key,
    required this.foldername,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(foldername),
          ),
        ],
      ),
    );
  }
}