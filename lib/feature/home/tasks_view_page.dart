import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/feature/home/components/task_list_widget.dart';
import 'package:to_do/feature/home/home_controller.dart';

enum TaskViewType { today, upcoming, done }

class TasksViewPage extends GetView<HomeController> {
  const TasksViewPage({Key? key,required this.type, required this.title}) : super(key: key);
  final TaskViewType type;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Obx(() => TaskListWidget(
          tasks: controller.filterTaskByViewType(type),
          onSelected: (task) => controller.goToViewTask(task),
          onMarkCompleted: (task) => controller.markCompletedTask(task))),
    );
  }
}
