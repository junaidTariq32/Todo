import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:to_do/core/utils/timeago.dart';
import 'package:to_do/data/model/task_model.dart';

import '../shared/app_colors.dart';
import '../widgets/app_dialog.dart';

/// Helper class for common operations.
///
///
class AppUtils {
  AppUtils._();

  static showErrorMessage({required String message, title = 'Info!'}) {
    if (message.isEmpty) return;

    Get.snackbar(title, message,
        backgroundColor: AppColors.kErrorRed,
        colorText: AppColors.kAltWhite,
        padding: const EdgeInsets.symmetric(vertical: 16),
        margin: const EdgeInsets.symmetric(
            vertical: kBottomNavigationBarHeight, horizontal: 16),
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(
          Iconsax.warning_2,
          color: AppColors.kAltWhite,
        ));
  }

  static showMessage({String title = 'Info', required String message}) {
    if (message.isEmpty) return;

    Get.dialog(AppDialog(title: title, desc: message));
  }

  static showInfoMessage({required message, title = 'Info!'}) {

    Get.snackbar(title, message,
        backgroundColor: AppColors.kcPrimaryColor,
        colorText: AppColors.kAltWhite,
        padding: const EdgeInsets.symmetric(vertical: 16),
        margin: const EdgeInsets.symmetric(
            vertical: kBottomNavigationBarHeight, horizontal: 16),
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(
          Iconsax.information,
          size: 18,
          color: AppColors.kAltWhite,
        ));
  }

  static getFormattedTime(int hour, int minute) {
    final fHour = hour.toString().padLeft(2, '0');
    final fMinute = minute.toString().padLeft(2, '0');

    return '$fHour:$fMinute';
  }
  static getFormattedDate(Timestamp date) {
   final dateTime = date.toDate();
   DateFormat format =  DateFormat("MMMM dd, yyyy");

    return format.format(dateTime).toString();
  }

}
/// extensions for task filter
///
///
extension FilterTasksExtenion on List<TaskModel> {
  List<TaskModel> filterTasksByStatus(TaskStatus status) {
    return where((r) => r.status == status).toList();
  }

  List<TaskModel> filterTodayTasks() {
    return where((r) => r.startDate!.toDate().isSameDate(DateTime.now()) && r.status != TaskStatus.done)
        .toList();
  }
  List<TaskModel> filterUpcomingTasks() {
    return where((r) => r.startDate!.toDate().isAfter(DateTime.now()) && r.status != TaskStatus.done)
        .toList();
  }


}
