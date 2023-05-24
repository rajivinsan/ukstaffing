import 'package:flutter/material.dart';
import 'package:sterling/views/search/find_user_shifts.dart';
import 'package:sterling/views/search/location_shifts.dart';
import 'package:sterling/views/widgets/custom_tab_bar.dart';

class BrowseShift extends StatefulWidget {
  const BrowseShift({super.key});

  @override
  State<BrowseShift> createState() => _BrowseShiftState();
}

class _BrowseShiftState extends State<BrowseShift>
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
      tabWidget: [
        //2 order by date // 1 order by distance
        FindUserShift(ordertype: 2),
        FindUserShift(ordertype: 1),
        //LocationShifts(),
      ],
      tabController: _tabController,
      widget: const [
        Text("Date wise Shifts"),
        Text(
          "Distance Wise Shift",
        ),
      ],
    );
  }
}
