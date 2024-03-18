import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'dart:ui';
import 'bottom_bar.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            width: MediaQuery.of(context).size.width * 1.7,
            left: 100,
            bottom: 100,
            child: Image.asset(
              "assets/images/Spline.png",
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 50, sigmaY: 40),
              child: const SizedBox(),
            ),
          ),
          const RiveAnimation.asset("assets/shapes.riv"),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 350,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(600),
                        child: Image.asset("assets/images/frida-welcome.jpg"),
                      ),
                    ),
                    const Text(
                      "SHAZART",
                      style: TextStyle(
                        fontFamily: "ZenOldMincho",
                        fontSize: 50.0,
                        color: Color(0xFF2D2D42),
                      ),
                    ),
                    const Text(
                      "Discover Artists, Dive into Their Stories,",
                      style: TextStyle(
                        // fontFamily: "ZenOldMincho",
                        fontSize: 20.0,
                        // color: Color(0xFF0A2865),
                      ),
                    ),
                    const Text(
                      "and Embrace the Beauty of Art.",
                      style: TextStyle(
                        // fontFamily: "ZenOldMincho",
                        fontSize: 20.0,
                        // color: Color(0xFF0A2865),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BottomBar()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2D2D42),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 20),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.arrow_forward_ios_rounded,
                              color: Colors.white),
                          SizedBox(width: 5),
                          Text(
                            "Start Discovering",
                            style: TextStyle(
                                fontFamily: "ZenOldMincho",
                                fontSize: 20.0,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
