import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/core/utils/app_utils.dart';
import 'package:to_do/core/utils/timeago.dart';
import 'package:to_do/data/controllers/auth_controller.dart';
import 'package:to_do/data/controllers/firestore_controller.dart';
import 'package:to_do/data/controllers/notification_controller.dart';
import 'package:to_do/data/model/task_model.dart';
import 'package:uuid/uuid.dart';

import '../../core/base/base_controller.dart';

class TaskController extends BaseController {
  final _authController = Get.find<AuthenticationController>();
  final _fireController = Get.find<FirestoreController>();
  final _notificationController = Get.find<NotificationController>();

  //form controller
  final formKey = GlobalKey<FormState>();
  final titleTEC = TextEditingController();
  final descriptionTEC = TextEditingController();
  final startTimeTEC = TextEditingController();

  ///date controllers
  final DatePickerController datePickerController = DatePickerController();

  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<TimeOfDay> startTime = TimeOfDay.now().obs;

  TaskModel? editTask;

  @override
  void onInit() {
    if (Get.arguments != null) {
      editTask = Get.arguments as TaskModel;
      if (editTask != null) {
        setEditData(editTask!);
      }
    }
    super.onInit();
  }

  void setEditData(TaskModel task) {
    titleTEC.text = task.title ?? '';
    descriptionTEC.text = task.description ?? '';
    startTime.value = TimeOfDay(
        hour: task.startTime!.toDate().hour,
        minute: task.startTime!.toDate().minute);
    startTimeTEC.text =
        AppUtils.getFormattedTime(startTime.value.hour, startTime.value.minute);
    selectedDate.value = task.startDate?.toDate() ?? DateTime.now();
  }

  Future showPicker(BuildContext context) async {
    final result =
        await showTimePicker(context: context, initialTime: startTime.value);
    if (result != null) {
      setBusy(true);
      startTime.value = result;
      startTimeTEC.text = AppUtils.getFormattedTime(result.hour, result.minute);
      setBusy(false);
    }
  }

  Future createTask() async {
    if (formKey.currentState!.validate()) {
      setBusy(true);
      //set new id if the page is not for update task
      final taskId = editTask?.id ?? const Uuid().v4();

      TaskModel t = TaskModel(
        id: taskId,
        createdAt: Timestamp.now(),
        startDate: Timestamp.fromDate(selectedDate.value),
        startTime: Timestamp.fromDate(startTime.value.toDate()),
        title: titleTEC.text,
        status: TaskStatus.progress,
        description: descriptionTEC.text,
      );

      final result = await _fireController.createTask(
          t, _authController.currentUser?.userId ?? '');
      setBusy(false);
      if (!result.hasError) {
        Get.back();
        //schedule notification as reminder
        scheduleNotification(t);

        AppUtils.showInfoMessage(message: 'text015'.tr);
      } else {
        AppUtils.showErrorMessage(message: result.errorMessage);
      }
    }
  }

  Future deleteTask() async {
    setBusy(true);
    final result = await _fireController.deleteTask(
        taskId: editTask?.id ?? '',
        uid: _authController.currentUser?.userId ?? '');
    if (!result.hasError) {
      Get.back();

      //remove scheduled notification if any
      await _notificationController.cancelScheduledAlert(
          editTask?.createdAt?.toAlertId()??0);

      AppUtils.showInfoMessage(message: 'text016'.tr);
    } else {
      AppUtils.showErrorMessage(message: result.errorMessage);
    }
    setBusy(false);
  }

  Future scheduleNotification(TaskModel task) async {
    //create a scheduled notification with createdAt timestamp as id
    await _notificationController.createScheduledAlert(
        vid: task.createdAt?.toAlertId()??0,
        title: task.title ?? '',
        description: task.description ?? '',
        date: task.startDate!.toDate(),startTime: task.startTime!.toDate());
  }

  @override
  void dispose() {
    titleTEC.dispose();
    descriptionTEC.dispose();
    startTimeTEC.dispose();
    super.dispose();
  }
}
