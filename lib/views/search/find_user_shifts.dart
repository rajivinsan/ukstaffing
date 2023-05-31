import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sterling/constants/app_icon_constants.dart';
import 'package:sterling/utilities/ui/model_sheet.dart';
import 'package:sterling/views/shifts/shift_browsing_details.dart';
import 'package:sterling/views/viewmodel/home/all_shift_view_model.dart';
import 'package:sterling/views/viewmodel/home/location_shift_view_model.dart';
import 'package:sterling/views/widgets/error_screen.dart';

import '../../constants/color_constant.dart';
import '../../constants/enum.dart';
import '../../constants/text_style.dart';
import '../widgets/Shifts/shifts_card.dart';
import '../widgets/custom_divider.dart';
import '../widgets/shift_card_shimmer.dart';
import '../widgets/slider_dots.dart';

class FindUserShift extends ConsumerStatefulWidget {
  FindUserShift({Key? key, required this.ordertype}) : super(key: key);

  int ordertype;

  @override
  ConsumerState<FindUserShift> createState() => _FindUserShiftState();
}

class _FindUserShiftState extends ConsumerState<FindUserShift> {
  int selectedIndex = 0;
  int totalshift = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //Shfit Datewise
      ref
          .read(locationShiftviewProvider.notifier)
          .getShiftByUserLocartion(type: widget.ordertype);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final recommandedShift = ref.watch(allShiftviewProvider);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row(
            //  children: [
            // Container(
            //   padding:
            //       const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(7),
            //       color: kbluteColor),
            //   child: Row(
            //     children: [
            //       SvgPicture.asset(SvgAsset.sorting),
            //       const SizedBox(
            //         width: 5,
            //       ),
            //       Text(
            //         "Sorting",
            //         style: redHatNormal.copyWith(
            //             fontSize: 14,
            //             color: Colors.white,
            //             shadows: textShadow),
            //       )
            //     ],
            //   ),
            // ),
            const SizedBox(
              width: 10,
            ),
            // InkWell(
            //   onTap: () {
            //     OpenModelSheet.openSheet(context);
            //   },
            //   child: Container(
            //     width: 100,
            //     padding: const EdgeInsets.symmetric(
            //         horizontal: 10, vertical: 10),
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(7),
            //         color: kbluteColor),
            //     child: Row(
            //       children: [
            //         SvgPicture.asset(SvgAsset.filter),
            //         Text(
            //           "Filter",
            //           style: redHatNormal.copyWith(
            //               fontSize: 14,
            //               color: Colors.white,
            //               shadows: textShadow),
            //         )
            //       ],
            //     ),
            //  ),
            //),
            // ],
            //),
            size20,
            // Text(
            //   "There are ${recommandedShift.data != null ? recommandedShift.data!.length : 0}  shifts in your area.",
            //   style: sourceCodeProStyle.copyWith(fontSize: 13),
            // ),
            Text(
              widget.ordertype == 2
                  ? "Date wise shifts"
                  : "Distance wise shifts",
              style: redHatMedium.copyWith(color: Colors.black, fontSize: 22),
            ),
            const CustomDivider(color: Colors.black),
            size20,
            //_buildRecommandedShift(context),
            _buildAllAvailableShift(),
            recommandedShift.data == null || recommandedShift.data!.isEmpty
                ? const SizedBox()
                : Row(
                    children: [
                      for (int i = 0; i < recommandedShift.data!.length; i++)
                        SlideDots(
                          isActive: selectedIndex == i,
                        ),
                    ],
                  ),
            // Text(
            //   "All available shifts (Date Wise)",
            //   style: redHatMedium.copyWith(color: Colors.black, fontSize: 22),
            // ),
            // const CustomDivider(color: Colors.black),
            // size20,
            // recommandedShift.data == null || recommandedShift.data!.isEmpty
            //     ? const SizedBox()
            //     : _buildAllAvailableShift()
          ],
        ),
      ),
    );
  }

  Widget _buildAllAvailableShift() {
    final recommandedShift = ref.watch(locationShiftviewProvider);

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
                              bookpage: true,
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

  Widget _buildRecommandedShift(BuildContext context) {
    final recommandedShift = ref.watch(locationShiftviewProvider);

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
            ? RefreshIndicator(
                onRefresh: () async {
                  ref
                      .read(locationShiftviewProvider.notifier)
                      .getShiftByUserLocartion(type: widget.ordertype);
                  totalshift = recommandedShift.data!.length + 1;
                },
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.30,
                  child: PageView.builder(
                    controller: PageController(
                      viewportFraction: 0.9,
                      initialPage: 0,
                    ),
                    //  padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    //   physics: const NeverScrollableScrollPhysics(),
                    itemCount: recommandedShift.data!.length,
                    onPageChanged: (va) {
                      setState(() {
                        selectedIndex = va;
                      });
                    },

                    //  shrinkWrap: true,
                    itemBuilder: (context, index) => Stack(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ShiftBrowsingDetailsScreen(
                                  locdata: recommandedShift.data![index],
                                  bookpage: true,
                                  isDayShift: index % 2 == 0,
                                  id: recommandedShift.data![index].shiftid,
                                ),
                              ),
                            );
                          },
                          child: ShiftsCard(
                            data: recommandedShift.data![index],
                          ),
                        ),
                        size20,
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
