import 'package:firstore_curd/app/modules/controllers/auth_controller.dart';
import 'package:get/get.dart';

import '../controllers/controllers.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
    Get.lazyPut<UserController>(() => UserController());
    Get.lazyPut<TodoController>(() => TodoController());
  }
}
