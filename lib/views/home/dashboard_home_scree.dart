import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sterling/constants/app_constant.dart';
import 'package:sterling/constants/app_icon_constants.dart';
import 'package:sterling/constants/color_constant.dart';
import 'package:sterling/constants/enum.dart';
import 'package:sterling/constants/text_style.dart';
import 'package:sterling/models/shifts/shifts_model.dart';
import 'package:sterling/services/aws_amplify_services.dart';
import 'package:sterling/utilities/extensions/Extensions.dart';
import 'package:sterling/utilities/helpers/add_shift_in_calender.dart';
import 'package:sterling/utilities/ui/size_config.dart';
import 'package:sterling/views/shifts/shift_browsing_details.dart';
import 'package:sterling/views/viewmodel/home/home_page_view_model.dart';
import 'package:sterling/views/widgets/common_button.dart';
import 'package:sterling/views/widgets/error_screen.dart';
import 'package:sterling/views/widgets/text_with_shadow.dart';

import '../widgets/Shifts/shifts_card.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_divider.dart';
import '../widgets/shift_card_shimmer.dart';

class HomeDashBoard extends ConsumerStatefulWidget {
  const HomeDashBoard({super.key});
  @override
  ConsumerState<HomeDashBoard> createState() => _HomeDashBoardState();
}

class _HomeDashBoardState extends ConsumerState<HomeDashBoard> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //Shfit Datewise
      ref.read(homeviewProvider.notifier).getUpcommingSHift();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    var height = SizeConfig.screenHeight;
    var width = SizeConfig.screenWidth;

    //appBar: const HomeAppBar(),
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            AppImages.dashboard,
            fit: BoxFit.fill,
          ),
          size10,
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                InkWell(
                  onTap: () async {
                    final data = await AwsS3Configuration.getUrl(
                      key: "key",
                    );
                    print(data);
                  },
                  child: const TextWithShadow(
                    text: AppConstant.hereyourLatestUpdate,
                  ),
                ),
                size20,
                // _buildDocsInfo(width),
                size20,
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Upcomming Booked shifts (7 Days)",
                          style: redHatMedium.copyWith(
                              color: Colors.black, fontSize: 20),
                        ),
                        const CustomDivider(color: Colors.black)
                      ],
                    ),
                    Stack(children: <Widget>[
                      Icon(
                        Icons.notifications,
                        color: kbluteColor,
                      ),
                      const Positioned(
                        // draw a red marble
                        top: 0.0,
                        right: 0.0,
                        child: Icon(Icons.brightness_1,
                            size: 8.0, color: Colors.redAccent),
                      )
                    ]),
                  ],
                ),
                const SizedBox(height: 20),
                _buildAllAvailableShift()
              ],
            ),
          ),
          SizedBox(
            height: height! * 0.10,
          )

          // Center(
          //   child: InkWell(
          //     onTap: () {
          //       ref.read(bottomBarProvider.notifier).chnageIndex(1);
          //     },
          //     child: const Text(
          //       "Home Screen",
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

// ignore: dead_code

  Widget _buildAllAvailableShift() {
    final recommandedShift = ref.watch(homeviewProvider);

    switch (recommandedShift.status) {
      case Status.loadMore:
        return Container();
      case Status.error:
        return ErrorScreen(error: recommandedShift.errorMessage);

      case Status.loading:
        return const ShiftCardShimmer(
          length: 1,
        );

      case Status.success:
        return recommandedShift.data!.isNotEmpty
            ? ListView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: recommandedShift.data!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShiftBrowsingDetailsScreen(
                              locdata: recommandedShift.data![index],
                              isDayShift: index % 2 == 0,
                              id: recommandedShift.data![index].shiftid,
                              bookpage: false,
                            ),
                          ),
                        );
                      },
                      child: ShiftsCard(
                        data: recommandedShift.data![index],
                        // linearColor: index % 2 == 0 ? Colors.black : kYellowColor,
                        // isUpcomming: index % 2 == 0 ? true : false,
                      ),
                    ),
                  );
                })
            : const Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text("Sorry !  we don't have any available shift"),
                ),
              );

      case Status.referesh:
        return Container();
      default:
        return Container();
    }
  }

  _buildInvitingShift(BuildContext context) {
    return MediaQuery.removePadding(
      removeBottom: true,
      removeLeft: true,
      context: context,
      child: ListView.builder(
        itemCount: 1,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShiftBrowsingDetailsScreen(
                          bookpage: false, isDayShift: index % 2 == 0)));
            },
            child: ShiftsCard(
              data: ShiftsListongModel(),
            ),
          ),
        ),
      ),
    );
  }

  Container _buildDocsInfo(double? width) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
      width: width!,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            offset: Offset(
              0,
              4,
            ),
            color: Color.fromRGBO(
              0,
              0,
              0,
              0.25,
            ),
            blurRadius: 5,
            spreadRadius: 0,
          )
        ],
        border: Border.all(
          color: kPurpleColor,
          width: 4,
        ),
        borderRadius: BorderRadius.circular(
          15,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppConstant.documentReq,
            style: redHatMedium.copyWith(
              color: Colors.black,
              fontSize: 22,
            ),
          ),
          const CustomDivider(color: Colors.black),
          size10,
          Text(
            AppConstant.profileMissing,
            style: redHatNormal.copyWith(
              fontSize: 15,
            ),
          ),
          size10,
          CustomButton(
            containerColor: kPurpleColor,
            ontap: () {
              // Add2Calendar.addEvent2Cal(AddShiftInCalender.addInCalender());
              // "Even Add".showSuccessAlert(context);
            },
            text: AppConstant.updateMyDocument,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
