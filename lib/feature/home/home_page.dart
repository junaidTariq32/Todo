import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/core/routes/app_routes.dart';
import 'package:to_do/core/shared/app_colors.dart';
import 'package:to_do/core/shared/app_styles.dart';
import 'package:to_do/core/widgets/busy_button.dart';
import 'package:to_do/core/widgets/sliver_app_bar.dart';
import 'package:to_do/data/controllers/notification_controller.dart';
import 'package:to_do/feature/home/components/options_grid_widget.dart';
import 'package:to_do/feature/home/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  Widget _buildFab() => FloatingActionButton(
        backgroundColor: AppColors.kcAccent,
        elevation: 5,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () => Get.toNamed(AppRoutes.task),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildFab(),
      backgroundColor: AppColors.kAltWhite,
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(
            title: 'Hello! ${controller.getUserName()}',
            username: controller.getUserName(),

            onProfileTap: () => controller.signOut(),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            AppStyles.vSpaceMedium,
            OptionsGridWidget(tasks: controller.allTasks),
            AppStyles.vSpaceMassive,
          ]))
        ],
      ),
    );
  }
}
