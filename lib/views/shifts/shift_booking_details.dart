import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sterling/constants/app_constant.dart';
import 'package:sterling/constants/app_icon_constants.dart';
import 'package:sterling/constants/color_constant.dart';
import 'package:sterling/constants/text_style.dart';
import 'package:sterling/utilities/extensions/date_format_extension.dart';
import 'package:sterling/utilities/helpers/add_shift_in_calender.dart';
import 'package:sterling/utilities/ui/size_config.dart';
import 'package:sterling/views/widgets/common_button.dart';
import 'package:sterling/views/widgets/custom_divider.dart';

import '../../models/shifts/shifts_details_model.dart';
import '../../provider/shift_details_provider.dart';
import '../../utilities/ui/utility.dart';
import '../widgets/error_screen.dart';
import '../widgets/loading_indicator.dart';

class ShiftBookingDetailScreen extends ConsumerWidget {
  const ShiftBookingDetailScreen(
      {super.key,
      required this.isDayShift,
      required this.shiftId,
      required this.date,
      required this.location});
  final bool isDayShift;
  final int shiftId;
  final String location;
  final String date;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextStyle whiteSubStyle = redHatNormal.copyWith(
      color: Colors.white,
      fontSize: 16,
    );
    TextStyle whiteheadStyle = redHatMedium.copyWith(
      color: Colors.white,
      fontSize: 24,
    );
    TextStyle headStyle = redHatMedium.copyWith(
        fontSize: 23, color: const Color(0xff333333), shadows: textShadow);
    TextStyle subheadStyle = redHatNormal.copyWith(
      fontSize: 18,
      color: const Color(0xff333333),
    );
    final AsyncValue<ShiftDetailModel?> details = ref.watch(
      shiftDetailsProvider(shiftId),
    );
    SizeConfig.init(context);

