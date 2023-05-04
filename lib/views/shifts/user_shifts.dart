import 'package:flutter/material.dart';
import 'package:sterling/views/shifts/application_shifts.dart';
import 'package:sterling/views/shifts/booked_shits.dart';

import '../widgets/custom_tab_bar.dart';

class UserShifts extends StatefulWidget {
  const UserShifts({super.key});

  @override
  State<UserShifts> createState() => _UserShiftsState();
}

class _UserShiftsState extends State<UserShifts>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTabBarView(
      appBarName: "My Shifts",
      length: 2,
      onTap: (value) {},
      tabWidget: const [BookedUserShifts(), UserApplicationShift()],
      tabController: _tabController,
      widget: const [
        Text("Booked Shifts"),
        Text(
          "Application",
        ),
      ],
    );
  }
}
