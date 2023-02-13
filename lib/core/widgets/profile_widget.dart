import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:to_do/core/shared/app_colors.dart';

import '../shared/app_styles.dart';

class ProfileWidget extends StatelessWidget {
  final bool? isDark;
  final String name;

  const ProfileWidget({Key? key, this.isDark = false, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 32,
      decoration: const BoxDecoration(
          color: AppColors.kcAccent,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: _buildLetter(context).center(),
    ).paddingAll(8);
  }

  Widget _buildLetter(BuildContext context) => Text(
        name[0].toUpperCase(),
        style: AppStyles.kBodyStyle.copyWith(color: Colors.white),
      );
}
