import 'package:flutter/material.dart';

class AppIntroLogo extends StatelessWidget {
  const AppIntroLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
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
