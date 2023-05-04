import 'package:flutter/material.dart';
import 'package:sterling/constants/app_icon_constants.dart';
import 'package:sterling/constants/text_style.dart';
import 'package:sterling/views/widgets/common_button.dart';
import 'package:sterling/views/widgets/custom_divider.dart';

class UserApplicationShift extends StatefulWidget {
  const UserApplicationShift({Key? key}) : super(key: key);

  @override
  State<UserApplicationShift> createState() => _UserApplicationShiftState();
}

class _UserApplicationShiftState extends State<UserApplicationShift> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                AppImages.shiftCalender,
              ),
            ),
            size10,
            size20,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "You don’t have any upcoming shifts",
                  style: redHatbold.copyWith(
                      color: const Color(
                        0xff666666,
                      ),
                      fontSize: 20,
                      letterSpacing: 0.02),
                ),
                const CustomDivider(color: Colors.black)
              ],
            ),
            size10,
            size20,
            CommonButton(name: "Browse shifts", onPressed: () {})
          ],
        ),
      ),
    );
  }
}
