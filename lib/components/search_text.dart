import 'package:flutter/material.dart';

class SearchTextProvider extends ChangeNotifier {
  String _searchText = '';

  String get searchText => _searchText;

  void setSearchText(String newText) {
    _searchText = newText;
    notifyListeners();
  }

  void clearSearchText() {
    _searchText = '';
    notifyListeners();
  }
}
