import 'package:firstore_curd/app/data/text_styles.dart';
import 'package:firstore_curd/app/modules/widgets/custom_button.dart';
import 'package:firstore_curd/app/modules/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/controllers.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 70.h),
                    Text("Please\nEnter your \nPassword",
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
                    CustomButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await authController.resetPassword(
                            email: _email.text.trim(),
                          );
                          print("Successfully Login");
                        }
                      },
                      text: "Log In",
                    ),
                  ]))),
    );
  }
}
