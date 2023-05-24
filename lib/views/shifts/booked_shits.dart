import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sterling/views/shifts/shift_browsing_details.dart';
import 'package:sterling/views/viewmodel/user_own_shift_view_model.dart';
import 'package:sterling/views/widgets/Shifts/shifts_card.dart';

import '../../constants/enum.dart';
import '../widgets/shift_card_shimmer.dart';
import 'shift_booking_details.dart';

class BookedUserShifts extends ConsumerStatefulWidget {
  const BookedUserShifts({Key? key}) : super(key: key);

  @override
  ConsumerState<BookedUserShifts> createState() => _BookedUserShiftsState();
}

class _BookedUserShiftsState extends ConsumerState<BookedUserShifts> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //Shfit Datewise
      ref.read(userOwnShiftProvider.notifier).userBookingShift();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final upcomingShif = ref.watch(userOwnShiftProvider);

    switch (upcomingShif.status) {
      case Status.loadMore:
        return Container();
      case Status.error:
        return Container();

      case Status.loading:
        return const ShiftCardShimmer(
          length: 6,
        );

      case Status.success:
        return upcomingShif.data!.isNotEmpty
            ? RefreshIndicator(
                onRefresh: () async {
                  ref.read(userOwnShiftProvider.notifier).userBookingShift();
                },
                child: ListView.builder(
                  itemCount: upcomingShif.data!.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ShiftBrowsingDetailsScreen(
                                      isDayShift: index % 2 == 0,

                                      id: upcomingShif.data![index].shiftid!,
                                      locdata: upcomingShif.data![index],
                                      bookpage: false,
                                      //location: upcomingShif.data![index].category ?? "",
                                      //date: upcomingShif.data![index].date.toString()),
                                    )),
                          );
                        },
                        child: ShiftsCard(
                          data: upcomingShif.data![index],
                        )),
                  ),
                ),
              )
            : const Center(
                child: Text("You Don't have any booked shift"),
              );

      case Status.referesh:
        return Container();
      default:
        return Container();
    }
  }
}
