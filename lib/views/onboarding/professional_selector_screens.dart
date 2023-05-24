import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sterling/constants/app_icon_constants.dart';
import 'package:sterling/constants/color_constant.dart';
import 'package:sterling/constants/text_style.dart';
import 'package:sterling/utilities/extensions/Extensions.dart';
import 'package:sterling/utilities/ui/size_config.dart';
import 'package:sterling/views/auth/signin_page.dart';
import 'package:sterling/views/auth/signup_page.dart';

import '../auth/emoloyer_signup.dart';

class SelectProfessionScreen extends StatelessWidget {
  const SelectProfessionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    var height = SizeConfig.screenHeight;
    var width = SizeConfig.screenWidth;
    return _buildBody(height, width, context);
  }

  _buildBody(double? height, double? width, BuildContext context) {
    SizeConfig.init(context);
    return Material(
      child: Stack(
        children: [
          Container(
            height: height! / 1.8,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: kPrimaryColor,
            ),
            child: ClipRRect(
              // make sure we apply clip it properly
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.center,
                    color: Colors.grey.withOpacity(0.1),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 60),
                      child: Image.asset(
                        AppImages.onbaording3,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 20,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )),
              height: height / 1.8,
              width: width,
              child: Column(
                children: [
                  size10,
                  Text(
                    "Welcome \n To Sterling Staffing".capitalize(),
                    style: sourceSansStyle.copyWith(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Text(
                        "Your most trusted staffing service".toUpperCase(),
                        textAlign: TextAlign.center,
                        style: sourceCodeProStyle.copyWith(
                            color: Colors.grey, fontWeight: FontWeight.w700)),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpPage(),
                              ));
                        },
                        child: _buildSelectionCard(
                            title: "Signup As \n Candidate",
                            icon: AppImages.customer),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EmployerSignUp()));
                        },
                        child: _buildSelectionCard(
                            title: "Signup As \nEmployer",
                            icon: AppImages.employer),
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   height: height * 0.02,
                  // ),
                  // CommonButton(
                  //   name: 'Sign Up As Customer',
                  //   onPressed: () {},
                  // ),
                  // SizedBox(
                  //   height: height * 0.02,
                  // ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Center(
              child: RichText(
                  text: TextSpan(
                text: 'Already have an account ?',
                style: sourceCodeProStyle.copyWith(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                children: [
                  const TextSpan(
                    text: ' ',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  TextSpan(
                    text: 'Login',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignInPage()));
                      },
                    style: sourceCodeProStyle.copyWith(
                      color: Colors.blueAccent,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              )),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSelectionCard({required String title, required String icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 55, horizontal: 18),
      margin: const EdgeInsets.only(left: 5, right: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            offset: Offset(-5.01, 5.01),
            blurRadius: 5.01,
            spreadRadius: 0,
            color: Color.fromRGBO(
              155,
              7,
              60,
              0.6,
            ),
          ),
          BoxShadow(
            offset: Offset(-2.51, 2.51),
            blurRadius: 2.51,
            spreadRadius: 0,
            color: Color.fromRGBO(255, 255, 255, 0.6),
          ),
          BoxShadow(
            offset: Offset(5.01, -5.01),
            blurRadius: 5.01,
            spreadRadius: 0,
            color: Color.fromRGBO(255, 255, 255, 0.6),
          ),
          BoxShadow(
            offset: Offset(2.51, -2.51),
            blurRadius: 2.51,
            spreadRadius: 0,
            color: Color.fromRGBO(155, 7, 60, 0.6),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(icon),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: sourceCodeProStyle.copyWith(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
