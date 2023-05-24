import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sterling/constants/app_icon_constants.dart';
import 'package:sterling/services/local_db_helper.dart';
import 'package:sterling/views/auth/professional_detail_listing.dart';

import 'auth/signin_page.dart';
import 'bottom_bar.dart';
import 'onboarding/professional_selector_screens.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigateTo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: SvgPicture.asset(AppImages.logo),
      ),
    );
  }

  navigateTo() {
    Future.delayed(const Duration(seconds: 3), () async {
      final isSignup = await LocaldbHelper.isSignUp();
      final cid = await LocaldbHelper.getToken();
      if (isSignup!) {
        // ignore: use_build_context_synchronously
        var user = await fetchbyid(cid);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => (user.isNotEmpty && user[0].status == 1)
                ? BottomBarScreen()
                : ProfessionalDetailListing(
                    pagestate: 0,
                  ),
          ),
        );
      }
      // ignore: use_build_context_synchronously
      else {
        // // ignore: use_build_context_synchronously
        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => const OnBoardingScreen(),
        //     ),
        //     (route) => false);
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const SelectProfessionScreen()),
            (route) => false);
      }
    });
  }
}
