import 'package:get/get.dart';
import 'package:to_do/data/controllers/notification_controller.dart';

import 'core/base/base_controller.dart';
import 'data/controllers/auth_controller.dart';
import 'data/controllers/firestore_controller.dart';

Future initControllers() async {
  Get.lazyPut(() => BaseController(), fenix: true);
  Get.lazyPut(() => NotificationController(), fenix: true);
  Get.lazyPut(() => FirestoreController(), fenix: true);
  Get.lazyPut(() => AuthenticationController(), fenix: true);
}
