import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:to_do/core/shared/app_styles.dart';
import 'package:to_do/core/widgets/profile_widget.dart';

import '../../feature/home/components/todo_progress.dart';
import '../shared/app_colors.dart';

class CustomSliverAppBar extends StatelessWidget {
  final String title;
  final bool showLeading;
  final Widget? subtitle;
  final String username;
  final VoidCallback onProfileTap;

  const CustomSliverAppBar({
    Key? key,
    required this.title,
    this.showLeading = true,
    this.subtitle, required this.username, required this.onProfileTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      expandedHeight: Get.height * 0.25,
      backgroundColor: AppColors.kcPrimaryColor,
      iconTheme: const IconThemeData(color: Colors.white),
      actions:  [
        InkWell(
          onTap: onProfileTap,
            child: ProfileWidget(name: username))
      ],
      flexibleSpace: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: kToolbarHeight,
          ),
          _buildHeader(),
          AppStyles.vSpaceSmall,
          Text(
            title,
            style: AppStyles.kSubheadingStyle.copyWith(
                color: Colors.white, fontWeight: FontWeight.w700),
          ).paddingOnly(left: 15),
          AppStyles.vSpaceMedium,
          const ToDoProgress().paddingSymmetric(horizontal: 16),
        ],
      ),
    );
  }

  Row _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Icon(Iconsax.note,color: Colors.white,).paddingSymmetric(horizontal: 16),
        Text(
          'ToDo',
          style: AppStyles.kBody1Style
              .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        AppStyles.hSpaceSmall,
      ],
    );
  }
}
