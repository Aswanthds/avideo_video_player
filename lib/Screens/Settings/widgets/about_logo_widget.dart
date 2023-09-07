import 'package:flutter/material.dart';
class AboutLogoWidget extends StatelessWidget {
  const AboutLogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/logo.png',
          height: 100,
        ),
        Image.asset(
          'assets/images/title2.png',
          height: 100,
        ),
      ],
    );
  }
}
