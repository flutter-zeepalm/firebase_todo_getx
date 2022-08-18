import 'package:firstore_curd/app/data/text_styles.dart';
import 'package:firstore_curd/app/models/todo_model.dart';
import 'package:firstore_curd/app/modules/views/update.dart';
import 'package:firstore_curd/app/modules/widgets/custom_textbutton.dart';
import 'package:firstore_curd/app/modules/widgets/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/controllers.dart';
import 'feed.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  AuthController authController = Get.find<AuthController>();
  UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('User Tasks', style: CustomTextStyle.kBold18),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: CustomTextButton(
            text: "Feed",
            onPressed: () {
              Get.to(() => FeedPage());
            }),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<TodoController>(
          init: TodoController(),
          builder: (todoController) {
            return StreamBuilder<List<TodoModel>>(
                stream: todoController.getAllTask(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  List<TodoModel>? listOfUserTasks = [];
                  List<TodoModel>? taskList = snapshot.data;
                  if (taskList!.isNotEmpty) {
                    listOfUserTasks = taskList
                        .where((element) =>
                            element.ownerid == userController.user.id)
                        .toList();
                  }
                  if (listOfUserTasks.isEmpty) {
                    return const Center(
                      child: Text("No Record Found of this User"),
                    );
                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: listOfUserTasks.length,
                      itemBuilder: (context, index) {
                        TodoModel task = listOfUserTasks![index];
                        return TaskWidget(
                          // ignore: unrelated_type_equality_checks
                          currentUser: true,
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
                });
          },
        ),
      ),
    );
  }
}
