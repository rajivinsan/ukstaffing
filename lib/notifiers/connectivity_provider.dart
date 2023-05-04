import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:io';

class ConnectivityProvider with ChangeNotifier {
  Future<bool> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  bool internet = true;

  Future<bool> verifyInternet() async {
    await checkInternet().then((newInternet) {
      internet = newInternet;
    });
    return internet;
  }
}
