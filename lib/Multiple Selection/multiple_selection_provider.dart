import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vrinsoft_interview_task/Multiple%20Selection/multiple_selection_model.dart';

class MultipleSelectionProvider extends ChangeNotifier{

  MultipleSelectionModel? multipleSelectionModel;
  bool isSelectedMultipleSelection = false;
  Set<String> pickedSubInterestsId = {};
  Set<String> finalSubInterests = {};
  Set<String> pickedMainInterests = {};
  List<String> subInterestIdsToRemove = [];

  fetchInterested() async {
    final url =
    Uri.parse('https://femidedating.vrinsoft.in/api/v1/interest_list');

    final headers = {
      'accept': 'application/json',
      'X-CSRF-TOKEN': 'YVOBJ0oJacGOiKMdWhxL5scZ9dRo0gv0Wp8uonzi',
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      multipleSelectionModel = MultipleSelectionModel.fromJson(jsonDecode(response.body));
      notifyListeners();
      print("all data : ${decodedData}");
      print("multiple selection model : ${multipleSelectionModel!.data!.interestList}");
    } else {
      throw Exception('Failed to load genders');
    }
  }

  visibleOnProfile(bool? newValue) async {
    isSelectedMultipleSelection = newValue ?? false;
    print("isSelectedMultipleSelection visibleOnProfile ${isSelectedMultipleSelection}");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('multiple_selection_visible', isSelectedMultipleSelection);
    notifyListeners();
  }


  setMainInterest(List myList) async {
    String jsonString = jsonEncode(myList);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('main_interest', jsonString);
    notifyListeners();
  }

  setSubInterest(List myList) async {
    String jsonString = jsonEncode(myList);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('sub_interest', jsonString);
    notifyListeners();
  }
}