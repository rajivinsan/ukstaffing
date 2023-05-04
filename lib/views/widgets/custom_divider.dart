import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key, required this.color, this.width});
  final Color color;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      width: width ?? 40,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
