import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  bool showPopup = true;

  changeState() {
    showPopup = !showPopup;
    notifyListeners();
  }
}
