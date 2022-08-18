// ignore_for_file: prefer_final_fields

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstore_curd/app/models/user_model.dart';
import 'package:firstore_curd/app/modules/widgets/Dialogs/loading_dialog.dart';
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

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    showLoadingDialog();
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      dismissLoadingDialog();
    } on FirebaseAuthException catch (error) {
      dismissLoadingDialog();
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
      required String name,
      required String image}) async {
    showLoadingDialog();
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((result) async {
        UserModel newUser = UserModel(
            id: result.user!.uid,
            email: result.user!.email!,
            name: name,
            pic: image);
        await _createUserFirestore(newUser, result.user!);
        dismissLoadingDialog();
      });
    } on FirebaseAuthException catch (error) {
      dismissLoadingDialog();
      Get.snackbar('Sign up Failed', error.message.toString(),
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

  Future<void> updateUserEmail(
      {required String newEmail, required String name}) async {
    showLoadingDialog();
    try {
      await _auth.currentUser!.updateEmail(newEmail).then((result) async {
        db.usersCollection
            .doc(_auth.currentUser!.uid)
            .update({'email': newEmail, 'name': name});
        dismissLoadingDialog();
      });
    } on FirebaseException catch (error) {
      dismissLoadingDialog();
      Get.snackbar('Update Failed', error.message.toString(),
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 10),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  resetPassword({required String email}) async {
    showLoadingDialog();
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email)
          .then((value) => Get.back());
      dismissLoadingDialog();
      Get.snackbar(
          "Password Reset", "Your Email Verfication Code has been Sent");
    } on FirebaseAuthException catch (e) {
      dismissLoadingDialog();
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Get.snackbar("Password Reset", e.message!);
      }
    }
  }

  void signOut() async {
    return await _auth.signOut();
  }
}
