import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstore_curd/app/models/todo_model.dart';
import 'package:get/get.dart';

CollectionReference taskCollection =
    FirebaseFirestore.instance.collection('Tasks');

class DataBaseManager {
  static Future addTask(
      {required TodoModel taskModel, required String uid}) async {
    try {
      var doc = FirebaseFirestore.instance.collection('Tasks').doc();
      taskModel.id = doc.id;
      taskModel.ownerid = uid;
      await doc.set(taskModel.toMap());
    } on FirebaseException catch (e) {
      Get.snackbar(
        "error",
        e.message!,
        borderRadius: 15,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  //Get user Task
  static Future<List<TodoModel>> getUsersTask() async {
    try {
      List<TodoModel> usersTasks = [];
      var snapshot = await FirebaseFirestore.instance.collection('Tasks').get();
      for (var docs in snapshot.docs) {
        TodoModel task = TodoModel.fromMap(docs.data() as Map<String, dynamic>);
        if (task.ownerid == FirebaseAuth.instance.currentUser!.uid) {
          usersTasks.add(task);
        }
      }
      return usersTasks;
    } on FirebaseException catch (e) {
      Get.snackbar(
        "error",
        e.message!,
        borderRadius: 15,
        snackPosition: SnackPosition.BOTTOM,
      );
      return [];
    }
  }

  //Get ALL TASK

//Update Task
  static Future updateTask({required TodoModel taskModel}) async {
    try {
      await taskCollection.doc(taskModel.id).update(taskModel.toMap());
      getUsersTask();
    } on FirebaseException catch (e) {
      Get.snackbar(
        "error",
        e.message!,
        borderRadius: 15,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
