import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomFunctions {
  constantSpace(double variableSize, BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * variableSize,
    );
  }

  // static setSharedPref(String key, String value) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   sharedPreferences.setString(key, value);
  // }

  // static Future<String?> getSharedPref(String key) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   if (sharedPreferences.containsKey(key)) {
  //     return sharedPreferences.getString(key);
  //   }
  // }

  // static removeSelectedSharedPref(String key) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   if (sharedPreferences.containsKey(key)) {
  //     sharedPreferences.remove(key);
  //   }
  // }

  // static removeAllSharedPref() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   sharedPreferences.clear();
  // }
}
