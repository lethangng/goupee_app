import 'package:get/get.dart';

import 'app_controller.dart';
// import 'notification_controller.dart';
import 'app_data_controller.dart';
import 'network_controller.dart';
import '../login_controller/login_controller.dart';
import 'user_controller.dart';

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    // Get.put<NotificationController>(NotificationController());
    Get.put<AppController>(AppController());
    Get.put<NetworkController>(NetworkController());
    Get.put<AppDataController>(AppDataController());
    Get.put<UserController>(UserController());
    // Get.lazyPut<AppDataController>(() => AppDataController());
    // Get.lazyPut<UserController>(() => UserController());
    Get.put<LoginController>(LoginController());
  }
}
