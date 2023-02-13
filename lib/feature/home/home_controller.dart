import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/core/routes/app_routes.dart';
import 'package:to_do/core/utils/app_utils.dart';
import 'package:to_do/core/utils/timeago.dart';
import 'package:to_do/data/controllers/auth_controller.dart';
import 'package:to_do/data/controllers/firestore_controller.dart';
import 'package:to_do/data/controllers/notification_controller.dart';
import 'package:to_do/data/model/task_model.dart';
import 'package:to_do/feature/home/tasks_view_page.dart';

import '../../core/base/base_controller.dart';

class HomeController extends BaseController {
  final _authController = Get.find<AuthenticationController>();
  final _fireController = Get.find<FirestoreController>();
  final _notificationController = Get.find<NotificationController>();

  StreamSubscription? _streamSubscription;
  RxList<TaskModel> tasks = <TaskModel>[].obs;
  RxList<TaskModel> allTasks = <TaskModel>[].obs;
  Rx<TaskViewType> taskViewType = TaskViewType.today.obs;

  Future listenToTask() async {
    _streamSubscription = _fireController
        .streamTasks(_authController.currentUser?.userId ?? '')
        .listen((snapshots) {
      allTasks.value = snapshots;
      filterTaskByIndex(0);
    });
  }

  void filterTaskByIndex(int index) {
    switch (index) {
      case 0:
        tasks.value = allTasks.filterTodayTasks();
        break;
      case 1:
        tasks.value = allTasks.filterUpcomingTasks();
        break;
      case 2:
        tasks.value = allTasks.filterTasksByStatus(TaskStatus.done);
        break;
    }
  }

  Future markCompletedTask(TaskModel task) async {
    setBusy(true);
    final result = await _fireController.markTaskAsCompleted(
        taskId: task.id ?? '', uid: _authController.currentUser?.userId ?? '');
    if (!result.hasError) {
      await _notificationController
          .cancelScheduledAlert(task.createdAt?.toAlertId() ?? 0);
      AppUtils.showInfoMessage(message: 'Task marked as completed');
    } else {
      AppUtils.showErrorMessage(message: result.errorMessage);
    }
    setBusy(false);
    update();
  }

  void goToViewTask(TaskModel task) {
    Get.toNamed(AppRoutes.task, arguments: task);
  }

  List<TaskModel> filterTaskByViewType(TaskViewType type) {
    switch (type) {
      case TaskViewType.today:
        tasks.value = allTasks.filterTodayTasks();
        break;
      case TaskViewType.upcoming:
        tasks.value = allTasks.filterUpcomingTasks();
        break;
      case TaskViewType.done:
        tasks.value = allTasks.filterTasksByStatus(TaskStatus.done);
        break;
    }
    return tasks;
  }

  Future signOut() async {
    //show confirmation dialog before signoutes
    Get.defaultDialog(
        title: 'text023'.tr,
        onCancel: () => Get.back(),
        content: Text('text024'.tr),
        onConfirm: () => _authController.signOut());
  }

  @override
  void onInit() {

    listenToTask();
    super.onInit();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  String getUserName() {
    return _authController.currentUser?.name ?? '';
  }
}
