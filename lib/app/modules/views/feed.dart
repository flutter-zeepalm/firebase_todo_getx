import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstore_curd/app/data/text_styles.dart';
import 'package:firstore_curd/app/models/todo_model.dart';
import 'package:firstore_curd/app/modules/widgets/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/controllers.dart';

class FeedPage extends StatelessWidget {
  FeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feed', style: CustomTextStyle.kBold18),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            }),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          SizedBox(height: 20.h),
          GetBuilder<TodoController>(
              init: TodoController(),
              builder: (tc) {
                return StreamBuilder<List<TodoModel>?>(
                    stream: tc.getAllTask(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      List<TodoModel>? taskList = snapshot.data;
                      List<TodoModel>? specificUser = [];
                      if (taskList!.isEmpty) {
                        return const Center(
                          child: Text("No Record Found of this User"),
                        );
                      }
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: taskList.length,
                          itemBuilder: (context, index) {
                            TodoModel task = taskList[index];
                            return TaskWidget(
                              // ignore: unrelated_type_equality_checks
                              currentUser: task.ownerid ==
                                      FirebaseAuth.instance.currentUser!.uid
                                  ? true
                                  : false,
                              dislikeTap: () async {
                                await tc.addDisLike(task);
                              },
                              likeTap: () async {
                                await tc.addLike(task);
                              },
                              todo: task,
                            );
                          });
                    });
              })
        ]),
      ),
    );
  }
}
