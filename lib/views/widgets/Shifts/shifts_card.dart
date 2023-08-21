import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sterling/constants/app_icon_constants.dart';
import 'package:sterling/constants/text_style.dart';
import 'package:sterling/models/shifts/shifts_model.dart';
import 'package:sterling/utilities/extensions/date_format_extension.dart';
import 'package:sterling/utilities/ui/size_config.dart';
import 'package:sterling/utilities/ui/utility.dart';

import '../../../constants/color_constant.dart';
import '../shadow_container.dart';

class ShiftsCard extends StatelessWidget {
  const ShiftsCard({super.key, required this.data});
  final ShiftsListongModel data;
  @override
  Widget build(BuildContext context) {
    String? date;
    if (data.date != null) {
      date = data.date?.toString().formatDate;
      //print(date);
    }

    TextStyle style = sourceCodeProStyle.copyWith(
      fontSize: 10,
      color: const Color.fromRGBO(
        0,
        0,
        0,
        0.71,
      ),
    );
    SizeConfig.init(context);
    var height = SizeConfig.screenHeight;
    return data != null
        ? ShadowContainer(
            height: height! * 0.23,
            radius: 21,
            color: kCardColor,
            borderColor: const Color.fromRGBO(0, 0, 0, 0.1),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.bookmark_border,
                      color: kbluteColor,
                    ),
                  ),
                  Utility.vSize(2),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: SvgPicture.asset(SvgAsset.slack),
                      ),
                      Utility.hSize(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.company ?? "Hallgarth Care Home",
                              style: redHatMedium.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                letterSpacing: 0.2,
                              ),
                            ),
                            size10,
                            Text(
                              "${data.distance!.toStringAsFixed(3)} Miles",
                              style: redHatNormal.copyWith(
                                color: klightTextColor,
                                letterSpacing: 0.02,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            data.price == null ? "\$14" : "\€${data.price}",
                            style: sourceCodeProStyle.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange,
                              fontSize: 12,
                            ),
                          ),
                          size10,
                          Text(
                            date ?? "Jun 16, 2021",
                            style: sourceCodeProStyle.copyWith(
                                color: kbluteColor, fontSize: 11),
                          )
                        ],
                      ),
                    ],
                  ),
                  size20,
                  Container(
                    color: Colors.black,
                    height: 1,
                  ),
                  size20,
                  Row(
                    children: [
                      SvgPicture.asset(SvgAsset.mouse),
                      Utility.hSize(5),
                      Text("${data.noCandidate ?? 0} applicants", style: style),
                      const Spacer(),
                      SvgPicture.asset(SvgAsset.location),
                      Utility.hSize(5),
                      Text(
                        data.city ?? "Manchester",
                        style: style,
                      ),
                      const Spacer(),
                      SvgPicture.asset(
                        SvgAsset.time,
                      ),
                      Utility.hSize(
                        5,
                      ),
                      Text(
                        data.shiftTime == null
                            ? ""
                            : "${data.shiftTime!.value!.entries.elementAt(2).value.toInt().toString().padLeft(2, '0')}:${data.shiftTime!.value!.entries.elementAt(4).value.toInt().toString().padLeft(2, '0')}",
                        style: style,
                      ),
                      Text(" - "),
                      Text(
                        data.endTime == null
                            ? "20:00-08:00"
                            : "${data.endTime!.value!.entries.elementAt(2).value.toInt().toString().padLeft(2, '0')}:${data.endTime!.value!.entries.elementAt(4).value.toInt().toString().padLeft(2, '0')}",
                        style: style,
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        : Container();
  }

  Container _statusButton({required String name, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: color,
      ),
      child: Text(
        name.toUpperCase(),
        textAlign: TextAlign.center,
        style: sourceCodeProStyle.copyWith(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
