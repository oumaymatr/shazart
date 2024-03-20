import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'package:provider/provider.dart';
import 'components/search_text.dart';
import 'components/search_history.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SearchTextProvider()),
        ChangeNotifierProvider(create: (_) => SearchHistoryProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Shazart',
      home: MySplash(),
      debugShowCheckedModeBanner: false,
    );
  }
}
