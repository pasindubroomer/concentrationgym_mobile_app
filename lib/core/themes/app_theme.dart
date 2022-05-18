import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_color_gen/material_color_gen.dart';
import 'package:sizer/sizer.dart';

import '../constants/colors.dart';

class AppTheme {
  const AppTheme._();

  static final lightTheme = ThemeData(
    textTheme: textTheme,
    brightness: Brightness.light,
    primarySwatch: kTextBlackColor.toMaterialColor(),
    primaryColor: kTextDefaultRedColor,
    backgroundColor: kmainBackgroundColor,
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: kTextDefaultRedColor,
    backgroundColor: kmainBackgroundColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final TextTheme textTheme = TextTheme(
    headline1: GoogleFonts.oswald(
        fontSize: 97.sp, fontWeight: FontWeight.w300, letterSpacing: -1.5),
    headline2: GoogleFonts.oswald(
        fontSize: 61.sp, fontWeight: FontWeight.w300, letterSpacing: -0.5),
    headline3: GoogleFonts.oswald(fontSize: 48.sp, fontWeight: FontWeight.w400),
    headline4: GoogleFonts.oswald(
        fontSize: 34.sp, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    headline5: GoogleFonts.oswald(fontSize: 24.sp, fontWeight: FontWeight.w400),
    headline6: GoogleFonts.oswald(
        fontSize: 20.sp, fontWeight: FontWeight.w500, letterSpacing: 0.15),
    subtitle1: GoogleFonts.oswald(
        fontSize: 16.sp, fontWeight: FontWeight.w400, letterSpacing: 0.15),
    subtitle2: GoogleFonts.oswald(
        fontSize: 14.sp, fontWeight: FontWeight.w500, letterSpacing: 0.1),
    bodyText1: GoogleFonts.oswald(
        fontSize: 16.sp, fontWeight: FontWeight.w400, letterSpacing: 0.5),
    bodyText2: GoogleFonts.oswald(
        fontSize: 14.sp, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    button: GoogleFonts.oswald(
        fontSize: 14.sp, fontWeight: FontWeight.w500, letterSpacing: 1.25),
    caption: GoogleFonts.oswald(
        fontSize: 12.sp, fontWeight: FontWeight.w400, letterSpacing: 0.4),
    overline: GoogleFonts.oswald(
        fontSize: 10.sp, fontWeight: FontWeight.w400, letterSpacing: 1.5),
  );
}
