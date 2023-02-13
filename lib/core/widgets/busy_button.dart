import 'package:flutter/material.dart';
import 'package:to_do/core/shared/app_colors.dart';

import '../shared/app_styles.dart';
import '../utils/device_utils.dart';

class BoxButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color? buttonColor;
  final Color? textColor;
  final VoidCallback onPressed;
  final bool isLoading;
  final double radius;
  final bool isEnabled;

  const BoxButtonWidget({
    Key? key,
    required this.buttonText,
    this.buttonColor,
    this.textColor = AppColors.kAltWhite,
    required this.onPressed,
    this.isLoading = false,
    this.radius = 8.0,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      disabledColor: buttonColor ?? AppColors.kcPrimaryColor,
      height: 45,
      elevation: 0,

      color:
          isEnabled ? buttonColor ?? AppColors.kcPrimaryColor : Colors.black12,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6))),
      onPressed: isEnabled
          ? isLoading
              ? null
              : () {
                  DeviceUtils.hideKeyboard(context);
                  onPressed();
                }
          : () {},
      child: AnimatedContainer(
          height: 50,
          duration: const Duration(milliseconds: 200),
          child: Center(
              child: isLoading
                  ? const CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.kAltWhite))
                  : Text(
                      buttonText,
                      style: AppStyles.kBodyStyle.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.kButtonTextColor,
                      ),
                    ))),
    );
  }
}
