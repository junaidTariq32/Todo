import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/core/shared/app_colors.dart';
import 'package:to_do/core/utils/app_utils.dart';
import 'package:to_do/feature/home/home_controller.dart';
import 'package:to_do/feature/home/tasks_view_page.dart';

import '../../../core/shared/app_styles.dart';
import '../../../core/widgets/tile_widget.dart';
import '../../../data/model/task_model.dart';

class OptionsGridWidget extends GetView<HomeController> {
  const OptionsGridWidget({Key? key, required this.tasks}) : super(key: key);
  final List<TaskModel> tasks;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: TileWidget(
                  header: 'text019'.tr,
                  subHeader: '${controller.allTasks.filterTodayTasks().length}',
                  icon: Icons.calendar_today,
                  primaryColor: AppColors.kcPrimaryColor,
                  onTap: () =>Get.to(()=>TasksViewPage(type: TaskViewType.today, title: 'text019'.tr,)),
                  isDark: false,
                )),
                AppStyles.hSpaceSmall,
                Expanded(
                    child: TileWidget(
                  header: 'text020'.tr,
                  subHeader:
                      '${controller.allTasks.filterUpcomingTasks().length}',
                  icon: Icons.calendar_today,
                  primaryColor: AppColors.kcAccent,
                      onTap: () =>Get.to(()=>TasksViewPage(type: TaskViewType.upcoming, title: 'text020'.tr,)),
                  isDark: false,
                ))
              ],
            ),
            AppStyles.vSpaceSmall,
            TileWidget(
              header: 'text021'.tr,
              subHeader:
                  '${controller.allTasks.filterTasksByStatus(TaskStatus.done).length}',
              icon: Icons.calendar_today,
              primaryColor: Colors.brown,
              onTap: () =>Get.to(()=>TasksViewPage(type: TaskViewType.done, title: 'text021'.tr,)),
              isDark: false,
            )
          ],
        )).paddingSymmetric(horizontal: 8);
  }
}
