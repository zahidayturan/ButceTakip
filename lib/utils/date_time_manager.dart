import 'package:intl/intl.dart';

class DateTimeManager {
  static String getCurrentDate() {
    DateTime currentTime = DateTime.now();
    return '${currentTime.day}-${currentTime.month}-${currentTime
        .year} ${currentTime.hour}:${currentTime.minute}';
  }
  static String getCurrentDay() {
    DateTime currentTime = DateTime.now();
    return '${currentTime.day}';
  }
  static String getCurrentMonth() {
    DateTime currentTime = DateTime.now();
    return '${currentTime.month}';
  }
  static String getCurrentYear() {
    DateTime currentTime = DateTime.now();
    return '${currentTime.year}';
  }
  static String getCurrentTime() {
    DateTime currentTime = DateTime.now();
    String formattedTime = DateFormat('HH:mm').format(currentTime);
    return formattedTime;
  }
  static String getCurrentIndex() {
    DateTime currentTime = DateTime.now();
    return '${currentTime.weekday}';
  }
  static String getCurrentDayMonthYear() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd.MM.yyyy').format(now);
    return formattedDate;
  }

  static int getCurrentYearInt() {
    DateTime currentTime = DateTime.now();
    return currentTime.year;
  }
  static int getCurrentMonthInt() {
    DateTime currentTime = DateTime.now();
    return currentTime.month;
  }
}