//defining all the theme properties in the app
import 'package:flutter/material.dart'; 
import 'package:note_sphere/util/colors.dart';

class TheameClass {
  static ThemeData theameData = ThemeData(
    //primary color
    primaryColor: ThemeData.dark().primaryColor,
    //scafold color
    scaffoldBackgroundColor: AppColors.kcBackgroundBlackColor,
    //main color schema
    colorScheme: const ColorScheme.dark(),
    //app bar thema
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.kcBackgroundBlackColor,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.kcTextWhiteColor),
      foregroundColor: AppColors.kcTextWhiteColor,
    ),
    //floating action button theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.kcButtonPurpleColor,
      
      elevation: 0,
      iconSize: 35,
    ),
    //card theme
    cardTheme: const CardTheme(
      color: AppColors.kcCardBlackColor,
      elevation: 1,
      shadowColor: AppColors.kcTextWhiteColor,
    ),
    //text theme
    textTheme: const TextTheme(),
  );
}
