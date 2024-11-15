import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class InternetProvider extends ChangeNotifier {


  bool isInterNetAvailable = false;
  Connectivity connectivity = Connectivity();

  Future<void> initializeInternet() async {
    try {
      ConnectivityResult result = await connectivity.checkConnectivity();
      await checkInterNetStatus(result);
      connectivity.onConnectivityChanged.listen(checkInterNetStatus);
    } catch (e) {
      debugPrint(e.toString());
      checkInterNetStatus(ConnectivityResult.none);
    }
  }

  Future<void> checkInterNetStatus(ConnectivityResult result) async {
    try {
      if (result == ConnectivityResult.mobile) {
        debugPrint("isOnline");
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          isInterNetAvailable = true;
          notifyListeners();
        } else {
          isInterNetAvailable = false;
          notifyListeners();
        }
      } else if (result == ConnectivityResult.wifi) {
        debugPrint("wifi");
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          isInterNetAvailable = true;
          notifyListeners();
        } else {
          isInterNetAvailable = false;
          notifyListeners();
        }
      } else if(result==ConnectivityResult.none) {
        debugPrint("offline");
        isInterNetAvailable = false;

        notifyListeners();
      }
    } on SocketException catch (_) {
      isInterNetAvailable = false;
      notifyListeners();
    }
  }
}
