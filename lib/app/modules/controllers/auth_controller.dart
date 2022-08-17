import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstore_curd/app/models/user_model.dart';
import 'package:firstore_curd/app/modules/views/auth/login.dart';
import 'package:firstore_curd/app/modules/views/home_view.dart';
import 'package:flutter_gravatar/flutter_gravatar.dart';
import 'package:get/get.dart';

import '../../../services/databasemanager.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Rx<User?> _firebaseUser = Rx<User?>(null);
  User? get user => _firebaseUser.value;
  DatabaseService db = DatabaseService();

  @override
  void onInit() {
    _firebaseUser.bindStream(_auth.authStateChanges());
    update();
    super.onInit();
  }

  // @override
  // void onReady() async {
  //   ever(firebaseUser, handleAuthChanged);
  //   firebaseUser.bindStream(user);
  //   super.onReady();
  // }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (error) {
      Get.snackbar('Login Failed', error.message!,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  Future<void> registerWithEmailAndPassword(
      {required String email,
      required String password,
      required String name}) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((result) async {
        Gravatar gravatar = Gravatar(email);
        String gravatarUrl = gravatar.imageUrl(
          size: 200,
          defaultImage: "",
          rating: "",
        );
        UserModel newUser = UserModel(
            id: result.user!.uid,
            email: result.user!.email!,
            name: name,
            pic: gravatarUrl);
        await _createUserFirestore(newUser, result.user!);
        Get.back();
      });
    } on FirebaseAuthException catch (error) {
      Get.snackbar('Sign up Failed',
          "There is some issue while creating your Account ${error.message}",
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 10),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  Future<void> _createUserFirestore(UserModel user, User firebaseUser) async {
    await db.usersCollection.doc(firebaseUser.uid).set(user.toMap());
    update();
  }

  Future<void> signOut() {
    return _auth.signOut();
  }
}
