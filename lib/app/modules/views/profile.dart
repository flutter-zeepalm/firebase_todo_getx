import 'package:firstore_curd/app/data/text_styles.dart';
import 'package:firstore_curd/app/models/user_model.dart';
import 'package:firstore_curd/app/modules/widgets/custom_textbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/controllers.dart';

class MyProfile extends StatelessWidget {
  MyProfile({Key? key}) : super(key: key);
  UserController userController = Get.find<UserController>();
  AuthController authController = Get.find<AuthController>();
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
        child: Column(
          children: [
            FutureBuilder<UserModel?>(
                future: userController.getCurrentUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  UserModel currentUser = snapshot.data!;
                  return Row(
                    children: [
                      CircleAvatar(
                        radius: 50.r,
                        backgroundColor: Colors.grey.withOpacity(0.5),
                        backgroundImage: NetworkImage(currentUser.pic!),
                      ),
                      SizedBox(width: 20.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(currentUser.name!.capitalizeFirst.toString(),
                                style: CustomTextStyle.kBold18),
                            Text(currentUser.email!,
                                style: CustomTextStyle.kMedium16),
                            Text(currentUser.id,
                                style: CustomTextStyle.kMedium14),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
            SizedBox(height: 20.h),
            Center(
              child: CustomTextButton(
                  text: "Sign out",
                  onPressed: () {
                    authController.signOut();
                  }),
            )
          ],
        ),
      ),
    );
  }
}
