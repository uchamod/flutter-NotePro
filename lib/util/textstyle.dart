import 'package:flutter/material.dart';
import 'package:note_sphere/util/colors.dart';

class TextStyleClass {
  //heading
  static const appHeadingStyle = TextStyle(
      fontSize: 28,
      color: AppColors.kcTextWhiteColor,
      fontWeight: FontWeight.w700);
  //title
  static const appTittleStyle = TextStyle(
      fontSize: 22,
      color: AppColors.kcTextWhiteColor,
      fontWeight: FontWeight.w500);
  //subtitle
  static const appSubTittleStyle = TextStyle(
      fontSize: 16,
      color: AppColors.kcTextWhiteColor,
      fontWeight: FontWeight.w700);
  //discrption large
  static const appDiscriptionLargeStyle = TextStyle(
      fontSize: 13,
      color: AppColors.kcTextWhiteColor,
      fontWeight: FontWeight.w500);
  //discription small
  static final appDiscriptionSmallStyle = TextStyle(
      fontSize: 12,
      color: AppColors.kcTextWhiteColorShadow,
      fontWeight: FontWeight.w600);
  //cardtitle
  static const appCardTitleStyle = TextStyle(
      fontSize: 17,
      color: AppColors.kcTextWhiteColor,
      fontWeight: FontWeight.w600);
}
