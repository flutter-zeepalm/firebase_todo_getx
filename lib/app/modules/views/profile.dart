import 'package:firstore_curd/app/data/text_styles.dart';
import 'package:firstore_curd/app/models/user_model.dart';
import 'package:firstore_curd/app/modules/widgets/custom_button.dart';
import 'package:firstore_curd/app/modules/widgets/custom_textbutton.dart';
import 'package:firstore_curd/app/modules/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/controllers.dart';

class MyProfile extends StatelessWidget {
  MyProfile({Key? key}) : super(key: key);
  UserController userController = Get.find<UserController>();
  AuthController authController = Get.find<AuthController>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "My Profile",
          style: CustomTextStyle.kBold18,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: FutureBuilder<UserModel?>(
            future: userController.getCurrentUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              UserModel currentUser = snapshot.data!;
              return Column(
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 50.r,
                      backgroundColor: Colors.grey.withOpacity(0.5),
                      backgroundImage: NetworkImage(currentUser.pic!),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  CustomTextFormField(
                      controller: _nameController, hintText: currentUser.name!),
                  SizedBox(height: 20.h),
                  CustomTextFormField(
                      controller: _emailController,
                      hintText: currentUser.email!),
                  SizedBox(height: 20.h),
                  CustomButton(
                      text: "Update",
                      onPressed: () {
                        authController.updateUserEmail(
                            newEmail: _emailController.text.trim(),
                            name: _nameController.text.trim());
                      }),
                  Center(
                    child: CustomTextButton(
                        text: "Sign out",
                        onPressed: () {
                          authController.signOut();
                        }),
                  )
                ],
              );
            }),
      ),
    );
  }
}
