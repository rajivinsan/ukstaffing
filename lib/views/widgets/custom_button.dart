import 'package:flutter/material.dart';

import '../../constants/text_style.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      required this.containerColor,
      required this.ontap,
      required this.text,
      required this.textColor});
  final String text;
  final Color textColor;
  final Color containerColor;
  void Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(
            25,
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: redHatMedium.copyWith(
              color: textColor,
              fontSize: 18,
              letterSpacing: 0.02,
              shadows: textShadow),
        ),
      ),
    );
  }
}
