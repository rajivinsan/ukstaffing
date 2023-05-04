import 'package:flutter/material.dart';
import 'package:sterling/constants/app_constant.dart';
import 'package:sterling/constants/color_constant.dart';
import 'package:sterling/constants/text_style.dart';
import 'package:sterling/utilities/ui/size_config.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);
  final double height = 100;
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Container(
      height: SizeConfig.screenHeight! * 0.14,
      margin: const EdgeInsets.only(top: 0),
      padding: const EdgeInsets.only(left: 15, right: 15, top: 40, bottom: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 10),
            color: const Color(0xff939393).withOpacity(0.05),
            blurRadius: 75,
            spreadRadius: 0,
          ),
        ],
        color: const Color(0xFFffffff),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welocme Back",
                style: sourceCodeProStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: darkTextColor,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "User Name",
                style: sourceCodeProStyle.copyWith(
                  color: lightTextColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const Spacer(),
          const CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 30,
            backgroundImage: NetworkImage(
              avtarImage,
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
