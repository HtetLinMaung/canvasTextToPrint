import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  String _input;

  String get input => _input;

  void setInput(String input) {
    _input = input;
    notifyListeners();
  }
}
