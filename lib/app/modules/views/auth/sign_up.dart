import 'package:firstore_curd/app/data/text_styles.dart';
import 'package:firstore_curd/app/modules/controllers/auth_controller.dart';
import 'package:firstore_curd/app/modules/widgets/custom_button.dart';
import 'package:firstore_curd/app/modules/widgets/custom_textbutton.dart';
import 'package:firstore_curd/app/modules/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'login.dart';

class SignupPage extends StatelessWidget {
  SignupPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _name = TextEditingController();
  AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Create\nYour\nAccount",
                    style: CustomTextStyle.kBold18.copyWith(
                      fontSize: 40.sp,
                    )),
                SizedBox(height: 40.h),
                CustomTextFormField(
                  controller: _name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Name';
                    }
                    return null;
                  },
                  hintText: "Enter Name",
                ),
                SizedBox(height: 30.h),
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      authController.registerWithEmailAndPassword(
                          _email.text.trim(),
                          _pass.text.trim(),
                          _name.text.trim());
                    }
                  },
                  text: "Sign Up",
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already Have Account ?",
                        style: CustomTextStyle.kBold18),
                    CustomTextButton(
                      onPressed: () {
                        Get.to(() => LoginPage());
                      },
                      text: "Sign In",
                    ),
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
