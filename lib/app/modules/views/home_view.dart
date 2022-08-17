import 'package:firstore_curd/app/data/text_styles.dart';
import 'package:firstore_curd/app/models/todo_model.dart';
import 'package:firstore_curd/app/models/user_model.dart';
import 'package:firstore_curd/app/modules/controllers/auth_controller.dart';
import 'package:firstore_curd/app/modules/controllers/home_controller.dart';
import 'package:firstore_curd/app/modules/controllers/user_controller.dart';
import 'package:firstore_curd/app/modules/views/Add_task_screen.dart';
import 'package:firstore_curd/app/modules/views/update.dart';
import 'package:firstore_curd/app/modules/widgets/custom_textbutton.dart';
import 'package:firstore_curd/app/modules/widgets/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'feed.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  AuthController authController = Get.find<AuthController>();
  TodoController todoController = Get.find<TodoController>();
  UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('HomeView', style: CustomTextStyle.kBold18),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: CustomTextButton(
            text: "Feed",
            onPressed: () {
              Get.to(() => FeedPage());
            }),
        actions: [
          Center(
            child: CustomTextButton(
                text: "Sign out",
                onPressed: () {
                  authController.signOut();
                }),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
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
          FutureBuilder<List<TodoModel>>(
              future: todoController.getUsersTask(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                List<TodoModel>? taskList = snapshot.data;
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
                        dislikeTap: () async {
                          await todoController.addDisLike(task);
                        },
                        likeTap: () async {
                          await todoController.addLike(task);
                        },
                        todo: task,
                        onTap: () {
                          Get.to(() => UpdateScreen(uptodo: task));
                        },
                        deleteTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  'Are you sure want to delete..?',
                                  style: TextStyle(fontSize: 15),
                                ),
                                actions: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            todoController.deleteTask(
                                                taskModel: task);
                                            Get.back();
                                          },
                                          child: Text('Yes')),
                                      TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: Text('No'))
                                    ],
                                  )
                                ],
                              );
                            },
                          );
                        },
                      );
                    });
              })
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddTodoScreen());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
