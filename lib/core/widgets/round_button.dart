import 'package:flutter/material.dart';
import '../shared/app_colors.dart';

class RoundButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget icon;
  final Color bgColor;

  const RoundButton({Key? key, required this.onTap, required this.icon, this.bgColor = AppColors.kAltWhite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      height: 46,
      minWidth: 46,
      shape: const CircleBorder(),
      elevation: 0,
      color: bgColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: icon,
      ),
    );
  }
}
