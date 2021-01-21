import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppProvider with ChangeNotifier {
  String _input;
  ByteData _imgBytes;
  Uint8List _imgBytes2;

  String get input => _input;
  ByteData get imgBytes => _imgBytes;
  Uint8List get imgBytes2 => _imgBytes2;

  void setInput(String input) {
    _input = input;
    notifyListeners();
  }

  void setImgBytes(ByteData imgBytes) {
    _imgBytes = imgBytes;
    notifyListeners();
  }

  void setImgBytes2(Uint8List imgBytes) {
    _imgBytes2 = imgBytes;
    notifyListeners();
  }
}
