// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:video_player_app/widgets/welcome_screen.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // Your splash screen UI
      body: WelcomePage(isFirst: true)
    );
  }
}
