import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import '../shared/app_colors.dart';
import '../shared/app_styles.dart';

class CustomCheckTile extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onToggle;
  final String title;

  const CustomCheckTile(
      {Key? key,
      required this.isSelected,
      required this.onToggle,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onToggle,
      borderRadius: AppStyles.kBorderSmall,
      child: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 18,
          width: 18,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              color: Colors.black),
          child: isSelected
              ? const Icon(
                  Icons.check,
                  color: AppColors.kcPrimaryColor,
            size: 12,
                ).center()
              : const SizedBox.shrink(),
        ),
        AppStyles.hSpaceMedium,
        Text(
          title,
          style: AppStyles.kBodyStyle,
        )
      ].toRow(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center).paddingAll(4),
    );
  }
}
