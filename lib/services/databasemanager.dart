import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  CollectionReference taskCollection =
      FirebaseFirestore.instance.collection('Tasks');

  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
}
