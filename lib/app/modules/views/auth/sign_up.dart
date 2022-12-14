import 'dart:io';

import 'package:firstore_curd/app/data/text_styles.dart';
import 'package:firstore_curd/app/modules/controllers/auth_controller.dart';
import 'package:firstore_curd/services/image_services.dart';
import 'package:firstore_curd/app/modules/widgets/custom_button.dart';
import 'package:firstore_curd/app/modules/widgets/custom_textbutton.dart';
import 'package:firstore_curd/app/modules/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _name = TextEditingController();
  AuthController authController = Get.find<AuthController>();
  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Form(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: 50.h),
            Text("Create Your Account",
                style: CustomTextStyle.kBold18.copyWith(
                  fontSize: 30.sp,
                )),
            SizedBox(height: 20.h),
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 60.r,
                    backgroundColor: Colors.grey.withOpacity(0.09),
                    child: image != null
                        ? ClipOval(
                            clipBehavior: Clip.antiAlias,
                            child: Image.file(
                              image!,
                              height: 200.h,
                              width: 200.w,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Icon(
                            Icons.person,
                            size: 50.h,
                            color: Colors.black,
                          ),
                  ),
                  CircleAvatar(
                      backgroundColor: Colors.orange,
                      child: IconButton(
                          onPressed: () async {
                            File? pickedFile = await ImageService().getImage();
                            if (pickedFile != null) {
                              image = pickedFile;
                              setState(() {});
                            }
                          },
                          icon: Icon(Icons.add, color: Colors.white)))
                ],
              ),
            ),
            SizedBox(height: 30.h),
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
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  if (image == null) {
                    Get.snackbar('Error', 'Please select an image',
                        backgroundColor: Colors.red, colorText: Colors.white);
                    return;
                  }
                  String? imageUrl =
                      await StorageServices().uploadToStorage(image!);
                  await authController
                      .registerWithEmailAndPassword(
                          email: _email.text.trim(),
                          password: _pass.text.trim(),
                          image: imageUrl ?? '',
                          name: _name.text.trim())
                      .then((value) => Get.back());
                }
              },
              text: "Sign Up",
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already Have Account ?", style: CustomTextStyle.kBold18),
                CustomTextButton(
                  onPressed: () {
                    Get.back();
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
