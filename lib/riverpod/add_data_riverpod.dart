import 'package:butcekontrol/utils/date_time_manager.dart';
import 'package:flutter/material.dart';

class AddDataRiverpod extends ChangeNotifier{

  final TextEditingController note = TextEditingController(text: "");
  int maxLength = 108;
  final TextEditingController amount = TextEditingController();
  double moneyTypeWidth = 34.0;
  double moneyTypeHeight = 34.0;
  bool openMoneyTypeMenu = false;
  final TextEditingController operationType = TextEditingController(text: "Gider");
  int initialLabelIndexForType = 0;
  final TextEditingController operationTool = TextEditingController(text: "Nakit");
  int initialLabelIndexForTool = 0;
  final TextEditingController registration = TextEditingController(text: "0");
  int regsController = 0;
  final TextEditingController operationDate = TextEditingController(text: DateTimeManager.getCurrentDayMonthYear());
  DateTime? selectedDate;
  final TextEditingController operationTime = TextEditingController(text: DateTimeManager.getCurrentTime());
  TimeOfDay? selectedTime;
  final TextEditingController category = TextEditingController(text: "");
  String? selectedValue;
  int selectedAddCategoryMenu = 0;
  int initialLabelIndex2 = 0;
  int sortChanger = 0;
  int editChanger = 0;
  double heightChanger = 40.0;
  int categoryColorChanger = 999;
  int categoryDeleteChanger = 0;
  int categoryDeleteChanger2 = 0;
  int categoryEditChanger = 0;
  int categoryEditChanger2 = 0;
  int isAdded = 0;
  int selectedCategory = 0;
  final TextEditingController categoryEdit = TextEditingController(text: "");
  final TextEditingController categoryController = TextEditingController(text: "");
  final TextEditingController customize = TextEditingController(text: "");
  String? selectedValueCustomize;
  int initialLabelIndexCustomize = 0;
  final TextEditingController moneyType = TextEditingController(text: "");

  late PageController pageViewController;

  String systemMessage = "";
  String convertedCategory = "";
  String convertedCustomize = "";
  String userCategoryController = "";

  int selectedCustomizeMenu = 0;

  void clearTexts() {
    note.text = "";
    amount.text = "";
    operationTime.text = DateTimeManager.getCurrentTime();


    category.text = "";
    customize.text = "";
    convertedCategory = "";
    convertedCustomize = "";
    userCategoryController = "";
    systemMessage = "";
    categoryColorChanger = 999;
    regsController = 0;
    registration.text = "0";

  }

}