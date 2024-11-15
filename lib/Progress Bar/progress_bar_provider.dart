import 'package:flutter/material.dart';

class ProgressBarProvider extends ChangeNotifier{

  double _progress = 0.0;

  double get progress => _progress;

  void updateProgress(double newProgress) {
    _progress = newProgress;
    print("_progress in updateProgress is ${_progress}");
    notifyListeners();
  }
}