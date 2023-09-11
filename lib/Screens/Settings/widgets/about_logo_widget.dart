import 'package:flutter/material.dart';

class AboutLogoWidget extends StatelessWidget {
  const AboutLogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo.png',
            height: 75,
          ),
          Image.asset(
            'assets/images/title2.png',
            height: 75,
          ),
        ],
      ),
    );
  }
}
