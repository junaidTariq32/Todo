import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/core/shared/app_styles.dart';
import 'package:to_do/core/utils/device_utils.dart';
import 'package:to_do/core/widgets/text_field_widget.dart';
import 'package:to_do/data/model/task_model.dart';
import 'package:to_do/feature/task/task_controller.dart';

import '../../core/shared/app_colors.dart';
import '../../core/widgets/busy_button.dart';

class TaskPage extends GetView<TaskController> {
  const TaskPage({Key? key, this.task}) : super(key: key);
  final TaskModel? task;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => DeviceUtils.hideKeyboard(context),
      child: Scaffold(
          appBar: AppBar(
            title: Text('text006'.tr),
            actions: [
              controller.editTask != null
                  ? IconButton(
                      onPressed: () => controller.deleteTask(),
                      icon: const Icon(
                        Icons.delete_outline,
                        color: AppColors.kcPrimaryColor,
                      ))
                  : const SizedBox.shrink()
            ],
          ),
          bottomNavigationBar: controller.editTask?.status == TaskStatus.done
              ? const SizedBox.shrink()
              : Obx(() => BoxButtonWidget(
                    buttonText: controller.editTask == null
                        ? 'text012'.tr
                        : 'text014'.tr,
                    onPressed: () => controller.createTask(),
                    isLoading: controller.isBusy.value,
                  )).paddingAll(AppStyles.kHorizontalPadding),
          body: SingleChildScrollView(
            padding: AppStyles.fieldPadding,
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppStyles.vSpaceMedium,
                  Text('text028'.tr,style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: AppColors.kAltBgLight),),
                  AppStyles.vSpaceSmall,
                  DatePicker(
                    DateTime.now(),
                    controller: controller.datePickerController,
                    initialSelectedDate: controller.selectedDate.value,
                    selectedTextColor: Colors.white,
                    monthTextStyle: AppStyles.kLabelStyle,
                    height: 100,
                    dayTextStyle: AppStyles.kLabelStyle,
                    dateTextStyle: AppStyles.kBodyStyle
                        .copyWith(fontWeight: FontWeight.w700),
                    selectionColor: AppColors.kcPrimaryColor,
                    deactivatedColor: AppColors.kAltBg.withOpacity(.2),
                    onDateChange: (date) {
                      controller.selectedDate.value = date;
                    },
                  ),
                  AppStyles.vSpaceMedium,
                  InkWell(
                    onTap: () => controller.showPicker(context),
                    child: AppTextField(
                        controller: controller.startTimeTEC,
                        hintText: '00:00',
                        isEnabled: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'text009'.tr;
                          }
                          return null;
                        },
                        label: 'text009'.tr),
                  ),
                  AppStyles.vSpaceMedium,
                  AppTextField(
                      controller: controller.titleTEC,
                      hintText: 'text026'.tr,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'text007'.tr;
                        }
                        return null;
                      },
                      label: 'text007'.tr),
                  AppStyles.vSpaceMedium,
                  AppTextField(
                      controller: controller.descriptionTEC,
                      hintText: 'text027'.tr,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'text011'.tr;
                        }
                        return null;
                      },
                      label: 'text011'.tr)
                ],
              ),
            ),
          )),
    );
  }
}
