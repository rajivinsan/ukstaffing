import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sterling/constants/app_icon_constants.dart';
import 'package:sterling/constants/color_constant.dart';
import 'package:sterling/constants/text_style.dart';
import 'package:sterling/views/widgets/shadow_container.dart';

class LocationShiftCard extends StatelessWidget {
  const LocationShiftCard(
      {Key? key, required this.isHeart, required this.shiftsListongModel})
      : super(key: key);
  final bool isHeart;
  final shiftsListongModel;
  @override
  Widget build(BuildContext context) {
    final headStyle = redHatMedium.copyWith(fontSize: 15, letterSpacing: 0.02);
    final subHeadStyle =
        redHatNormal.copyWith(fontSize: 13, color: klightTextColor);
    return ShadowContainer(
      color: kCardColor,
      height: MediaQuery.of(context).size.height * 0.18,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Lansbury Court Care Home",
                  style: headStyle,
                ),
                const SizedBox(
                  width: 10,
                ),
                SvgPicture.asset(
                  isHeart ? SvgAsset.fillHeart : SvgAsset.emptyHeart,
                )
              ],
            ),
            size20,
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: klightTextColor,
                          size: 15,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "11.4 MILES",
                          style: subHeadStyle,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset("assets/images/day.svg"),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "SHIFT POSTED 4 DAYS AGO",
                          style: subHeadStyle,
                        ),
                      ],
                    )
                  ],
                ),
                const Spacer(),
                SvgPicture.asset(SvgAsset.forward)
              ],
            )
          ],
        ),
      ),
    );
  }
}
