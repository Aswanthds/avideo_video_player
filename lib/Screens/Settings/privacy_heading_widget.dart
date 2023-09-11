import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PrivacyHeadingWidgget extends StatelessWidget {
  const PrivacyHeadingWidgget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final date = DateTime(2023, 9, 7);
    String formattedMonth = DateFormat('dd-MMM-yyy').format(date);
    return Column(
      children: [
        Center(
          child: Column(
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 100,
              ),
              const SizedBox(height: 20),
              const Text(
                "Privacy Statement",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "Last Updated: $formattedMonth",
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          "The Developer respects your privacy and is committed to protecting your personal information. This Privacy Statement outlines how we handle video content and user data in AVideo video player app",
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
