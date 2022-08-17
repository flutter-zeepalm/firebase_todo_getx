import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstore_curd/app/models/todo_model.dart';
import 'package:firstore_curd/services/databasemanager.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class TodoController extends GetxController {
  DatabaseService db = DatabaseService();

  Future addTask({required TodoModel taskModel, required String uid}) async {
    try {
      await DataBaseManager.addTask(taskModel: taskModel, uid: uid);
      Get.back();
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "error",
        e.message!,
      );
    }
  }

  Stream<List<TodoModel>> getAllTask() {
    return db.taskCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return TodoModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<List<TodoModel>> getUsersTask() async {
    try {
      List<TodoModel> usersTasks = [];
      var snapshot = await FirebaseFirestore.instance.collection('Tasks').get();
      for (var docs in snapshot.docs) {
        TodoModel task = TodoModel.fromMap(docs.data());
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

  Future<void> updateTaskfun({
    required TodoModel taskModel,
  }) async {
    dynamic res = await DataBaseManager.updateTask(taskModel: taskModel);
    try {
      if (res == null) {
      } else {
        if (kDebugMode) {
          print('somethings went wrong');
        }
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "error",
        e.message!,
        borderRadius: 15,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future deleteTask({required TodoModel taskModel}) async {
    try {
      await db.taskCollection.doc(taskModel.id).delete();
    } on FirebaseException catch (error) {
      Get.snackbar("Error", error.message.toString());
    }
  }

  Future<void> addDisLike(TodoModel task) async {
    if (task.dislikes.contains(task.ownerid)) {
      task.dislikes.remove(task.ownerid);
    } else if (task.likes.contains(task.ownerid)) {
      task.likes.remove(task.ownerid);
      task.dislikes.add(task.ownerid);
    } else {
      task.dislikes.add(task.ownerid);
    }
    await DataBaseManager.updateTask(taskModel: task);
    print(task.dislikes.length);
    update();
  }

  Future<void> addLike(TodoModel task) async {
    if (task.likes.contains(task.ownerid)) {
      task.likes.remove(task.ownerid);
    } else if (task.dislikes.contains(task.ownerid)) {
      task.dislikes.remove(task.ownerid);
      task.likes.add(task.ownerid);
    } else {
      task.likes.add(task.ownerid);
    }
    await DataBaseManager.updateTask(taskModel: task);
    print(task.dislikes.length);
    update();
  }
}
