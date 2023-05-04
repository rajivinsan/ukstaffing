import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sterling/views/viewmodel/user_own_shift_view_model.dart';
import 'package:sterling/views/widgets/Shifts/shifts_card.dart';

import '../../constants/enum.dart';
import '../widgets/shift_card_shimmer.dart';
import 'shift_booking_details.dart';

class BookedUserShifts extends ConsumerWidget {
  const BookedUserShifts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                              builder: (context) => ShiftBookingDetailScreen(
                                  isDayShift: index % 2 == 0,
                                  shiftId: upcomingShif.data![index].shiftid!,
                                  location:
                                      upcomingShif.data![index].category ?? "",
                                  date: upcomingShif.data![index].date
                                      .toString()),
                            ),
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
