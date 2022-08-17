import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final void Function(String)? onChanged;

  const CustomTextFormField({Key? key, required this.controller, this.validator, required this.hintText, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      decoration:  InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30)
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 20.w)
      ),
    );
  }
}
