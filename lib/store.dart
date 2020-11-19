import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppProvider with ChangeNotifier {
  String _input;
  ByteData _imgBytes;

  String get input => _input;
  ByteData get imgBytes => _imgBytes;

  void setInput(String input) {
    _input = input;
    notifyListeners();
  }

  void setImgBytes(ByteData imgBytes) {
    _imgBytes = imgBytes;
    notifyListeners();
  }
}
