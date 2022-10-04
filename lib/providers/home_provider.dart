import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider with ChangeNotifier {

  String LANGUAGE_CODE = "language_code";
  String COUNTRY = "country";

  int selectHomePage = 0;
  Locale? mainLocale;

  void fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString(LANGUAGE_CODE) == null) {
      print("language code null");
      mainLocale = const Locale('vi');
    } else {
      mainLocale = Locale(prefs.getString(LANGUAGE_CODE)!);
    }

    print('Language code fetch: ${mainLocale?.languageCode}');
  }

  void changeHomePage(int page) {
    selectHomePage = page;
    notifyListeners();
  }

  void changeLocale() async {
    var prefs = await SharedPreferences.getInstance();
    String country = "VN";
    if (mainLocale!.languageCode == "vi"){
      mainLocale = const Locale("en");
    } else {
      country = "USUK";
      mainLocale = const Locale("vi");
    }
    print('Language code from provider: ${mainLocale?.languageCode}');
    await prefs.setString(LANGUAGE_CODE, mainLocale!.languageCode);
    await prefs.setString(COUNTRY, country);

    notifyListeners();
  }
}