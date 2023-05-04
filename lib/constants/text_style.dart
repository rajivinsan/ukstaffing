import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sterling/constants/color_constant.dart';
import 'package:sterling/utilities/ui/size_config.dart';

TextStyle sourceCodeProStyle = GoogleFonts.sourceCodePro();
TextStyle sourceSansStyle = GoogleFonts.sourceSansPro();

TextStyle redHatNormal = GoogleFonts.redHatDisplay(
    fontSize: 14, fontWeight: FontWeight.normal, color: klightTextColor);
TextStyle redHatMedium = GoogleFonts.redHatDisplay(
  fontSize: 16,
  fontWeight: FontWeight.w600,
);
TextStyle redHatbold = GoogleFonts.redHatDisplay(
  fontSize: 16,
  fontWeight: FontWeight.w900,
);

SizedBox size20 = SizedBox(height: SizeConfig.screenHeight! * 0.02);
SizedBox size10 = SizedBox(height: SizeConfig.screenHeight! * 0.01);

TextStyle codeProHeadStyle = sourceCodeProStyle.copyWith(
    fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black);

TextStyle signUpHeadStyle = sourceCodeProStyle.copyWith(
    fontWeight: FontWeight.bold, color: Colors.black, fontSize: 24);
TextStyle signUpSubHeadStyle = sourceCodeProStyle.copyWith(
  color: lightTextColor,
  fontSize: 18,
);

TextStyle textFiledLabelStyle =
    sourceCodeProStyle.copyWith(color: Colors.black, fontSize: 16);
List<Shadow> textShadow = [
  const Shadow(
    blurRadius: 4.0,
    color: Color.fromRGBO(
      0,
      0,
      0,
      0.1,
    ),
    offset: Offset(0, 4),
  )
];
