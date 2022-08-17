import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstore_curd/app/models/user_model.dart';
import 'package:firstore_curd/app/modules/views/auth/login.dart';
import 'package:firstore_curd/app/modules/views/home_view.dart';
import 'package:flutter_gravatar/flutter_gravatar.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Rxn<User> firebaseUser = Rxn<User>();
  Rxn<UserModel> firestoreUser = Rxn<UserModel>();

  @override
  void onReady() async {
    ever(firebaseUser, handleAuthChanged);
    firebaseUser.bindStream(user);
    super.onReady();
  }

  handleAuthChanged(firebaseUser) async {
    if (firebaseUser == null) {
      print('Send to signin');
      Get.to(() => LoginPage());
    } else {
      Get.offAll(() => HomeView());
    }
  }

  Future<User> get getUser async => _auth.currentUser!;
  Stream<User?> get user => _auth.authStateChanges();

  Stream<UserModel> streamFirestoreUser() {
    print('streamFirestoreUser()');

    return _db
        .doc('/users/${firebaseUser.value!.uid}')
        .snapshots()
        .map((snapshot) => UserModel.fromMap(snapshot.data()!));
  }

  Future<UserModel> getFirestoreUser() {
    return _db.doc('/users/${firebaseUser.value!.uid}').get().then(
        (documentSnapshot) => UserModel.fromMap(documentSnapshot.data()!));
  }

  signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (error) {
      Get.snackbar('Login Failed', 'There is some error!',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  registerWithEmailAndPassword(
      //
      String email,
      String password,
      String name) async {
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
        _createUserFirestore(newUser, result.user!);
      });
    } on FirebaseAuthException catch (error) {
      Get.snackbar('Sign up Failed',
          "There is some issue while creating your Account $error",
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 10),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  void _createUserFirestore(UserModel user, User firebaseUser) {
    _db.doc('/users/${firebaseUser.uid}').set(user.toMap());
    update();
  }

  Future<void> signOut() {
    return _auth.signOut();
  }
}
