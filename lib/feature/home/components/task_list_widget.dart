import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:to_do/core/shared/app_styles.dart';
import 'package:to_do/core/widgets/app_info.dart';
import 'package:to_do/feature/home/components/task_tile.dart';

import '../../../data/model/task_model.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget(
      {Key? key,
      required this.tasks,
      required this.onSelected,
      required this.onMarkCompleted})
      : super(key: key);
  final List<TaskModel> tasks;
  final Function(TaskModel) onSelected;
  final Function(TaskModel) onMarkCompleted;

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ?  AppInfoWidget(
                translateKey: 'text025'.tr, iconData: Icons.add_task)
            .center()
        : ListView.separated(
            itemCount: tasks.length,
            shrinkWrap: true,
            separatorBuilder: (_, __) => AppStyles.vSpaceMedium,
            itemBuilder: (_, index) => InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  onTap: () => onSelected(tasks[index]),
                  child: TaskTile(
                    task: tasks[index],
                    onMarkCompleted: onMarkCompleted,
                  ).paddingOnly(left: 16,right: 16,bottom: index == tasks.length-1?16:0),
                ));
  }
}
