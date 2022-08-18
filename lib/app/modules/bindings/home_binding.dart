import 'package:firstore_curd/app/modules/controllers/auth_controller.dart';
import 'package:get/get.dart';

import '../controllers/todo_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
    Get.lazyPut<TodoController>(() => TodoController());
  }
}
