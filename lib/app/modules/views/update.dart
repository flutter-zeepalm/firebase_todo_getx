import 'package:firstore_curd/app/data/text_styles.dart';
import 'package:firstore_curd/app/models/todo_model.dart';
import 'package:firstore_curd/app/modules/widgets/custom_button.dart';
import 'package:firstore_curd/app/modules/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/controllers.dart';

class UpdateScreen extends StatefulWidget {
  final TodoModel uptodo;

  const UpdateScreen({
    Key? key,
    required this.uptodo,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.uptodo.title;
    descriptionController.text = widget.uptodo.description;
  }

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
        title: Text("Update Task", style: CustomTextStyle.kBold18),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50.h),
              Text("Update Your Task",
                  style: CustomTextStyle.kBold18.copyWith(
                    fontSize: 40.sp,
                  )),
              SizedBox(height: 40.h),
              CustomTextFormField(
                controller: titleController,
                hintText: "Title",
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Title is Required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 30.h),
              CustomTextFormField(
                hintText: 'Description',
                controller: descriptionController,
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Description is Required";
                  }
                  return null;
                },
              ),
              const Spacer(),
              CustomButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Get.back();
                      tc.updateTask(TodoModel(
                          title: titleController.text.trim(),
                          likes: widget.uptodo.likes,
                          dislikes: widget.uptodo.dislikes,
                          description: descriptionController.text.trim(),
                          id: widget.uptodo.id,
                          isCheck: widget.uptodo.isCheck,
                          ownerid: widget.uptodo.ownerid));
                    }
                  },
                  text: 'Update Todo'),
              SizedBox(height: 50.h)
            ],
          ),
        ),
      ),
    );
  }
}
