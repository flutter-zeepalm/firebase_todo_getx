import 'package:firstore_curd/app/data/text_styles.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  const CustomTextButton({Key? key, this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text,
          style: CustomTextStyle.kMedium16.copyWith(color: Colors.red)),
    );
  }
}
