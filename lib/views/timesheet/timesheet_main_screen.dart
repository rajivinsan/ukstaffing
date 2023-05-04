import 'package:flutter/material.dart';
import 'package:sterling/views/timesheet/payment_timesheet.dart';
import 'package:sterling/views/timesheet/timesheet_page.dart';
import 'package:sterling/views/timesheet/unsubmitted_page.dart';

import '../widgets/custom_tab_bar.dart';

class TimeSheetMainScreen extends StatefulWidget {
  const TimeSheetMainScreen({super.key});

  @override
  State<TimeSheetMainScreen> createState() => _TimeSheetMainScreenState();
}

class _TimeSheetMainScreenState extends State<TimeSheetMainScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTabBarView(
      appBarName: "TimeSheets",
      length: 3,
      onTap: (value) {},
      tabWidget: const [UnsubmittedPage(), TimeSheetPage(), PaymentTimeSheet()],
      tabController: _tabController,
      widget: const [
        Text("Unsubmitted"),
        Text(
          "Timesheets",
        ),
        Text("Payments")
      ],
    );
  }
}
