import 'package:firstore_curd/app/modules/controllers/auth_controller.dart';
import 'package:firstore_curd/app/modules/controllers/image_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
    Get.lazyPut<ImageController>(() => ImageController(), fenix: true);
    Get.lazyPut<TodoController>(() => TodoController());
  }
}
