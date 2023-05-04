import 'package:flutter/material.dart';
import 'package:sterling/constants/color_constant.dart';
import 'package:sterling/utilities/extensions/Extensions.dart';

import '../../constants/text_style.dart';

class CommonButton extends StatelessWidget {
  CommonButton(
      {Key? key, required this.name, required this.onPressed, this.color})
      : super(
          key: key,
        );
  String name;
  Function() onPressed;
  Color? color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: kPrimaryColor,
          gradient: const LinearGradient(
            end: Alignment.centerLeft,
            begin: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(134, 26, 24, 1),
              Color.fromRGBO(155, 20, 42, 1),
              Color.fromRGBO(193, 9, 75, 1)
            ],
          ),
        ),
        child: Text(
          name.capitalize(),
          textAlign: TextAlign.center,
          style: redHatMedium.copyWith(
            fontSize: 22,
            color: Colors.white,
            shadows: textShadow,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
