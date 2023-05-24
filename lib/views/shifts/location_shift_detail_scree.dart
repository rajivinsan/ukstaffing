import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sterling/constants/app_constant.dart';
import 'package:sterling/constants/app_icon_constants.dart';
import 'package:sterling/constants/color_constant.dart';
import 'package:sterling/constants/text_style.dart';
import 'package:sterling/utilities/ui/size_config.dart';
import 'package:sterling/views/widgets/common_button.dart';

import '../../models/shifts/shifts_details_model.dart';
import '../../provider/shift_details_provider.dart';
import '../widgets/app_bar_back.dart';
import '../widgets/custom_divider.dart';

class LocationShiftDetailScreen extends ConsumerStatefulWidget {
  const LocationShiftDetailScreen({Key? key, required this.id})
      : super(key: key);
  final int id;
  @override
  ConsumerState<LocationShiftDetailScreen> createState() =>     _LocationShiftDetailScreenState();
}

class _LocationShiftDetailScreenState   extends ConsumerState<LocationShiftDetailScreen> {
  TextStyle subHeadStyle = redHatNormal.copyWith(
      color: klightTextColor, fontSize: 13, letterSpacing: 0.02);
  @override
  Widget build(BuildContext context) {
    final AsyncValue<ShiftDetailModel?> details = ref.watch(
      shiftDetailsProvider(widget.id),
    );
    SizeConfig.init(context);
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: containerBackGroundColor,
              // leading: const AppbarBack(),
              leading: const SizedBox.shrink(),
              leadingWidth: 0,
              title: Row(
                children: [
                  const AppbarBack(),
                  const Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: kPrimaryColor,
                        )),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          SvgAsset.fillHeart,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text("Location",
                            style: redHatMedium.copyWith(
                                color: kPrimaryColor, fontSize: 15)),
                        Container(
                          width: 30,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              pinned: true,
              expandedHeight: SizeConfig.screenHeight! * 0.3,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Text(
                        "Lansbury Court Care Home",
                        style: redHatbold.copyWith(
                            color: Colors.black,
                            fontSize: 36,
                            shadows: textShadow),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          SvgPicture.asset(SvgAsset.days),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "0 available shifts",
                            style: subHeadStyle,
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              SvgPicture.asset(SvgAsset.date),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "data",
                                style: subHeadStyle,
                              ),
                            ],
                          ),
                          const Spacer(),
                          Container(),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_pin,
                            size: 18,
                            color: Color(0xff666666),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "1.0 miles",
                            style: subHeadStyle,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ), //Fl
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Available Shifts",
                  style: redHatMedium.copyWith(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                const CustomDivider(
                  color: Colors.black,
                  width: 25,
                ),
                size10,
                Text(
                  AppConstant.locationDoesnotHaveShifts,
                  textAlign: TextAlign.justify,
                  style: redHatNormal.copyWith(
                    color: klightTextColor,
                    fontSize: 16,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: CommonButton(
                      name: AppConstant.updateNotification, onPressed: () {}),
                ),
                Text(
                  AppConstant.howTofindHome,
                  style: redHatMedium.copyWith(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                const CustomDivider(
                  color: Colors.black,
                  width: 25,
                ),
                size20,
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: const Color(
                      0xffEEE4E3,
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
                              // MapUtils.openMap(data.lat!, data.lon!);
                            }),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
