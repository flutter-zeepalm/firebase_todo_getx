// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:firstore_curd/app/data/text_styles.dart';
import 'package:firstore_curd/app/models/todo_model.dart';

class TaskWidget extends StatelessWidget {
  VoidCallback? onTap;
  VoidCallback? deleteTap;
  VoidCallback? likeTap;
  VoidCallback? dislikeTap;
  bool currentUser;
  TodoModel todo;

  TaskWidget({
    Key? key,
    required this.currentUser,
    this.onTap,
    this.deleteTap,
    this.likeTap,
    this.dislikeTap,
    required this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
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
                Text(todo.title, style: CustomTextStyle.kBold18),
                currentUser
                    ? Row(
                        children: [
                          IconButton(
                              onPressed: deleteTap,
                              icon: Icon(Icons.delete, color: Colors.red)),
                          IconButton(
                              onPressed: onTap,
                              icon: Icon(Icons.edit, color: Colors.blue))
                        ],
                      )
                    : SizedBox()
              ],
            ),
            ExpandableText(
              todo.description,
              style: CustomTextStyle.kMedium16,
              expandText: 'show more',
              collapseText: 'show less',
              maxLines: 2,
            ),
            SizedBox(height: 10.h),
            Divider(height: 0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: likeTap,
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )),
                    Text(
                      "${todo.likes.length} likes",
                      style: CustomTextStyle.kBold18,
                    )
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: dislikeTap,
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.grey,
                        )),
                    Text(
                      "${todo.dislikes.length} dislikes",
                      style: CustomTextStyle.kBold18,
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
