import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vrinsoft_interview_task/Single%20Selection/single_selection_model.dart';
import 'package:vrinsoft_interview_task/Single%20Selection/single_selection_screen.dart';
import 'package:vrinsoft_interview_task/main.dart';
import 'package:vrinsoft_interview_task/utils/common_provider/internet_provider.dart';

import '../Home/home_screen.dart';

class SingleSelectionProvider extends ChangeNotifier {
  SingleSelectionModel? singleSelectionModel;
  String selectedMainGender = '';
  int? selectedGenderId;
  String? pickedSubGender;
  bool isSelectedSingleSelection = false;

  fetchGenders(context) async {
    final url =
        Uri.parse('https://femidedating.vrinsoft.in/api/v1/gender_list');

    final headers = {
      'accept': 'application/json',
      'X-CSRF-TOKEN': 'YVOBJ0oJacGOiKMdWhxL5scZ9dRo0gv0Wp8uonzi',
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      singleSelectionModel =
          SingleSelectionModel.fromJson(jsonDecode(response.body));
      notifyListeners();
      print("all data : ${decodedData}");
      print("singleSelectionModel : ${singleSelectionModel!.data!.genderList}");
    } else {
      throw Exception('Failed to load genders');
    }
  }

  mainGenderChange(int? value, String? title) {
    selectedGenderId = value;
    pickedSubGender = '';
    pickedSubGender = '';
    selectedMainGender = title!;
    notifyListeners();
  }

  void setMainGender(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('main_gender', value);
  }

  void setSubGender(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('sub_gender', value);
  }

  subGenderChange(
    String? title,
  ) {
    pickedSubGender = title!;
    pickedSubGender = title;
    notifyListeners();
  }

  visibleOnProfile(bool? newValue) async {
    isSelectedSingleSelection = newValue ?? false;
    print(
        "isSelectedSingleSelection visibleOnProfile ${isSelectedSingleSelection}");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('single_selection_visible', isSelectedSingleSelection);
    notifyListeners();
  }

  checkNavigation(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    print("isLoggedIn ${isLoggedIn}");
    if (isLoggedIn) {
      print("isLoggedIn is true");
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false,
      );
    } else {
      print("isLoggedIn is false");
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => SingleSelectionScreen()));
    }
  }
}
