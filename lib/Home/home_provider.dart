import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vrinsoft_interview_task/Single%20Selection/single_selection_screen.dart';
import 'package:vrinsoft_interview_task/Upload%20Photos/upload_photos_provider.dart';

import '../main.dart';

class HomeProvider extends ChangeNotifier{
  String mainGender = '';
  String subGender = '';
  List mainInterestList = [];
  List subInterestList = [];
  bool singleSelectionVisible = false;
  bool multipleSelectionVisible = false;
  List<XFile>? loadedImages;

  Future<List<XFile>> loadImagesFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('saved_images');
    if (jsonString == null) return [];
    List<String> imagePaths = List<String>.from(jsonDecode(jsonString));
    notifyListeners();
    return imagePaths.map((path) => XFile(path)).toList();
  }

  loadTextFromPrefs() async {
    loadedImages = await loadImagesFromPrefs();
    print("loadedImages ${loadedImages}");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mainGender = prefs.getString('main_gender') ?? '';
    subGender = prefs.getString('sub_gender') ?? '';
    loadBoolFromPrefs();
    print("main : ${mainGender} sub : ${subGender}");
    notifyListeners();
  }

  loadBoolFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    singleSelectionVisible = prefs.getBool('single_selection_visible') ?? false;
    multipleSelectionVisible = prefs.getBool('multiple_selection_visible') ?? false;
    loadInterestPrefs();
    notifyListeners();
    print("singleSelectionVisible : ${singleSelectionVisible} multipleSelectionVisible : ${multipleSelectionVisible}");
  }

  loadInterestPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String mainInterest = prefs.getString('main_interest') ?? "";
    String subInterest = prefs.getString('sub_interest') ?? "";
    notifyListeners();
    print("mainInterest ${mainInterest} subInterest ${subInterest}");
    if (mainInterest != "") {
      mainInterestList = jsonDecode(mainInterest);
      print("mainInterestList :: ${mainInterestList}");
    }
    if(subInterest != ""){
      subInterestList = jsonDecode(subInterest);
      print("subInterestList :: ${subInterestList}");
    }
  }

  logout(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SingleSelectionScreen()),
          (route) => false,
    );
  }

}