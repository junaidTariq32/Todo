import 'package:flutter/material.dart';

// Box Decorations

class AppStyles {
  AppStyles._();

// Field Variables
  static const double fieldHeight = 55;
  static const double kHorizontalPadding = 24;
  static const double smallFieldHeight = 40;
  static const double inputFieldBottomMargin = 30;
  static const double inputFieldSmallBottomMargin = 0;
  static const EdgeInsets fieldPadding = EdgeInsets.symmetric(horizontal: 28);
  static const EdgeInsets fieldPaddingAll = EdgeInsets.all(10.0);
  static const EdgeInsets kLargeFieldPadding =
      EdgeInsets.symmetric(horizontal: 48, vertical: 24);

//Radius
  static const double kRadiusSmall = 8;
  static const double kRadiusMedium = 12;
  static const double kRadiusLarge = 18;
  static const double kRadiusAvatar = 40.0;

  ///border radius
  static const BorderRadius kBorderSmall =
      BorderRadius.all(Radius.circular(kRadiusSmall));
  static const BorderRadius kBorderMedium =
      BorderRadius.all(Radius.circular(kRadiusMedium));
  static const BorderRadius kBorderLarge =
       BorderRadius.all(Radius.circular(kRadiusLarge));

  /// text themes
// To make it clear which weight we are using, we'll define the weight even for regular
// fonts
  static const TextStyle kHeading1Style =
      TextStyle(fontSize: 34, fontWeight: FontWeight.w400);

  static const TextStyle kHeading2Style =
      TextStyle(fontSize: 28, fontWeight: FontWeight.w600);

  static const TextStyle kHeading3Style =
      TextStyle(fontSize: 22, fontWeight: FontWeight.w600);

  static const TextStyle kHeadlineStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w700);

  static const TextStyle kBodyStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w400);

  static const TextStyle kBody1Style =
      TextStyle(fontSize: 15, fontWeight: FontWeight.w400);

  static const TextStyle kBody2Style =
      TextStyle(fontSize: 11, fontWeight: FontWeight.w400);

  static const TextStyle kLabelStyle =
      TextStyle(fontSize: 10, fontWeight: FontWeight.w400);

  static const TextStyle kSubheadingStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w400);

  static const TextStyle kCaptionStyle =
      TextStyle(fontSize: 13, fontWeight: FontWeight.w400);

//shaders
  final Shader goldGradient = const LinearGradient(
    colors: <Color>[Color(0xFFfcf29f), Color(0xFFe5c469)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  //margins and padding
  static const Widget hSpaceTiny = SizedBox(width: 5.0);
  static const Widget hSpaceSmall = SizedBox(width: 10.0);
  static const Widget hSpaceMedium = SizedBox(width: 25.0);

  static const Widget vSpaceTiny = SizedBox(height: 5.0);
  static const Widget vSpaceSmall = SizedBox(height: 10.0);
  static const Widget vSpaceMedium = SizedBox(height: 25.0);
  static const Widget vSpaceLarge = SizedBox(height: 80.0);
  static const Widget vSpaceMassive = SizedBox(height: 120.0);
}
