import 'package:flutter/material.dart';

import '../shared/app_styles.dart';

class AppIconWidget extends StatelessWidget {
  final IconData iconData;
  final Color iconColor;
  final Color bgColor;

  const AppIconWidget({
    Key? key,
    required this.iconData,
     this.iconColor = Colors.white,
    required this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppStyles.kRadiusSmall))),
      clipBehavior: Clip.antiAlias,
      color: bgColor,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Icon(
          iconData,
          color: iconColor,
          size: 72,
        ),
      ),
    );
  }
}
