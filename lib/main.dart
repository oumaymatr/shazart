import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SearchTextProvider(),
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
      // Provider.of<SearchText>(context).searchText
    );
  }
}

class SearchTextProvider extends ChangeNotifier {
  String _searchText = '';

  String get searchText => _searchText;

  void setSearchText(String newText) {
    _searchText = newText;
    notifyListeners(); // Notify listeners of the change
  }

  void clearSearchText() {
    _searchText = '';
    notifyListeners(); // Notify listeners of the change
  }
}
