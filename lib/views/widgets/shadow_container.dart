import 'package:flutter/material.dart';

class ShadowContainer extends StatelessWidget {
  const ShadowContainer(
      {super.key,
      required this.color,
      required this.child,
      this.borderColor,
      this.radius,
      required this.height});
  final Color color;
  final Widget child;
  final double height;
  final double? radius;
  final Color? borderColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: borderColor ?? color, width: 2),
        borderRadius: BorderRadius.circular(
          radius ?? 15,
        ),
        boxShadow: const [
          BoxShadow(
            offset: Offset(
              0,
              4,
            ),
            color: Color.fromRGBO(
              0,
              0,
              0,
              0.25,
            ),
            blurRadius: 5,
            spreadRadius: 0,
          ),
        ],
      ),
      child: child,
    );
  }
}
