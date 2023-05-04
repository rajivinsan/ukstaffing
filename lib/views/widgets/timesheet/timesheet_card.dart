import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sterling/constants/text_style.dart';

import '../../../constants/color_constant.dart';
import '../../../utilities/ui/size_config.dart';
import '../shadow_container.dart';

class TimeSheetCard extends StatelessWidget {
  const TimeSheetCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    var height = SizeConfig.screenHeight;
    return ShadowContainer(
      height: height! * 0.12,
      color: containerBackGroundColor,
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            width: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: kGreenColor),
            child: Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(4),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kGreenColor,
                ),
                padding: const EdgeInsets.all(2),
                child: const Icon(
                  FontAwesomeIcons.check,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hallgarth Care Home",
                  style: redHatMedium,
                ),
                Text(
                  "Approved",
                  style: redHatNormal,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
