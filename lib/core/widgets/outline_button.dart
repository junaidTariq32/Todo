import 'package:flutter/material.dart';

import '../shared/app_colors.dart';
import '../shared/app_styles.dart';

class LineButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;
  final Color textColor;
  final Color borderColor;

  const LineButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.color = Colors.white,
    this.textColor = AppColors.kcTextPrimary,
    this.borderColor = AppColors.kcStroke,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      padding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      disabledColor: AppColors.kcAccent,
      height: 55,
      shape: const RoundedRectangleBorder(
        borderRadius: AppStyles.kBorderSmall,
      ),
      child: Container(
        decoration: BoxDecoration(
            color: color,
            borderRadius:AppStyles.kBorderSmall,
            border: Border.all(
              color: borderColor,width: 2
            )),
        child: Padding(
          padding: AppStyles.fieldPaddingAll,
          child: Center(
            child: Text(
              text,
              style: AppStyles.kBodyStyle.copyWith(
                  fontWeight: FontWeight.w700, color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
