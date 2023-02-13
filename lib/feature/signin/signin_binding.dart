import 'package:get/get.dart';
import 'package:to_do/feature/signin/signin_controller.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
  }
}