    var height = SizeConfig.screenHeight!;
    var width = SizeConfig.screenWidth!;
    return details.when(
      data: (data) {
        final shiftdate = data!.date?.toString().formatDate;
        return Scaffold(
          bottomSheet: Container(
            width: width,
            padding:
                const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
            decoration: BoxDecoration(
              color: containerBackGroundColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
            child: CommonButton(
                name: "Add to calender",
                onPressed: () {
                  AddShiftInCalender.addInCalender(
                    title: data.company.toString(),
                    description: data.category.toString(),
                    location: data.city ?? "Manchester",
                    startDate: DateTime.parse(date),
                    endDate: DateTime.parse(date),
                  );
                }),
          ),
          body: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Container(
                  height: height * 0.34,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          isDayShift ? AppImages.dayshift : AppImages.nighShift,
                        ),
                        fit: BoxFit.cover),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.black),
                            ),
                            child: RotatedBox(
                              quarterTurns: 2,
                              child: SvgPicture.asset(
                                SvgAsset.forward1,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Utility.vSize(height * 0.01),
                        Row(
                          children: [
                            Text(
                              shiftdate ?? "5 February",
                              style: whiteSubStyle.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "20 : 00 - 08 : 00",
                              style: whiteSubStyle,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Night Shift",
                                  style: whiteheadStyle,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 14),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white),
                                  child: Text(
                                    "PAY",
                                    style: codeProHeadStyle.copyWith(
                                        fontSize: 14,
                                        color: isDayShift
                                            ? const Color(0xffFF7613)
                                            : const Color(0xff581172)),
                                  ),
                                )
                              ],
                            ),
                            const Spacer(),
                            Text(
                              "£ ${data.price.toString()}/ H",
                              style: whiteSubStyle,
                            )
                          ],
                        ),
                        const Spacer(),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          width: width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 4,
                                  spreadRadius: 0,
                                  offset: Offset(0, 4),
                                  color: Color.fromRGBO(
                                    0,
                                    0,
                                    0,
                                    0.25,
                                  ),
                                ),
                              ]),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Hallgarth Care \nHome",
                                  style: redHatMedium.copyWith(fontSize: 20),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: isDayShift
                                      ? const Color(0xffFF7613)
                                      : const Color(0xff581172),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Text(
                                  "11.4 MILES",
                                  style: whiteSubStyle,
                                ),
                              ),
                              Utility.hSize(10),
                              SvgPicture.asset(
                                SvgAsset.forward1,
                                color: isDayShift
                                    ? const Color(0xffFF7613)
                                    : const Color(0xff581172),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Utility.vSize(20),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        width: width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: kPrimaryColor, width: 2),
                        ),
                        child: Text(
                          "Show my vaccine evidence",
                          style: redHatMedium.copyWith(
                            color: klightTextColor,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Utility.vSize(20),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: const Color(
                              0xffFFF1C0,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Safety guidelines for this shift",
                              style: headStyle,
                            ),
                            CustomDivider(color: kPrimaryColor),
                            Utility.vSize(20),
                            Text(
                              '''1. Uniform: You must wear suitable uniform and footwear (plain tunic, black trousers & closed toe shoes), along with your ID badge.

2. Be on time: Ensure you arrive in good time to change into your uniform and are ready to start at the shift start time, in some homes you may also be asked to do an LFT on arrival.

3. Vaccination: Where applicable please provide your proof of vaccine/exemption. This can be uploaded and accessed via the app.

It is essential you follow this guidance to keep yourself, care homes and residents safe.

Thank you for your hard work, if you have any concerns please get in touch.
''',
                              style: subheadStyle,
                            )
                          ],
                        ),
                      ),
                      Utility.vSize(10),
                      Text(
                        AppConstant.shiftDetails,
                        style: headStyle,
                      ),
                      CustomDivider(color: kPrimaryColor),
                      size10,
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        width: width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                              color: const Color(0xff05FF00), width: 2),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 4),
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff05FF00),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xff05FF00),
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              "You’re working this shift",
                              style: redHatMedium.copyWith(
                                color: klightTextColor,
                                fontSize: 18,
                              ),
                            ),
                            Container(),
                          ],
                        ),
                      ),
                      size20,
                      Text(
                        AppConstant.unitName,
                        style: headStyle,
                      ),
                      CustomDivider(color: kPrimaryColor),
                      size10,
                      Text(
                        "Job card 1",
                        style: subheadStyle,
                      ),
                      size20,
                      Text(
                        AppConstant.aboutHome,
                        style: headStyle,
                      ),
                      CustomDivider(color: kPrimaryColor),
                      size10,
                      Text(
                        '''- Number of residents: 56 (current number);

- Number of carers in the day: 8 - Number of
 carers in the night: 5

- Senior Carer on shift?: 2

- Parking Availability: yes

- Nearest Train/Bus Station: Ilkeston

- Emergency Contact Details: 0115 944 4545
 (Care Home Landline)

- Use Electronic Mars Sheet (EMARS)?:No''',
                        style: subheadStyle,
                      ),
                      size20,
                      Text(
                        AppConstant.shiftAttribute,
                        style: headStyle,
                      ),
                      CustomDivider(color: kPrimaryColor),
                      size10,
                      Row(
                        children: [
                          Text(
                            "Parking on site available",
                            style: subheadStyle,
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: kPrimaryColor, width: 3),
                            ),
                            child: Text(
                              "P",
                              style: redHatbold.copyWith(
                                  fontSize: 13, color: kPrimaryColor),
                            ),
                          )
                        ],
                      ),
                      size10,
                      Row(
                        children: [
                          Text(
                            "Number of beds",
                            style: subheadStyle,
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: kPrimaryColor, width: 3),
                            ),
                            child: Text(
                              "16",
                              style: redHatbold.copyWith(
                                  fontSize: 13, color: kPrimaryColor),
                            ),
                          )
                        ],
                      ),
                      size20,
                      Text(
                        AppConstant.rating,
                        style: headStyle,
                      ),
                      CustomDivider(color: kPrimaryColor),
                      size10,
                      Text(
                        "The information below shows the ratings other workers have given to the home.",
                        style: subheadStyle,
                      ),
                      size20,
                      _buldRatingTile(),
                      size20,
                      Text(
                        AppConstant.realibality,
                        style: headStyle,
                      ),
                      CustomDivider(color: kPrimaryColor),
                      size10,
                      Text(
                        "Data for shifts cancelled by Bramble Lodge Residential & Dementia Care Home with less  than 48 hours notice",
                        style: subheadStyle,
                      ),
                      size20,
                      _buldReliableTile(),
                      size20,
                      Text(
                        AppConstant.howTofindHome,
                        style: headStyle,
                      ),
                      CustomDivider(color: kPrimaryColor),
                      size10,
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: const Color(
                            0xffffafaf,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  AppImages.locImage,
                                )),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                "Parkhouse Avenue , \nCastletown , Sunderland , SR5 3DF",
                                style: redHatNormal.copyWith(
                                  color: klightTextColor,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, bottom: 5),
                              child: CommonButton(
                                  name: "Get Direction",
                                  onPressed: () {
                                    // MapUtils.openMap(d, longitude)
                                  }),
                            )
                          ],
                        ),
                      ),
                      size20,
                      SizedBox(
                        height: height * 0.1,
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
        );
      },
      error: (error, _) => ErrorScreen(error: error.toString()),
      loading: () => const Scaffold(
        body: Center(
          child: LoadingIndicator(),
        ),
      ),
    );
  }

  Widget _buldRatingTile() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: containerBackGroundColor,
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 4,
              spreadRadius: 0,
              color: Color.fromRGBO(
                0,
                0,
                0,
                0.25,
              ),
            ),
          ]),
      child: Row(
        children: [
          Text(
            "Safety",
            style: redHatNormal.copyWith(
              fontSize: 18,
              color: const Color(0xff333333),
            ),
          ),
          const Spacer(),
          Text(
            "2/5",
            style: redHatNormal.copyWith(
              fontSize: 18,
              color: const Color(0xff333333),
            ),
          )
        ],
      ),
    );
  }

  Widget _buldReliableTile() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black),
          boxShadow: const []),
      child: Row(
        children: [
          Text(
            "Shift Booked",
            style: redHatMedium.copyWith(
              fontSize: 18,
              color: const Color(0xff333333),
            ),
          ),
          const Spacer(),
          Text(
            "5",
            style: redHatMedium.copyWith(
              fontSize: 18,
              color: const Color(0xff333333),
            ),
          )
        ],
      ),
    );
  }
}
