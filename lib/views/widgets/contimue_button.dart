import 'package:flutter/material.dart';
import 'package:sterling/constants/color_constant.dart';
import 'package:sterling/constants/text_style.dart';
import 'package:sterling/utilities/extensions/Extensions.dart';

class ContinueBotton extends StatelessWidget {
  ContinueBotton({super.key, required this.onTap});
  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: kPrimaryColor,
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(134, 26, 24, 1),
              Color.fromRGBO(155, 20, 42, 1),
              Color.fromRGBO(193, 9, 75, 1)
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Continue".capitalize(),
              textAlign: TextAlign.center,
              style: codeProHeadStyle.copyWith(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const RotatedBox(
              quarterTurns: 2,
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
