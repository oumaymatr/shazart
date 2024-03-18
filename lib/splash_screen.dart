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
    return Stack(children: [
      Image.asset(
        'assets/images/background-splash.png',
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
      FlutterSplashScreen.gif(
        useImmersiveMode: true,
        gifPath: 'assets/images/frida-splash.gif',
        gifWidth: 269,
        gifHeight: 474,
        nextScreen: const Welcome(),
        duration: const Duration(milliseconds: 10000),
        backgroundColor: Color(0xFFE3E3E2),
      ),
    ]);
    // return FlutterSplashScreen.fadeIn(
    //   backgroundColor: Colors.white,
    //   onInit: () {
    //     debugPrint("On Init");
    //   },
    //   onEnd: () {
    //     debugPrint("On End");
    //   },
    //   childWidget: SizedBox(
    //     height: 200,
    //     width: 200,
    //     child: Image.asset("assets/images/frida.jpg"),
    //   ),
    //   onAnimationEnd: () => debugPrint("On Fade In End"),
    //   nextScreen: const Welcome(),
    // );
  }
}
