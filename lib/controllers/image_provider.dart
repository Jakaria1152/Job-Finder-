import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ImageUploader extends ChangeNotifier {
  var uuid = const Uuid();
  final ImagePicker _picker = ImagePicker();

  String? imageUrl;
  String? imagePath;

  List<String> imageFil = [];

  void pickImage() async {
    XFile? imageFile = await _picker.pickImage(source: ImageSource.gallery);

    imageFile = await cropImage(imageFile!);

    if (imageFile != null) {
      imageFil.add(imageFile.path);
      // ai function upload function ke call korbe image store korar jonno
     imageUpload(imageFile);
      imagePath = imageFile.path;
    } else {
      return;
    }
  }

  Future<XFile?> cropImage(XFile imageFile) async {
    CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
        sourcePath: imageFile.path,
        maxHeight: 800,
        maxWidth: 600,
        compressQuality: 70,
        // aspectRatio: [CropAspectRatioPreset.ratio5x4],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'JobHub Cropper',
              toolbarColor: Colors.lightBlue,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.ratio5x4,
              cropStyle: CropStyle.rectangle,
              lockAspectRatio: true),
          IOSUiSettings(title: 'JobHub Cropper', cropStyle: CropStyle.rectangle)
        ]);

    if (croppedFile != null) {
      notifyListeners();
      return XFile(croppedFile.path);
    } else {
      return null;
    }
  }

  // ai function firebase stroage a picture store korbe
  Future<String?> imageUpload(XFile upload) async {
    File image = File(upload.path);

    // jobhun nam e folder create hobe then tar vitore image store hobe
    final ref = FirebaseStorage.instance
        .ref()
        .child('jobhub')
        .child('${uuid.v1()}.jpg');
    // image ke store kora hosse
    await ref.putFile(image);

    imageUrl = (await ref.getDownloadURL());
    print(imageUrl);

    return imageUrl;
  }
}
