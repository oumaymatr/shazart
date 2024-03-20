import 'package:flutter/material.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class SearchHistoryProvider extends ChangeNotifier {
  List<SearchHistory> _searchHistoryList = [];

  List<SearchHistory> get searchHistoryList => _searchHistoryList;

  void addToSearchHistory(SearchHistory searchHistory) {
    _searchHistoryList.add(searchHistory);
    notifyListeners();
  }
}

class SearchHistory {
  final File image;
  final String artistName;
  final String date;

  SearchHistory({
    required this.image,
    required this.artistName,
    required DateTime dateTime,
  }) : date = DateFormat('HH:mm-dd/MM/yyyy').format(dateTime);
}
