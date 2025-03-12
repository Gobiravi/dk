import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFC1768D);
  static const Color secondaryColor = Color(0xFFF2D4E6);
  static const Color textColor = Color(0xFF000000);
  static const Color subTextColor = Color(0xFF393939);
  static const Color socialTextColor = Color(0xFF2B2B2B);
  static const Color appBarAndBottomBarColor = Color(0xFFFFFFFF);
  static const Color strokeColor = Color(0xFFF0D3E3);
  static const Color appBgColor = Color(0xFFF8EDF3);
  static const Color pinkDark = Color(0xFFC1768D);
  static const Color shadowColor = Color(0x0AC18F8F);
  static const Color cursorColor = Colors.grey;
  static const Color secondaryTextColor = Color(0xFF6B6969);
  static const Color teritiaryTextColor = Color(0xFF979797);
  static const Color errorBorder = Color(0xFFF01F0E);
  static const Color buttonOutLine = Color(0xFFD8DADC);

  static final ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: appBgColor,
    textTheme: TextTheme(
      titleLarge: TextStyle(
          color: primaryColor,
          fontWeight: FontWeight.w700,
          fontSize: 27.sp,
          fontFamily: "OpenSansHebrewCondensed"),
      displayLarge: TextStyle(
          color: primaryColor,
          fontWeight: FontWeight.w700,
          fontSize: 27.sp,
          fontFamily: "NotoSansHebrew"),
      titleMedium: TextStyle(
          color: primaryColor,
          fontWeight: FontWeight.w400,
          fontSize: 17.sp,
          fontFamily: "NotoSansHebrew"),
      labelMedium: TextStyle(
          color: textColor,
          fontFamily: "NotoSansHebrew",
          fontWeight: FontWeight.w600,
          // overflow: TextOverflow.ellipsis,
          fontSize: 16.sp),
      labelSmall: TextStyle(
          color: subTextColor,
          fontFamily: "NotoSansHebrew",
          fontWeight: FontWeight.w500,
          fontSize: 13.sp),
      headlineLarge: TextStyle(
          color: subTextColor,
          fontFamily: "NotoSansHebrew",
          fontWeight: FontWeight.w600,
          fontSize: 24.sp),
      bodyMedium: TextStyle(
          color: subTextColor,
          fontFamily: "NotoSansHebrew",
          fontWeight: FontWeight.w500,
          fontSize: 15.sp),
      bodyLarge: TextStyle(
          color: primaryColor,
          fontFamily: "NotoSansHebrew",
          fontWeight: FontWeight.w400,
          fontSize: 18.sp),
      bodySmall: TextStyle(
          color: subTextColor,
          fontFamily: "NotoSansHebrew",
          fontWeight: FontWeight.w300,
          fontSize: 12.sp),
      titleSmall: TextStyle(
        color: subTextColor,
        fontSize: 14,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w700,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: appBarAndBottomBarColor,
      iconTheme: IconThemeData(color: textColor),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: appBarAndBottomBarColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: subTextColor,
        selectedLabelStyle: TextStyle(color: primaryColor)),
  );
}
