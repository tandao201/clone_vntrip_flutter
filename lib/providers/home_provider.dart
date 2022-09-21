import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {

  int selectHomePage = 0;

  void changeHomePage(int page) {
    selectHomePage = page;
    notifyListeners();
  }
}