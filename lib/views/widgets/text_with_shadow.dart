import 'package:flutter/material.dart';

import '../../constants/color_constant.dart';
import '../../constants/text_style.dart';

class TextWithShadow extends StatelessWidget {
  const TextWithShadow({
    super.key,
    required this.text,
    this.textColor,
    this.style,
  });
  final String text;
  final TextStyle? style;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.transparent, boxShadow: [
        BoxShadow(
          offset: Offset(0, 4),
          blurRadius: 4,
          color: Color.fromRGBO(
            0,
            0,
            0,
            0.1,
          ),
          spreadRadius: 0,
        ),
      ]),
      child: Text(
        text,
        style: style ??
            redHatMedium.copyWith(
              fontSize: 20,
              color: textColor ?? kPurpleColor,
              shadows: [
                const Shadow(
                  blurRadius: 4.0,
                  color: Color.fromRGBO(
                    0,
                    0,
                    0,
                    0.1,
                  ),
                  offset: Offset(0, 4),
                ),
              ],
            ),
      ),
    );
  }
}
