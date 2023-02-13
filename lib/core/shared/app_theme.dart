import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';
import 'app_styles.dart';
///  class for app theme.
///
///
class AppTheme{
  static final AppTheme _singleton = AppTheme._internal();
  factory AppTheme() => _singleton;
  AppTheme._internal();

  final ThemeData themeData = ThemeData(
    textTheme: GoogleFonts.poppinsTextTheme(),
    useMaterial3: true,
    brightness: Brightness.light,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Colors.white
    ),
    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.zero,
      minLeadingWidth: 4,
    ),
    dividerColor: Colors.transparent,
    dialogTheme: const DialogTheme(
    ),
    chipTheme: const ChipThemeData(
      selectedColor: AppColors.kcPrimaryColor,
      backgroundColor: AppColors.kAltWhite,
    ),
    focusColor: AppColors.kcPrimaryColor,
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6))
        )),
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.all(16),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(AppColors.kcPrimaryColor),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
    ),
    appBarTheme: AppBarTheme(
        elevation: 0,
        color: Colors.white,
        iconTheme: const IconThemeData(color:AppColors.kcPrimaryColor),
        titleTextStyle: AppStyles.kSubheadingStyle.copyWith(fontWeight: FontWeight.w500,color: AppColors.kcPrimaryColor)),
    scaffoldBackgroundColor: Colors.white,
    primaryColor: AppColors.kcPrimaryColor,
  );

  final ThemeData themeDataDark = ThemeData(
    textTheme: GoogleFonts.robotoSlabTextTheme(),
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.kBlack,
    primaryColor: AppColors.kcPrimaryColor,
  );
}


