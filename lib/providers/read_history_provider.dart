import 'package:flutter/material.dart';

class ReadHistoryProvider extends ChangeNotifier {
  final List<String> _readToday = [];

  List<String> get readToday => _readToday;

  void addBook(String title) {
    _readToday.add(title);
    notifyListeners();
  }

  void clearHistory() {
    _readToday.clear();
    notifyListeners();
  }
}

