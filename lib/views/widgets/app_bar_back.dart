import 'package:flutter/material.dart';
import 'package:sterling/constants/text_style.dart';

class AppbarBack extends StatelessWidget {
  const AppbarBack({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Row(
        children: [
          const Icon(
            Icons.arrow_back,
            color: Color(0xff99879D),
          ),
          const SizedBox(
            width: 0,
          ),
          Text(
            "Back",
            style: redHatMedium.copyWith(
              color: const Color(0xff99879D),
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }
}
