import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sterling/constants/color_constant.dart';
import 'package:sterling/constants/text_style.dart';
import 'package:sterling/models/shifts/shifts_model.dart';
import 'package:sterling/views/widgets/Shifts/shifts_card.dart';

import '../../constants/app_icon_constants.dart';
import '../../utilities/ui/model_sheet.dart';
import '../shifts/shift_browsing_details.dart';

class InviteShifts extends StatefulWidget {
  const InviteShifts({Key? key}) : super(key: key);

  @override
  State<InviteShifts> createState() => _InviteShiftsState();
}

class _InviteShiftsState extends State<InviteShifts> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 100,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: kbluteColor),
                  child: Row(
                    children: [
                      SvgPicture.asset(SvgAsset.sorting),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Sorting",
                        style: redHatNormal.copyWith(
                            fontSize: 14,
                            color: Colors.white,
                            shadows: textShadow),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    OpenModelSheet.openSheet(context);
                  },
                  child: Container(
                    width: 100,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: kbluteColor),
                    child: Row(
                      children: [
                        SvgPicture.asset(SvgAsset.filter),
                        Text(
                          "Filter",
                          style: redHatNormal.copyWith(
                            fontSize: 14,
                            color: Colors.white,
                            shadows: textShadow,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            size20,
            size20,
            Text(
              "Missed and dismissed invitations",
              style: redHatMedium,
            ),
            size10,
            Text(
              "These are your missed and dismissed invitations in the last 72 hours.",
              style: redHatNormal,
            ),
            size20,
            ListView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              shrinkWrap: true,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShiftBrowsingDetailsScreen(
                          bookpage: false,
                          isDayShift: index % 2 == 0,
                        ),
                      ),
                    );
                  },
                  child: ShiftsCard(
                    data: ShiftsListongModel(),
                    // linearColor: index % 2 == 0 ? Colors.black : kYellowColor,
                    // isUpcomming: index % 2 == 0 ? true : false,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
