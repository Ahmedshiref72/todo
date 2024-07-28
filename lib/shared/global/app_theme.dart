import 'package:flutter/material.dart';
import '../utils/app__fonts.dart';
import 'app_colors.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: AppColors.primary,
  fontFamily: FontConstants.dINNextLTArabicFontFamily,
  textTheme: const TextTheme(
    // For title bold texts
   titleMedium: TextStyle(
     fontSize: FontSize.s35,
     color: AppColors.lightGreen,
     fontWeight: FontWeightManager.bold,
   ),
    // For subtitle lightGrey texts
   titleSmall: TextStyle(
     fontSize: FontSize.s18,
     color: AppColors.dark,
   ),
   // For text buttons
   labelMedium: TextStyle(
     fontSize: FontSize.s14,
     fontWeight: FontWeightManager.semiBold
   ),
    // For small texts
    displaySmall: TextStyle(
      fontSize: FontSize.s12,
      fontWeight: FontWeightManager.semiBold,
    ),
    // For hint texts
    displayMedium: TextStyle(
      fontSize: FontSize.s18,
      fontWeight: FontWeightManager.semiBold,
  ),
    // For text form fields input
    displayLarge: TextStyle(
      fontSize: FontSize.s22,
      fontWeight: FontWeightManager.bold,
      color: AppColors.dark
    ),
    // For description text.
    headlineSmall: TextStyle(
      fontSize: FontSize.s14,
      color: AppColors.boldGrey,
    ),
    // For buttons label
    headlineMedium: TextStyle(
      fontSize: FontSize.s16,
      fontWeight: FontWeightManager.medium,
        color: AppColors.boldGrey
    ),
    // For appbar title
    headlineLarge: TextStyle(
      fontSize: FontSize.s22,
      fontWeight: FontWeightManager.bold,
      color: AppColors.red,
    ),

  ),
  // scrolling color.
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: AppColors.primary,
  ),
);
