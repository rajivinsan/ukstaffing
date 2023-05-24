import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sterling/constants/app_icon_constants.dart';
import 'package:sterling/constants/color_constant.dart';
import 'package:sterling/constants/text_style.dart';
import 'package:sterling/views/shifts/location_shift_detail_scree.dart';

import '../../constants/enum.dart';
import '../../utilities/ui/model_sheet.dart';
import '../viewmodel/home/location_shift_view_model.dart';
import '../widgets/Shifts/location_shift_card.dart';
import '../widgets/error_screen.dart';
import '../widgets/shift_card_shimmer.dart';

class LocationShifts extends ConsumerStatefulWidget {
  const LocationShifts({super.key});

  @override
  ConsumerState<LocationShifts> createState() => _LocationShiftsState();
}

class _LocationShiftsState extends ConsumerState<LocationShifts> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //Shift Distance Wise
      ref
          .read(locationShiftviewProvider.notifier)
          .getShiftByUserLocartion(type: 1);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final locShift = ref.watch(locationShiftviewProvider);
    switch (locShift.status) {
      case Status.loadMore:
        return Container();
      case Status.error:
        return ErrorScreen(error: locShift.errorMessage);

      case Status.loading:
        return const ShiftCardShimmer(
          length: 10,
        );

      case Status.success:
        return locShift.data!.isNotEmpty
            ? RefreshIndicator(
                onRefresh: () async {
                  // ref.read(recommandedShift.notifier).userBookingShift();
                },
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                      shadows: textShadow),
                                )
                              ],
                            ),
                          ),
                        ),
                        size20,
                        size20,
                        locShift.data!.isEmpty
                            ? const SizedBox.shrink()
                            : Text(
                                "There are currently ${locShift.data!.length.toString()} care locations near you ",
                                style: redHatNormal.copyWith(
                                  color: klightTextColor,
                                  fontSize: 16,
                                  letterSpacing: 0.2,
                                ),
                              ),
                        size10,
                        locShift.data == null || locShift.data!.isEmpty
                            ? const Text("No shifts Found")
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: locShift.data!.length,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LocationShiftDetailScreen(
                                                    id: locShift
                                                        .data![0].shiftid!,
                                                  )));
                                    },
                                    child: LocationShiftCard(
                                      shiftsListongModel: locShift.data![index],
                                      isHeart: index % 2 == 0 ? true : false,
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ))
            : const Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text("You Don't have any recommanded shift"),
                ),
              );

      case Status.referesh:
        return Container();
      default:
        return Container();
    }
  }
}
