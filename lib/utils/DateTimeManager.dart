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
    return '${currentTime.hour}:${currentTime.minute}';
  }
  static String getCurrentIndex() {
    DateTime currentTime = DateTime.now();
    return '${currentTime.weekday}';
  }
}