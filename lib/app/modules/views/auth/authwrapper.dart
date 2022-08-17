import 'package:firstore_curd/app/modules/controllers/auth_controller.dart';
import 'package:firstore_curd/app/modules/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_view.dart';
import 'login.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<AuthController>(
        init: AuthController(),
        builder: (ac) {
          if (ac.user == null) {
            return LoginPage();
          } else {
            return GetBuilder<UserController>(
                init: UserController(),
                builder: (uc) {
                  return HomeView();
                });
          }
        });
  }
}
