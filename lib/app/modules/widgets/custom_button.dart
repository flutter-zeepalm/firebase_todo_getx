import 'package:firstore_curd/app/data/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  const CustomButton({Key? key, this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          primary: Colors.orangeAccent,
          fixedSize: Size(Get.width, 50.h),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.r))),
      child: Text(text,
          style: CustomTextStyle.kBold18.copyWith(color: Colors.white)),
    );
  }
}
