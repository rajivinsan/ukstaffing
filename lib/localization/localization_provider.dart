import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguageProvider extends ChangeNotifier {
  AppLanguageProvider() {
    fetchLocale();
  }
  String? localeString = "en";
  String? getlocal() => localeString;

  fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      localeString = "en";
      notifyListeners();
      print("new lang fetch $localeString");
      return Null;
    }
    localeString = prefs.getString('language_code');

    notifyListeners();
    print("new lang fetch $localeString");
    return Null;
  }

  Future changeLanguage({@required String? lang}) async {
    var prefs = await SharedPreferences.getInstance();

    if (prefs.getString('language_code') != lang) {
      await prefs.setString('language_code', lang!);
      localeString = lang;
      print("new lang change $lang");
      notifyListeners();
    }
  }
}
