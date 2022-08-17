import 'package:firstore_curd/app/modules/controllers/auth_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<TodoController>(() => TodoController());
  }
}
