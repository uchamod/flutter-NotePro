import 'package:flutter/material.dart';
//defining all the color properties in the app
class AppColors {
  //primary color
  static const Color kcBackgroundBlackColor = Color.fromARGB(255, 28, 27, 27);
  static const Color kcCardBlackColor = Color.fromARGB(255, 53, 52, 52);
  static const Color kcTextWhiteColor = Color(0xffF4F4F4);
  static final Color kcTextWhiteColorShadow = const Color(0xffEDEDED).withOpacity(0.6);
  
  static const Color kcTickRedColor = Color(0xffA10B0B);
  static const Color kcTickGreenColor = Color(0xff049424);
  static const Color kcButtonPurpleColor = Color(0xff3E3D3D);
  static const Color readmoreblue = Color( 0xff219EE4);

  //gradient colors
  static const int gradientStart = 0xff219EE4;
  static const int gradientEnd = 0xff024A9F;


  static const LinearGradient progressCircleGradient =  LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(gradientStart),
      Color(gradientEnd),
    ],
  );
}
