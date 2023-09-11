import 'package:flutter/material.dart';

class SettingsListWidget extends StatelessWidget {
  final String title;

  final IconData icon;
  final bool hasroute;

  const SettingsListWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.hasroute,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
        ),
        trailing: hasroute
            ? const Icon(
                Icons.arrow_forward_ios,
              )
            : null);
  }
}
