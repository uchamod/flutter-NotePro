import 'package:flutter/material.dart';
import 'package:note_sphere/util/colors.dart';

class TextStyleClass {
  //heading
  static const appHeadingStyle = TextStyle(
      fontSize: 24,
      color: AppColors.kcTextWhiteColor,
      fontWeight: FontWeight.w700);
  //title
  static const appTittleStyle = TextStyle(
      fontSize: 18,
      color: AppColors.kcTextWhiteColor,
      fontWeight: FontWeight.w800);
  //subtitle
  static const appSubTittleStyle = TextStyle(
      fontSize: 14,
      color: AppColors.kcTextWhiteColor,
      fontWeight: FontWeight.w700);
  //discrption large
  static const appDiscriptionLargeStyle = TextStyle(
      fontSize: 12,
      color: AppColors.kcTextWhiteColor,
      fontWeight: FontWeight.w500);
  //discription small
  static final appDiscriptionSmallStyle = TextStyle(
      fontSize: 11,
      color: AppColors.kcTextWhiteColorShadow,
      fontWeight: FontWeight.w600);
  //cardtitle
  static const appCardTitleStyle = TextStyle(
      fontSize: 14,
      color: AppColors.kcTextWhiteColor,
      fontWeight: FontWeight.w600);
}
