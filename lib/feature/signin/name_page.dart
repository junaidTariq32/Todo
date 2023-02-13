import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/core/shared/app_styles.dart';
import 'package:to_do/core/widgets/busy_button.dart';
import 'package:to_do/core/widgets/text_field_widget.dart';
import 'package:to_do/feature/signin/signin_controller.dart';

class NamePage extends GetView<SignInController> {
  const NamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(),
        Text(
          'text005'.tr,
          style: AppStyles.kHeading3Style,
        ),
        const Spacer(),
        AppTextField(
          controller: controller.nameTEC,
          hintText: 'text002'.tr,
          label: 'text013'.tr,
          onChanged: (value) {
            controller.name.value = value;
          },
          validator: (value) {
            if (value!.isEmpty) {
              return 'text003'.tr;
            }
            return null;
          },
        ),
        AppStyles.vSpaceMedium,
        Obx(() => BoxButtonWidget(
              buttonText: 'text004'.tr,
              onPressed: () => controller.createUserWithEmail(),
              isLoading: controller.isBusy.value,
              isEnabled: controller.name.value.isNotEmpty,
            )),
        const Spacer(),
      ],
    ).paddingSymmetric(horizontal: AppStyles.kHorizontalPadding));
  }
}
