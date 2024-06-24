import 'package:flutter/material.dart';
//defining all the color properties in the app
class AppColors {
  //primary color
  static const Color kcBackgroundBlackColor = Color(0xff090909);
  static const Color kcCardBlackColor = Color(0xff222222);
  static const Color kcTextWhiteColor = Color(0xffEDEDED);
  static final Color kcTextWhiteColorShadow = const Color(0xffEDEDED).withOpacity(0.5);
  
  static const Color kcTickRedColor = Color(0xffA10B0B);
  static const Color kcTickGreenColor = Color(0xff049424);
  static const Color kcButtonPurpleColor = Color(0xffDC1CE0);

  //gradient colors
  static const int gradientStart = 0xff29AEF8;
  static const int gradientEnd = 0xff0562CF;

  final LinearGradient progressCircleGradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(gradientStart),
      Color(gradientEnd),
    ],
  );
}
