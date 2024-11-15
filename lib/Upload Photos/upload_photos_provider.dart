import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vrinsoft_interview_task/Home/home_screen.dart';

class UploadPhotosProvider extends ChangeNotifier {
  List<XFile>? _imageFileList;

  List<XFile>? get imageFileList => _imageFileList;

  void pickImage(context) async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? selectedImages = await _picker.pickMultiImage();

    if (selectedImages != null && selectedImages.length <= 3) {
      _imageFileList = selectedImages;
      print("_imageFileList ::: ${_imageFileList}");
      saveImagesToPrefs(_imageFileList!);
      notifyListeners();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a maximum of 3 images.'),
        ),
      );
    }
  }

  Future<void> saveImagesToPrefs(List<XFile> imageFileList) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> imagePaths = imageFileList.map((file) => file.path).toList();
    String jsonString = jsonEncode(imagePaths);
    await prefs.setString('saved_images', jsonString);
  }

  void removeImage(int index) {
    _imageFileList?.removeAt(index);
    saveImagesToPrefs(_imageFileList!);
    print("_imageFileList in removeImage :: ${_imageFileList}");
    notifyListeners();
  }

  checkValidation(context) async {
    if (imageFileList != null && imageFileList!.isNotEmpty) {
      print("Go for home screen with this image data ${imageFileList}");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false,
      );
    } else {
      print("validation failed in upload photos screen");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select image'),
        ),
      );
    }
  }
}
