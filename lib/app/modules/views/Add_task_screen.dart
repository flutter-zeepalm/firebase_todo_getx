import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstore_curd/app/data/text_styles.dart';
import 'package:firstore_curd/app/models/todo_model.dart';
import 'package:firstore_curd/app/modules/controllers/home_controller.dart';
import 'package:firstore_curd/app/modules/widgets/custom_button.dart';
import 'package:firstore_curd/app/modules/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddTodoScreenState createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String title;
  late String description;
  TodoController tc = Get.find<TodoController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        centerTitle: true,
        title: Text("Add New Task", style: CustomTextStyle.kBold18),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Add New Task",
                    style: CustomTextStyle.kBold18.copyWith(
                      fontSize: 40.sp,
                    )),
                SizedBox(height: 40.h),
                CustomTextFormField(
                  hintText: "Title",
                  controller: TextEditingController(),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Title is Required";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    title = value;
                  },
                ),
                SizedBox(height: 30.h),
                CustomTextFormField(
                  hintText: 'Description',
                  controller: TextEditingController(),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Description is Required";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    description = value;
                  },
                ),
                const Spacer(),
                CustomButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      tc.addTask(
                          taskModel: TodoModel(
                              id: "",
                              ownerid: "",
                              title: title,
                              description: description,
                              isCheck: false),
                          uid: FirebaseAuth.instance.currentUser!.uid);
                      // onFormSubmit();
                    }
                  },
                  text: 'Add Todo',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void onFormSubmit() {
  // Box<Todo> timelinetodoBox = Hive.box<Todo>(HiveBoxes.todo);
  // timelinetodoBox.add(Todo(
  // title: title,
  // description: description,
  // isCheck: false,
  // isLike: [],
  // disLike: []));
  // Get.back();
  // }
}
