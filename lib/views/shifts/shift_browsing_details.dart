import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sterling/models/shifts/shifts_details_model.dart';
import 'package:sterling/models/shifts/shifts_model.dart';
import 'package:sterling/provider/repository_provider.dart';
import 'package:sterling/utilities/extensions/Extensions.dart';
import 'package:sterling/utilities/helpers/location_helper.dart';
import 'package:sterling/utilities/helpers/map_utils.dart';
import 'package:sterling/utilities/ui/MProgressIndicator.dart';
import 'package:sterling/utilities/extensions/date_format_extension.dart';
import 'package:sterling/views/widgets/custom_button.dart';
import '../../constants/app_constant.dart';
import '../../constants/app_icon_constants.dart';
import '../../constants/color_constant.dart';
import '../../constants/text_style.dart';
import '../../provider/shift_details_provider.dart';
import '../../utilities/ui/size_config.dart';
import '../../utilities/ui/utility.dart';
import '../widgets/common_button.dart';
import '../widgets/custom_divider.dart';
import '../widgets/error_screen.dart';
import '../widgets/loading_indicator.dart';

class ShiftBrowsingDetailsScreen extends ConsumerStatefulWidget {
  ShiftBrowsingDetailsScreen(
      {super.key,
      required this.isDayShift,
      this.locdata,
      this.id,
      required this.bookpage});
  final bool isDayShift;
  int? id;
  ShiftsListongModel? locdata;
  final bool bookpage;

  ConsumerState<ShiftBrowsingDetailsScreen> createState() =>
      _ShiftBrowsingDetailsScreenState();
}

class _ShiftBrowsingDetailsScreenState
    extends ConsumerState<ShiftBrowsingDetailsScreen> {
  bool validate = true;
  @override
  Widget build(BuildContext context) {
    final AsyncValue<ShiftDetailModel?> details = ref.watch(
      shiftDetailsProvider(widget.id ?? 0),
    );
    print(details.value);
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
    SizeConfig.init(context);
    var height = SizeConfig.screenHeight!;
    var width = SizeConfig.screenWidth!;

    return details.when(
      data: (data) {
        final date = data!.date?.toString().formatDate;
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
            child: widget.bookpage
                ? CommonButton(
                    name: "Apply now",
                    onPressed: () {
                      MProgressIndicator.show(context);
                      ref
                          .read(shiftRepositoryProvider)
                          .applyToShift(shiftId: details.value!.shiftid!)
                          .then((value) {
                        MProgressIndicator.hide();
                        if (value.success) {
                          "Apply Successfully".showSuccessAlert(context);
                          Navigator.pop(context);
                        } else {
                          "Something Went Wrong".showErrorAlert(context);
                        }
                      });
                    })
                : validate
                    ? CommonButton(
                        name: "Validate",
                        onPressed: () {
                          MProgressIndicator.show(context);
                          getDistanceFromCurrentLocation(data.lat!, data.lon!)
                              .then((v) {
                            //Check Distance in Meters
                            if (v > 00) {
                              // MProgressIndicator.show(context);

                              MProgressIndicator.hide();
                              "Validations Success".showSuccessAlert(context);
                              setState(() {
                                validate = false;
                              });
                            } else {
                              MProgressIndicator.hide();
                              "You not in Working Area".showErrorAlert(context);
                            }
                          });
                        })
                    : data.status != null
                        ? CustomButton(
                            containerColor: Colors.green,
                            text:
                                data.status == 0 ? "End Shift" : "Start Shift",
                            ontap: () async {
                              if (await confirm(context)) {
                                {
                                  // MProgressIndicator.show(context);
                                  ref
                                      .read(shiftRepositoryProvider)
                                      .shiftStatus(
                                          shiftId: details.value!.shiftid!)
                                      .then((value) {
                                    MProgressIndicator.hide();
                                    if (value.success) {
                                      "Shift Apply Successfully"
                                          .showSuccessAlert(context);
                                      Navigator.pop(context);
                                    } else {
                                      "Something Went Wrong"
                                          .showErrorAlert(context);
                                    }
                                  });
                                }
                                return print('pressedOK');
                              }
                              return print('pressedCancel');
                            },
                            textColor: Colors.white,
                          )
                        : TextButton(
                            onPressed: () {},
                            child: Text("Shift Start Date ${data.date}")),
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
                          widget.isDayShift
                              ? AppImages.dayshift
                              : AppImages.nighShift,
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
                              date ?? "5 February",
                              style: whiteSubStyle.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "Time: ${data.shiftTime!.value!.entries.elementAt(2).value.toInt()}:${data.shiftTime!.value!.entries.elementAt(4).value.toInt()}",
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
                                        color: widget.isDayShift
                                            ? const Color(0xffFF7613)
                                            : const Color(0xff581172)),
                                  ),
                                )
                              ],
                            ),
                            const Spacer(),
                            Text(
                              "\$ " + data.price.toString() + "/H",
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
                                  widget.locdata!.company.toString(),
                                  style: redHatMedium.copyWith(fontSize: 20),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: widget.isDayShift
                                      ? const Color(0xffFF7613)
                                      : const Color(0xff581172),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Text(
                                  "${widget.locdata!.distance!.toStringAsFixed(3)} Miles",
                                  style: whiteSubStyle,
                                ),
                              ),
                              Utility.hSize(10),
                              SvgPicture.asset(
                                SvgAsset.forward1,
                                color: widget.isDayShift
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
                      Utility.vSize(10),
                      Text(
                        AppConstant.shiftDetails,
                        style: headStyle,
                      ),
                      CustomDivider(color: kPrimaryColor),
                      Utility.vSize(20),
                      _buldRatingTile(),
                      size20,
                      Utility.vSize(10),
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
                                "${data.address!}" ",${data.postcode}",
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
                                    MapUtils.openMap(data.lat!, data.lon!,
                                        location: "${data.lat}  ${data.lon}");
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

Future<double> getDistanceFromCurrentLocation(double lat, double lng) async {
  // Get current location

  //LocationPermission permission = await Geolocator.requestPermission();

  Position position = await LocationHelper().checkAndGetLocation();

  // Calculate distance between current location and given latitude and longitude
  double distanceInMeters = await Geolocator.distanceBetween(
      position.latitude, position.longitude, lat, lng);

  // Convert distance to kilometers and round to two decimal places
  //double distanceInKm = distanceInMeters / 1000;
  return double.parse(distanceInMeters.toStringAsFixed(2));
}
