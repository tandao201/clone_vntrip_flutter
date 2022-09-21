import 'package:intl/intl.dart';

class Time {

  static var dayEnToVi = {
    'Monday': 'Thứ Hai',
    'Tuesday': 'Thứ Ba',
    'Wednesday': 'Thứ Tư',
    'Thursday': 'Thứ Năm',
    'Friday': 'Thứ Sáu',
    'Saturday': 'Thứ Bảy',
    'Sunday': 'Chủ Nhật'
  };

  static var dayEnToVi2 = {
    'Monday': 'Th 2',
    'Tuesday': 'Th 3',
    'Wednesday': 'Th 4',
    'Thursday': 'Th 5',
    'Friday': 'Th 6',
    'Saturday': 'Th 7',
    'Sunday': 'Cn'
  };

  static String getCurrentDate() {
    var now = DateTime.now();
    var formatter = DateFormat('dd/MM/yyyy');
    String formattedDayOfWeek = DateFormat('EEEE').format(now);
    String formattedDate = formatter.format(now);
    return '${dayEnToVi[formattedDayOfWeek]} - $formattedDate';
  }

  static String formatTime(DateTime time) {
    var formatter = DateFormat('dd/MM/yyyy');
    String formattedDayOfWeek = DateFormat('EEEE').format(time);
    String formattedDate = formatter.format(time);
    return '${dayEnToVi[formattedDayOfWeek]} - $formattedDate';
  }

  static String formatTimeFromString(String date) {
    DateTime time = DateFormat("yyyy-MM-dd").parse(date.substring(0,10));
    var formatter = DateFormat('dd/MM/yyyy');
    String formattedDayOfWeek = DateFormat('EEEE').format(time);
    String formattedDate = formatter.format(time);
    return '${dayEnToVi[formattedDayOfWeek]} - $formattedDate';
  }

  static String formatTimeStringFromString(String date) {
    DateTime time = DateFormat("yyyy-MM-dd").parse(date.substring(0,10));
    var formatter = DateFormat('yyyyMMdd');
    String formattedDate = formatter.format(time);
    return formattedDate;
  }

  static String formatTimeStringFromStringApi(String date) {
    DateTime time = DateFormat("yyyy-MM-dd").parse(date.substring(0,10));
    var formatter = DateFormat('dd/MM/yyyy');
    String formattedDate = formatter.format(time);
    return formattedDate;
  }

  static String formatTimeVi(DateTime time) {
    var formatter = DateFormat('dd/MM');
    String formattedDayOfWeek = DateFormat('EEEE').format(time);
    String formattedDate = formatter.format(time);
    return '${dayEnToVi2[formattedDayOfWeek]}, $formattedDate';
  }

  static int getDateRange(DateTime time1, DateTime time2) {
    return time2.difference(time1).inDays == 0? 1 : time2.difference(time1).inDays;
  }

  static String getDateString(DateTime time) {
    var formatter = DateFormat('yyyyMMdd');
    return formatter.format(time);
  }

  static String getDayAndMonth(String dateString) {
    DateTime date = DateTime.parse(dateString);
    var formatter = DateFormat('dd/MM');
    return formatter.format(date);
  }


  static String getFullDateString(String dateString) {
    DateTime date = DateTime.parse(dateString);
    var formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(date);
  }

  static String getDayAndMonthVi(DateTime date) {
    return '${date.day} tháng ${date.month}';
  }

  static String getYearAndDateVi(DateTime date) {
    String formattedDayOfWeek = DateFormat('EEEE').format(date);
    return '${date.year}, ${dayEnToVi2[formattedDayOfWeek]}';
  }

  static String getTimeHourAndMinute(String time) => time.substring(11,16);

  static String changeMinuteToHourString(int minutes) {
    int hours = minutes~/60;
    dynamic minute = minutes-hours*60;
    minute < 10 ? minute = '0$minute' : minute;
    return '${hours}h$minute';
  }

  static String formatDate(String date) {
    DateTime time = DateFormat("dd/MM/yyyy").parse(date);
    var formatter = DateFormat('ddMMyyyy');
    String formattedDate = formatter.format(time);
    return formattedDate;
  }

}