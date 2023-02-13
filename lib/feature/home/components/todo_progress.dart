import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/core/shared/app_colors.dart';
import 'package:to_do/core/shared/app_styles.dart';
import 'package:to_do/core/utils/app_utils.dart';
import 'package:to_do/data/model/task_model.dart';
import 'package:to_do/feature/home/home_controller.dart';

import '../../../core/widgets/rich_text.dart';

class ToDoProgress extends GetView<HomeController> {
  const ToDoProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var completedTasks =
          controller.allTasks.filterTasksByStatus(TaskStatus.done);

      return controller.allTasks.isEmpty
          ? const SizedBox()
          : TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeInOut,
              tween: Tween<double>(
                begin: 0,
                end: (completedTasks.length / controller.allTasks.length),
              ),
              builder: (context, value, _) => Column(
                children: [
                  SizedBox(
                    height: 12,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: LinearProgressIndicator(
                        value: value,
                        color: AppColors.kcAccent,
                      ),
                    ),
                  ),
                  AppStyles.vSpaceTiny,
                  Align(
                    alignment: Alignment.topRight,
                    child: RichTextWidget(
                      firstTxt: 'text017'.tr,
                      secondTxt:
                          '${completedTasks.length}/${controller.allTasks.length}',
                      onTap: () {},
                    ),
                  )
                ],
              ),
            );
    });
  }
}
