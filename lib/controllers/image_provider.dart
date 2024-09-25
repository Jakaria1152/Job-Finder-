import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploader extends ChangeNotifier{
  final ImagePicker _picker = ImagePicker();

  String? imageUrl;
  String? imagePath;

  List<String> imageFil = [];

  void pickImage()async{
    XFile? _imageFile = await _picker.pickImage(source: ImageSource.gallery);

    _imageFile = await cropImage(_imageFile!);
    CroppedFile? croppedFile = await ImageCropper().cropImage(sourcePath: _imageFile!.path);

    if(_imageFile != null)
      {
        imageFil.add(_imageFile.path);
        imagePath = _imageFile.path;
      }
    else
      {
        return;
      }

  }
  Future<XFile?> cropImage(XFile imageFile)async{
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
      lockAspectRatio: true
    ),
    IOSUiSettings(
      title: 'JobHub Cropper',
      cropStyle: CropStyle.rectangle
    )
  ]
);

if(croppedFile != null)
  {
    notifyListeners();
    return XFile(croppedFile.path);
  }
else{
  return null;
}
  }
}