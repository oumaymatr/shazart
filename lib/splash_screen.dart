import 'package:flutter/material.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'welcome.dart';

class MySplash extends StatefulWidget {
  const MySplash({super.key});

  @override
  State<MySplash> createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.gif(
      useImmersiveMode: true,
      gifPath: 'assets/images/giphy.gif',
      gifWidth: 100,
      gifHeight: 200,
      nextScreen: const Welcome(),
      duration: const Duration(milliseconds: 3000),
      backgroundColor: const Color(0xFFF9F4F3),
    );
  }
}
