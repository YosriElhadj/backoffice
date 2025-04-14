import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppStyles {
  // Headline Styles
  static TextStyle headline1 = GoogleFonts.montserrat(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static TextStyle headline2 = GoogleFonts.montserrat(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  // Body Styles
  static TextStyle bodyRegular = GoogleFonts.roboto(
    fontSize: 16,
    color: AppColors.textSecondary,
  );

  static TextStyle bodyBold = GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  // Button Styles
  static TextStyle buttonText = GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.textLight,
  );
}