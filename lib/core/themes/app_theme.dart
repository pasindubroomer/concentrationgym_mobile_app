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
    primarySwatch: kDefaultBlueColor.toMaterialColor(),
    primaryColor: kDefaultBlueColor,
    backgroundColor: kmainBackgroundColor,
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: kDefaultBlueColor,
    backgroundColor: kmainBackgroundColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final TextTheme textTheme = TextTheme(
    headline1: GoogleFonts.firaSansExtraCondensed(
        fontSize: 97, fontWeight: FontWeight.w300),
    headline2: GoogleFonts.firaSansExtraCondensed(
        fontSize: 61, fontWeight: FontWeight.w300),
    headline3: GoogleFonts.firaSansExtraCondensed(
        fontSize: 48, fontWeight: FontWeight.w400),
    headline4: GoogleFonts.firaSansExtraCondensed(
        fontSize: 34, fontWeight: FontWeight.w400),
    headline5: GoogleFonts.firaSansExtraCondensed(
        fontSize: 24, fontWeight: FontWeight.w400),
    headline6: GoogleFonts.firaSansExtraCondensed(
        fontSize: 20, fontWeight: FontWeight.w500),
    subtitle1: GoogleFonts.firaSansExtraCondensed(
        fontSize: 16, fontWeight: FontWeight.w400),
    subtitle2: GoogleFonts.firaSansExtraCondensed(
        fontSize: 14, fontWeight: FontWeight.w500),
    bodyText1: GoogleFonts.firaSansExtraCondensed(
        fontSize: 16, fontWeight: FontWeight.w400),
    bodyText2: GoogleFonts.firaSansExtraCondensed(
        fontSize: 14, fontWeight: FontWeight.w400),
    button: GoogleFonts.firaSansExtraCondensed(
        fontSize: 14, fontWeight: FontWeight.w500),
    caption: GoogleFonts.firaSansExtraCondensed(
        fontSize: 12, fontWeight: FontWeight.w400),
    overline: GoogleFonts.firaSansExtraCondensed(
        fontSize: 10, fontWeight: FontWeight.w400),
  );
}
