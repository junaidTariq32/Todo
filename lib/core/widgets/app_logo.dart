import 'package:flutter/material.dart';


class AppLogoWidget extends StatelessWidget {
  final double radius;
  final double elevation;
  final String path;

  const AppLogoWidget(
      {Key? key, this.radius = 4, this.elevation = 1, required this.path})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      width: 95.05,
      height: 87.01,
    );
  }
}
