import 'package:firstore_curd/app/data/text_styles.dart';
import 'package:firstore_curd/app/models/todo_model.dart';
import 'package:firstore_curd/app/modules/controllers/auth_controller.dart';
import 'package:firstore_curd/app/modules/controllers/home_controller.dart';
import 'package:firstore_curd/app/modules/views/Add_task_screen.dart';
import 'package:firstore_curd/app/modules/views/update.dart';
import 'package:firstore_curd/app/modules/widgets/custom_textbutton.dart';
import 'package:firstore_curd/app/modules/widgets/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  AuthController authController = Get.find<AuthController>();
  TodoController todoController = Get.find<TodoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('HomeView', style: CustomTextStyle.kBold18),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
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
          GetBuilder<AuthController>(
              init: AuthController(),
              builder: (ac) => ac.firestoreUser.value!.id == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Row(
                      children: [
                        CircleAvatar(
                            radius: 50.r,
                            backgroundImage:
                                NetworkImage(ac.firestoreUser.value!.pic)),
                        SizedBox(width: 10.w),
                        Column(
                          children: [
                            Text(
                              ac.firestoreUser.value!.name,
                              style: CustomTextStyle.kBold20,
                            ),
                            Text(
                              ac.firestoreUser.value!.email,
                              style: CustomTextStyle.kBold20,
                            ),
                            Text(
                              ac.firestoreUser.value!.id,
                              style: CustomTextStyle.kBold20,
                            )
                          ],
                        ),
                      ],
                    )),
          StreamBuilder<List<TodoModel>>(
              stream: todoController.getAllTask(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                List<TodoModel>? taskList = snapshot.data;
                if (taskList!.isEmpty) {
                  return const Center(
                    child: Text("No Data found"),
                  );
                }
                return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: taskList.length,
                    itemBuilder: (context, index) {
                      TodoModel task = taskList[index];
                      return TaskWidget(
                        title: task.title,
                        description: task.description,
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
