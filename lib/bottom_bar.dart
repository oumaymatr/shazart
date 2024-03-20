import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'history.dart';
import 'forum.dart';
import 'model.dart';
import 'home.dart';
import 'components/search_text.dart';

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
      Icon(Icons.home_rounded,
          size: 30, color: index == 0 ? Colors.white : null),
      Icon(Icons.search, size: 30, color: index == 1 ? Colors.white : null),
      Icon(Icons.insert_photo_outlined,
          size: 30, color: index == 2 ? Colors.white : null),
      Icon(Icons.chat_bubble_outline_outlined,
          size: 27, color: index == 3 ? Colors.white : null),
      Icon(Icons.history_rounded,
          size: 30, color: index == 4 ? Colors.white : null),
    ];
    return SafeArea(
      top: false,
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.red,
        body: screens[index],
        bottomNavigationBar: CurvedNavigationBar(
          buttonBackgroundColor: Color(0xFF80B2BE),
          key: navigationKey,
          backgroundColor: Colors.transparent,
          height: 60,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(microseconds: 300),
          index: index,
          items: items,
          onTap: (index) => setState(() {
            this.index = index;
            if (index == 0) {
              Provider.of<SearchTextProvider>(context, listen: false)
                  .clearSearchText();
            }
          }),
        ),
      ),
    );
  }
}
