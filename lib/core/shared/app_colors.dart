// colors
import 'package:flutter/material.dart';

class AppColors{

  AppColors._();

  static const Color kcPrimaryColor = Color(0xff300044);
  static const Color kcAccent = Color(0xFFF06111);
  static const Color kcTextPrimary = Color(0xFF010302);
  static const Color kcTextSecondary = Color(0xFF5F5F5F);
  static const Color kButtonTextColor = Color(0xFFFFFFFF);
  static const Color kcStroke = Color(0xFFE9E7CF);
  static const Color kcFocusBorder = Color(0xFF787878);
  static const Color kIconUnselected = Color(0xffCDCDCD);
  static const Color kAltBg = Color(0xFF282828);
  static const Color kAltBgLight = Color(0xFF5c5c64);
  static const Color kAltBgDark = Color(0xFF161616);
  static const Color kSplashBg = Color(0xFFe5ffff);
  static const Color kAltWhite = Color(0xFFFCFCFC);
  static const Color kBgDark = Colors.black38;
  static const Color kBlack = Colors.black87;
  static const Color kFillColor = Color(0xFFF1F1F1);
  static const Color kErrorRed = Color(0xFFFF2E00);

//gradient
  static const kPrimaryGradient = LinearGradient(
    colors: [kcPrimaryColor, kcAccent],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

}

