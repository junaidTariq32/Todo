import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:to_do/core/shared/app_colors.dart';
import 'package:to_do/core/shared/app_styles.dart';
import 'package:to_do/core/utils/app_utils.dart';
import 'package:to_do/core/utils/timeago.dart';
import 'package:to_do/data/model/task_model.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({Key? key, required this.task, required this.onMarkCompleted})
      : super(key: key);
  final TaskModel task;
  final Function(TaskModel) onMarkCompleted;

  @override
  Widget build(BuildContext context) {
    final bool isDone = task.status == TaskStatus.done;
    return Material(
      elevation: 3,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isDone
              ? const SizedBox.shrink()
              : const Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.edit,
                    color: AppColors.kcPrimaryColor,
                  )),
          AppStyles.vSpaceSmall,
          Text(
            task.title ?? '',
            style: AppStyles.kBodyStyle.copyWith(fontWeight: FontWeight.w700),
          ),
          AutoSizeText(
            task.description ?? '',
            style: AppStyles.kLabelStyle
                .copyWith(color: AppColors.kcTextSecondary),
            maxLines: 2,
          ),
          AppStyles.vSpaceMedium,
          _buildField(
              icon: Iconsax.calendar,
              value: AppUtils.getFormattedDate(task.startDate!)),
          AppStyles.vSpaceSmall,
          _buildField(
              icon: Iconsax.clock,
              value: 'Start: ${task.startTime!.toDate().toTime()}'),
          AppStyles.vSpaceSmall,
          Align(
            alignment: Alignment.topRight,
            child: !isDone
                ? ActionChip(
                    label: Text('text022'.tr),
                    onPressed: ()=>onMarkCompleted(task),
                  )
                : const Icon(
                     Icons.check_circle_outlined,
                    color:  Colors.green,
                  ),
          )
        ],
      ).paddingAll(16),
    );
  }

  Widget _buildField({required IconData icon, required String value}) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          AppStyles.hSpaceSmall,
          Text(
            value,
            style: AppStyles.kCaptionStyle,
          )
        ],
      );
}
