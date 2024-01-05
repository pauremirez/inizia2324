import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inizia2324/utils/constants/color_strings.dart';

class TTextTheme {
  TTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
      displayLarge: GoogleFonts.montserrat(
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
          color: TColors.tDarkColor),
      displayMedium: GoogleFonts.montserrat(
          fontSize: 24.0,
          fontWeight: FontWeight.w700,
          color: TColors.tDarkColor),
      displaySmall: GoogleFonts.poppins(
          fontSize: 24.0,
          fontWeight: FontWeight.w700,
          color: TColors.tDarkColor),
      headlineMedium: GoogleFonts.montserrat(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: TColors.tDarkColor),
      titleLarge: GoogleFonts.montserrat(
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          color: TColors.tDarkColor),
      bodyLarge: GoogleFonts.montserrat(
          fontSize: 14.0,
          fontWeight: FontWeight.normal,
          color: TColors.tDarkColor),
      bodyMedium: GoogleFonts.montserrat(
          fontSize: 14.0,
          fontWeight: FontWeight.normal,
          color: TColors.tDarkColor));

  static TextTheme darkTextTheme = TextTheme(
      displayLarge: GoogleFonts.montserrat(
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
          color: TColors.tWhiteColor),
      displayMedium: GoogleFonts.montserrat(
          fontSize: 24.0,
          fontWeight: FontWeight.w700,
          color: TColors.tWhiteColor),
      displaySmall: GoogleFonts.poppins(
          fontSize: 24.0,
          fontWeight: FontWeight.w700,
          color: TColors.tWhiteColor),
      headlineMedium: GoogleFonts.montserrat(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: TColors.tWhiteColor),
      titleLarge: GoogleFonts.montserrat(
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          color: TColors.tWhiteColor),
      bodyLarge: GoogleFonts.montserrat(
          fontSize: 14.0,
          fontWeight: FontWeight.normal,
          color: TColors.tWhiteColor),
      bodyMedium: GoogleFonts.montserrat(
          fontSize: 14.0,
          fontWeight: FontWeight.normal,
          color: TColors.tWhiteColor));
}
