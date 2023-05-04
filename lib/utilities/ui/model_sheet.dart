import 'package:flutter/material.dart';
import 'package:sterling/views/filter/filter_screen.dart';

class OpenModelSheet {
  static openSheet(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const FilterScreen()));
  }
}
