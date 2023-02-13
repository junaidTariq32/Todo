import 'package:get/get.dart';
import 'package:to_do/feature/home/home_binding.dart';
import 'package:to_do/feature/home/home_page.dart';
import 'package:to_do/feature/signin/name_page.dart';
import 'package:to_do/feature/signin/signin_binding.dart';
import 'package:to_do/feature/signin/signin_page.dart';
import 'package:to_do/feature/task/task_binding.dart';
import 'package:to_do/feature/task/task_page.dart';

import '../../feature/startup/startup_binding.dart';
import '../../feature/startup/startup_page.dart';
import 'app_routes.dart';

class AppPages {
  // add a private constructor to prevent this class being instantiated

  AppPages._();

  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.startup,
      page: () => const StartUpPage(),
      binding: StartUpBinding(),
    ),
    GetPage(
      name: AppRoutes.signIn,
      page: () => const SignInPage(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: AppRoutes.name,
      page: () => const NamePage(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.task,
      page: () => TaskPage(
        task: Get.arguments,
      ),
      binding: TaskBinding(),
    ),
  ];
}
