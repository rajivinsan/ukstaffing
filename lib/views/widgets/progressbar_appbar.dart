import 'package:flutter/material.dart';
import 'package:sterling/constants/color_constant.dart';
import 'package:sterling/constants/text_style.dart';

class AppBarProgress extends StatelessWidget implements PreferredSizeWidget {
  const AppBarProgress({super.key, required this.name, required this.progress});
  final String name;

  final double progress;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: KAppbarbackgroundColor,
      leading: const BackButton(
        color: Colors.black,
      ),
      title: Text(
        name,
        style: codeProHeadStyle.copyWith(
          fontSize: 18,
          color: kPrimaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
