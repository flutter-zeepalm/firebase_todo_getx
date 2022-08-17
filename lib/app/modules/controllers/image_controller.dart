import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController {
  File? image;
  late String imagePath;
  final _picker = ImagePicker();
  String? downloadUrl1;

  Future<void> getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      imagePath = pickedFile.path;
      print(imagePath);
      update();
    } else {
      Get.snackbar("No Image", "Image not Selected");
    }
  }

  Future<String?> addImageToFirebaseStorage() async {
    try {
      final firebaseStorage = FirebaseStorage.instance;
      var snapshot = await firebaseStorage
          .ref()
          .child('images/${DateTime.now()}')
          .putFile(image!);
      String downloadUrl = await snapshot.ref.getDownloadURL();
      downloadUrl1 = downloadUrl;
      return downloadUrl;
    } on FirebaseException catch (e) {
      print(e.message);
      return '';
    }
  }
}
