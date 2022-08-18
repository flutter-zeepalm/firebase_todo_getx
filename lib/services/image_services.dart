import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firstore_curd/app/modules/widgets/Dialogs/loading_dialog.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageService {
  File? image;
  final _picker = ImagePicker();

  Future<File?> getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      return image;
    } else {
      Get.snackbar("No Image", "Image not Selected");
      return null;
    }
  }
}

class StorageServices {
  final firebaseStorage = FirebaseStorage.instance;

  Future<String?> uploadToStorage(File image) async {
    showLoadingDialog();
    try {
      String downloadUrl = '';
      var snapshot = await firebaseStorage
          .ref()
          .child('images/${DateTime.now()}')
          .putFile(image);
      downloadUrl = await snapshot.ref.getDownloadURL();
      dismissLoadingDialog();
      return downloadUrl;
    } on Exception catch (e) {
      dismissLoadingDialog();

      return null;
    }
  }
}
