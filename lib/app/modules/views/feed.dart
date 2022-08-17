import 'package:firstore_curd/app/data/text_styles.dart';
import 'package:firstore_curd/app/models/todo_model.dart';
import 'package:firstore_curd/app/modules/widgets/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class FeedPage extends StatelessWidget {
  FeedPage({Key? key}) : super(key: key);

  TodoController todoController = Get.find<TodoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feed', style: CustomTextStyle.kBold18),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            }),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          SizedBox(height: 20.h),
          StreamBuilder<List<TodoModel>>(
              stream: todoController.getAllTask(),
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
                      );
                    });
              })
        ]),
      ),
    );
  }
}
