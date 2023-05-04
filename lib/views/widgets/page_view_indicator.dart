import 'package:flutter/material.dart';
import 'package:sterling/constants/color_constant.dart';
import 'package:sterling/constants/text_style.dart';

class Indicator extends StatelessWidget {
  const Indicator(
      {super.key, this.isActivate, this.currentIndex, this.totalPage});
  final bool? isActivate;
  final int? currentIndex;
  final int? totalPage;
  @override
  Widget build(BuildContext context) {
    int current = currentIndex! + 1;
    return Stack(
      children: [
        isActivate!
            ? AnimatedContainer(
                alignment: Alignment.center,
                height: 30,
                width: 35,
                duration: const Duration(milliseconds: 50),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.8),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  "",
                  style: sourceCodeProStyle.copyWith(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : AnimatedContainer(
                margin: const EdgeInsets.only(right: 5),
                duration: const Duration(microseconds: 50),
                height: 20,
                width: 30,
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
      ],
    );
  }
}
