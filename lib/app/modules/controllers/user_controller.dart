import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstore_curd/services/databasemanager.dart';
import 'package:get/get.dart';

import '../../models/user_model.dart';
import 'auth_controller.dart';

class UserController extends GetxController {
  DatabaseService db = DatabaseService();
  Rx<UserModel?> _userModel = UserModel(id: "").obs;
  AuthController authController = Get.find<AuthController>();

  UserModel get user => _userModel.value!;

  Future<UserModel> getCurrentUser()async{
    return await db.usersCollection.doc(authController.user!.uid).get().then((doc){
      return UserModel.fromMap(doc.data() as Map<String,dynamic>);
    });
  }




  // Stream<DocumentSnapshot> get currentUserStream {
  //   return db.usersCollection
  //       .doc(Get.find<AuthController>().user!.uid)
  //       .snapshots();
  // }

  @override
  Future<void> onReady() async{
   _userModel.value = await getCurrentUser();

    super.onReady();
  }
}
