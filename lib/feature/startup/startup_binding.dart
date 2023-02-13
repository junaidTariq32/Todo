import 'package:get/get.dart';

import 'startup_controller.dart';

class StartUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StartUpController());
  }
}
