import 'package:flutter/material.dart';
import '../utils/app__fonts.dart';
import 'app_colors.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: AppColors.primary,
  fontFamily: FontConstants.dMSansFontFamily,
  textTheme: const TextTheme(

    titleLarge:   TextStyle(
      fontSize: FontSize.s24,
      color: AppColors.dark,
      fontWeight: FontWeightManager.bold,
    ),
    // For title bold texts
   titleMedium: TextStyle(
     fontSize: FontSize.s16,
     color: AppColors.primary,
     fontWeight: FontWeightManager.bold,

   ),
    // For subtitle lightGrey texts
   titleSmall: TextStyle(
     fontSize: FontSize.s14,
     color: AppColors.boldGrey,
     fontWeight: FontWeight.w400,
   ),
   // For text buttons
   labelMedium: TextStyle(
     fontSize: FontSize.s20,
     fontWeight: FontWeightManager.bold,
     color: AppColors.background,
   ),
    // For small texts
    displaySmall: TextStyle(
      fontSize: FontSize.s12,
      fontWeight: FontWeight.w500,
      color: AppColors.boldGrey
    ),
    // For hint texts
    displayMedium: TextStyle(
      fontSize: FontSize.s16,
      fontWeight: FontWeight.w700,
      color: AppColors.dark,
  ),
    // For text form fields input
    displayLarge: TextStyle(
      fontSize: FontSize.s18,
      fontWeight: FontWeight.w700,
      color: AppColors.boldGrey
    ),
    // For description text.
    headlineSmall: TextStyle(
      fontSize: FontSize.s14,
      color: AppColors.boldGrey,
      fontWeight: FontWeight.w400
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
