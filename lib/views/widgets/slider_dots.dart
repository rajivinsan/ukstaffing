import 'package:flutter/material.dart';
import 'package:sterling/constants/color_constant.dart';

class SlideDots extends StatelessWidget {
  final bool isActive;
  const SlideDots({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 3.3),
      height: 8,
      width: isActive ? 28 : 8,
      decoration: BoxDecoration(
        color: isActive ? kPrimaryColor : kCardColor,
        border: isActive
            ? Border.all(
                color: kPrimaryColor,
                width: 2.0,
              )
            : Border.all(
                color: Colors.transparent,
                width: 1,
              ),
        borderRadius: const BorderRadius.all(Radius.circular(26)),
      ),
    );
  }
}
