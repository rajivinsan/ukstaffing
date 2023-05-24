import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sterling/constants/enum.dart';
import 'package:sterling/views/viewmodel/user_own_shift_view_model.dart';
import 'package:sterling/views/widgets/shift_card_shimmer.dart';

import '../widgets/timesheet/timesheet_card.dart';

class TimeSheetPage extends ConsumerStatefulWidget {
  const TimeSheetPage({
    super.key,
  });

  @override
  ConsumerState<TimeSheetPage> createState() => _TimeSheetPageState();
}

class _TimeSheetPageState extends ConsumerState<TimeSheetPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final timesheet = ref.watch(userTimeSheetProvider);

    switch (timesheet.status) {
      case Status.loadMore:
        return Container();
      case Status.error:
        return Container();

      case Status.loading:
        return const ShiftCardShimmer(
          length: 6,
        );

      case Status.success:
        return timesheet.data!.isNotEmpty
            ? RefreshIndicator(
                onRefresh: () async {
                  ref.read(userTimeSheetProvider.notifier).userTimeSheet();
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.builder(
                    itemCount: timesheet.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: TimeSheetCard(
                          Company: timesheet.data![index].company,
                          Shift_Date: timesheet.data![index].date
                              .toString()
                              .substring(0, 10),
                          User_Spent_Time:
                              "${timesheet.data![index].shiftTime!.value!.entries.elementAt(2).value.toInt()}:${timesheet.data![index].shiftTime!.value!.entries.elementAt(4).value.toInt()}",
                          Pay_Amount: "",
                        )),
                  ),
                ))
            : const Center(
                child: Text("You Don't have any Time Sheet"),
              );

      case Status.referesh:
        return Container();
      default:
        return Container();
    }
  }
}
