import 'package:flutter/material.dart';

import '../../components/time.dart';

class PickDateProvider with ChangeNotifier {

  DateTimeRange? dateRange;

  void initDate() {
    if (dateRange == null) {
      DateTime today = DateTime.now();
      DateTime tomorrow = DateTime(today.year,today.month,today.day+1);
      dateRange = DateTimeRange(start: today, end: tomorrow);
      notifyListeners();
    }
  }

  void pickDate(DateTimeRange range) {
    dateRange = range;
    notifyListeners();
  }
}