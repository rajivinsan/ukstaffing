import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:sterling/utilities/ui/EdgeAlert.dart';

extension JSON on String {
  dynamic fromJson(Map json) {
    return json[this];
  }

  showErrorAlert(BuildContext context) {
    EdgeAlert.show(context,
        description: this,
        gravity: EdgeAlert.BOTTOM,
        backgroundColor: Colors.redAccent);
  }

  showSuccessAlert(BuildContext context) {
    EdgeAlert.show(context,
        description: this,
        gravity: EdgeAlert.BOTTOM,
        backgroundColor: Colors.green);
  }

  showInfoAlert(BuildContext context) {
    EdgeAlert.show(context,
        description: this,
        gravity: EdgeAlert.BOTTOM,
        backgroundColor: Colors.blueGrey);
  }

  bool isEmail() {
    RegExp regExp = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return regExp.hasMatch(this);
  }

  bool isValidLength(int size) {
    return trim().length > size;
  }

  bool isOTP(int size) {
    return trim().length == size;
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  DateTime getLocalTime() {
    //var strToDateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateUtc.toString(),true).toLocal();
    return DateFormat("yyyy-MM-dd HH:mm:ss").parse(this, true).toLocal();
  }
}
