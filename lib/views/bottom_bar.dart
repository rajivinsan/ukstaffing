import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sterling/constants/color_constant.dart';
import 'package:sterling/constants/text_style.dart';
import 'package:sterling/views/home/dashboard_home_scree.dart';
import 'package:sterling/views/profile/user_profile_screen.dart';
import 'package:sterling/views/search/browse_shifts.dart';
import 'package:sterling/views/shifts/user_shifts.dart';
import 'package:sterling/views/timesheet/timesheet_main_screen.dart';

import '../provider/services_provider.dart';

class BottomBarScreen extends ConsumerWidget {
  BottomBarScreen({Key? key}) : super(key: key);
  final PageController _pageController = PageController();
  // ignore: prefer_final_fields

  final List<Widget> _pages = [
    const HomeDashBoard(),
    const UserShifts(),
    const BrowseShift(),
    const TimeSheetMainScreen(),
    UserProfileScreen()
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int bottomIndex = ref.watch(bottomBarProvider) as int;

    return Scaffold(
        // extendBody: true,
        //   backgroundColor: Colors.white.withOpacity(0.4),
        bottomNavigationBar: Container(
          // MediaQuery.of(context).size.height * 0.15,
          decoration: BoxDecoration(
            color: containerBackGroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
            ),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 4),
                color: Color(0xffdddddd),
                spreadRadius: 0,
                blurRadius: 50,
              ),
            ],
          ),
          child: BottomNavigationBar(
            backgroundColor: containerBackGroundColor,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: kPrimaryColor,
            unselectedItemColor: kPrimaryColor.withOpacity(0.44),
            currentIndex: bottomIndex,
            selectedLabelStyle:
                sourceCodeProStyle.copyWith(color: kPrimaryColor, fontSize: 12),
            unselectedLabelStyle: sourceSansStyle.copyWith(
              color: Colors.black,
              fontSize: 13,
            ),
            items: const [
              BottomNavigationBarItem(
                  tooltip: 'Home',
                  // ignore: deprecated_member_use
                  icon: Icon(FontAwesomeIcons.home),
                  label: 'Upcoming',
                  // ignore: deprecated_member_use
                  activeIcon: Icon(FontAwesomeIcons.home)),
              BottomNavigationBarItem(
                tooltip: 'Home',
                icon: Icon(Icons.calendar_month),
                label: 'My Shifts',
                activeIcon: Icon(Icons.calendar_month),
              ),
              BottomNavigationBarItem(
                tooltip: 'Browse',
                icon: Icon(FontAwesomeIcons.searchengin),
                label: 'Browse',
                activeIcon: Icon(FontAwesomeIcons.searchengin),
              ),
              BottomNavigationBarItem(
                tooltip: 'TimeSheets',
                icon: Icon(FontAwesomeIcons.sheetPlastic),
                label: 'TimeSheets',
                activeIcon: Icon(FontAwesomeIcons.sheetPlastic),
              ),
              BottomNavigationBarItem(
                tooltip: 'My PRofile',
                icon: Icon(FontAwesomeIcons.user),
                label: 'My PRofile',
                activeIcon: Icon(FontAwesomeIcons.user),
              ),
            ],
            onTap: (selectedPageIndex) {
              ref
                  .read(bottomBarProvider.notifier)
                  .chnageIndex(selectedPageIndex);
            },
          ),
        ),
        body: bottomIndex == 0
            ? const HomeDashBoard()
            : bottomIndex == 1
                ? const UserShifts()
                : bottomIndex == 2
                    ? const BrowseShift()
                    : bottomIndex == 3
                        ? const TimeSheetMainScreen()
                        : UserProfileScreen());
  }
}
