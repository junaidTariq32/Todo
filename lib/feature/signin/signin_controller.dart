import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/core/base/base_controller.dart';
import 'package:to_do/core/routes/app_routes.dart';
import 'package:to_do/core/utils/app_utils.dart';
import 'package:to_do/data/controllers/auth_controller.dart';

class SignInController extends BaseController {
  final authController = Get.find<AuthenticationController>();

  final nameTEC = TextEditingController();
  RxString name = ''.obs;

  Future createUserWithEmail() async {
    setBusy(true);
    final result =
        await authController.createNewUserForEmail(nameTEC.text.trim());
    setBusy(false);
    if (!result.hasError) {
      Get.offAllNamed(AppRoutes.home);
    } else {
      AppUtils.showErrorMessage(message: result.errorMessage);
    }
  }
  Future goToHome()async{
    setBusy(true);
    await authController.populateCurrentUser();
    Get.offAllNamed(AppRoutes.home);
    setBusy(false);
  }

  @override
  void dispose() {
    nameTEC.dispose();
    super.dispose();
  }
}
