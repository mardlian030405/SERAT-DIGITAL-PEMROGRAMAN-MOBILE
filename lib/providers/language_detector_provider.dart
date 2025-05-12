import 'package:flutter/material.dart';

class LanguageDetectorProvider with ChangeNotifier {
  String _detectedLanguage = '';

  String get detectedLanguage => _detectedLanguage;

  void detectLanguage(String text) {
    if (text.isEmpty) {
      _detectedLanguage = '';
    } else if (RegExp(r'[ꦀ-꧿]').hasMatch(text)) {
      _detectedLanguage = "Aksara Jawa";
    } else if (RegExp(r'[a-zA-Z]').hasMatch(text)) {
      // (Optional) Bisa ditambah cek kata khas Belanda/Jawa/Indonesia
      _detectedLanguage = "Bahasa Latin (Indonesia/Belanda)";
    } else {
      _detectedLanguage = "Bahasa Tidak Diketahui";
    }
    notifyListeners();
  }
}
