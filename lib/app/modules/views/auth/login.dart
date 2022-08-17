// ignore_for_file: must_be_immutable

import 'package:firstore_curd/app/data/text_styles.dart';
import 'package:firstore_curd/app/modules/controllers/auth_controller.dart';
import 'package:firstore_curd/app/modules/views/auth/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_textbutton.dart';
import '../../widgets/custom_textformfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Welcome \nto FireStore \nTODO App",
                    style: CustomTextStyle.kBold18.copyWith(
                      fontSize: 40.sp,
                    )),
                SizedBox(height: 40.h),
                CustomTextFormField(
                  hintText: 'Enter Email',
                  controller: _email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!value.isEmail) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30.h),
                CustomTextFormField(
                  controller: _pass,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  hintText: "Enter Password",
                ),
                SizedBox(height: 30.h),
                CustomButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      authController.signInWithEmailAndPassword(
                          _email.text.trim(), _pass.text.trim());
                      print("Successfully Login");
                    }
                  },
                  text: "Log In",
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't Have a Account?",
                      style: CustomTextStyle.kBold18,
                    ),
                    SizedBox(width: 10.h),
                    CustomTextButton(
                      onPressed: () {
                        Get.to(() => SignupPage());
                      },
                      text: "Sign Up",
                    ),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}