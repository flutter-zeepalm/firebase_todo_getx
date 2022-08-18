import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class WaitingDialog extends StatelessWidget {
  const WaitingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          SizedBox(width: 20.0),
          Text('Please wait...'),
        ],
      ),
    );
  }
}

Future<void> showLoadingDialog() async {
  await Get.dialog(WaitingDialog(), barrierDismissible: true);
}

void dismissLoadingDialog() {
  Get.back();
}
