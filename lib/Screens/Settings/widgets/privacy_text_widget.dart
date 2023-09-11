import 'package:flutter/material.dart';

class PrivacyTextWidget extends StatelessWidget {
  final String heading;

  final String content;

  const PrivacyTextWidget({
    super.key,
    required this.heading,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          heading,
          textAlign: TextAlign.justify,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          content,
          textAlign: TextAlign.justify,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
