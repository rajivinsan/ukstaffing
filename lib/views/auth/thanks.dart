// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sterling/views/onboarding/professional_selector_screens.dart';

class ThankYouPage extends StatefulWidget {
  @override
  State<ThankYouPage> createState() => _ThankYouPageState();
}

Color themeColor = const Color(0xFF43D19E);

class _ThankYouPageState extends State<ThankYouPage> {
  double screenWidth = 600;
  double screenHeight = 400;
  Color textColor = const Color(0xFF32567A);

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                height: 170,
                padding: EdgeInsets.all(35),
                decoration: BoxDecoration(
                  color: themeColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.thumb_up_alt_sharp,
                  color: Colors.white,
                  size: 50,
                )),
            SizedBox(height: screenHeight * 0.1),
            Text(
              "Thank You!",
              style: TextStyle(
                color: themeColor,
                fontWeight: FontWeight.w600,
                fontSize: 36,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              "We will get back you soon",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                fontSize: 17,
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            Text(
              "You request submitted,Please wait for approval. Once approved you will be allowed for avaialable shifts work",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            SizedBox(height: screenHeight * 0.06),
            Flexible(
              child: GestureDetector(
                onTap: () {
                  exit(0);
                },
                child: Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    color: themeColor,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Center(
                    child: Text(
                      "Exit",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
