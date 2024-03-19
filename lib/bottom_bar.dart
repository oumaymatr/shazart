import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'history.dart';
import 'forum.dart';
import 'model.dart';
import 'home.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 0;
  final screens = [
    Home(selectedIndex: 0),
    Home(selectedIndex: 1),
    const Model(),
    const Forum(),
    const History()
  ];
  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const Icon(Icons.home_rounded, size: 30),
      const Icon(Icons.search, size: 30),
      const Icon(Icons.insert_photo_outlined, size: 30),
      const Icon(Icons.chat_bubble_outline_outlined, size: 27),
      const Icon(Icons.history_rounded, size: 30),
    ];
    return SafeArea(
      top: false,
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.red,
        body: screens[index],
        bottomNavigationBar: CurvedNavigationBar(
          key: navigationKey,
          backgroundColor: Colors.transparent,
          height: 60,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(microseconds: 300),
          index: index,
          items: items,
          onTap: (index) => setState(() {
            this.index = index;
          }),
        ),
      ),
    );
  }
}
