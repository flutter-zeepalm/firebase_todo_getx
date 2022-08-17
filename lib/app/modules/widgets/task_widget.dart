import 'package:expandable_text/expandable_text.dart';
import 'package:firstore_curd/app/data/text_styles.dart';
import 'package:firstore_curd/app/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskWidget extends StatelessWidget {
  VoidCallback? onTap;
  VoidCallback? deleteTap;
  String title;
  String description;

  TaskWidget({
    Key? key,
    required this.title,
    required this.description,
    this.deleteTap,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.red.withOpacity(0.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      child: Padding(
        padding: EdgeInsets.all(10.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: CustomTextStyle.kBold18),
                Row(
                  children: [
                    IconButton(
                        onPressed: deleteTap,
                        icon: Icon(Icons.delete, color: Colors.red)),
                    IconButton(
                        onPressed: onTap,
                        icon: Icon(Icons.edit, color: Colors.blue))
                  ],
                )
              ],
            ),
            ExpandableText(
              description,
              style: CustomTextStyle.kMedium16,
              expandText: 'show more',
              collapseText: 'show less',
              maxLines: 2,
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
