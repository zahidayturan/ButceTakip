import 'package:butcekontrol/models/spend_info.dart';
import 'package:butcekontrol/utils/date_time_manager.dart';
import 'package:butcekontrol/utils/textConverter.dart';
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
    operationDate.text =  DateTimeManager.getCurrentDayMonthYear();
    operationTime.text = DateTimeManager.getCurrentTime();
    moneyType.text = "";
    category.text = "";
    customize.text = "";
    convertedCategory = "";
    convertedCustomize = "";
    userCategoryController = "";
    systemMessage = "";
    categoryColorChanger = 999;
    regsController = 0;
    registration.text = "0";
    selectedValueCustomize = null;
  }

  SpendInfo? updateOrAgainItems;
  String? updateOrAgainItemsId;
  final TextEditingController realAmount = TextEditingController();
  final TextEditingController userCategory = TextEditingController();
  final TextEditingController systemMessageController = TextEditingController();
  setControllerForUpdateOrAgain(SpendInfo items,BuildContext context) {

    updateOrAgainItems = items;
    updateOrAgainItemsId = items.id.toString();
    note.text = items.note.toString();
    amount.text = items.amount.toString();

    operationType.text = items.operationType.toString();
    if(operationType.text == "Gider"){
      initialLabelIndexForType = 0;
      selectedCategory = 0;
    }else{
      initialLabelIndexForType = 1;
      selectedCategory = 1;
    }

    category.text = items.category.toString();
    convertedCategory = Converter().textConverterToDB(category.text, context, 0);

    operationTool.text = items.operationTool.toString();
    if(operationTool.text == "Nakit"){
      initialLabelIndexForTool = 0;
    }else if(operationTool.text == "Kart"){
      initialLabelIndexForTool = 1;
    }else{
      initialLabelIndexForTool = 2;
    }

    registration.text = items.registration.toString();
    if(registration.text == "0"){
      regsController = 0;
    }else{
      regsController = 1;
    }

    operationDate.text = items.operationDate.toString();
    List <String> parts = operationDate.text.split(".");
    int parseDay = int.parse(parts[0]);
    int parseMonth = int.parse(parts[1]);
    int parseYear = int.parse(parts[2]);
    selectedDate = DateTime(parseYear,parseMonth,parseDay);

    moneyType.text = items.moneyType.toString();

    customize.text = items.processOnce.toString();
    selectedValueCustomize = customize.text;
    bool menuController = _isProcessOnceValidNumber(customize.text);
    menuController == true ? initialLabelIndexCustomize = 1 : initialLabelIndexCustomize = 0;
    convertedCustomize = Converter().textConverterFromDB(customize.text, context, 1);

    realAmount.text = items.realAmount.toString();
    userCategory.text = items.userCategory.toString();
    systemMessageController.text = items.systemMessage.toString();
  }

  resetControllerForUpdateOrAgain(BuildContext context) {
    updateOrAgainItemsId = updateOrAgainItems!.id.toString();
    note.text = updateOrAgainItems!.note.toString();
    amount.text = updateOrAgainItems!.amount.toString();

    operationType.text = updateOrAgainItems!.operationType.toString();
    if(operationType.text == "Gider"){
      initialLabelIndexForType = 0;
      selectedCategory = 0;
    }else{
      initialLabelIndexForType = 1;
      selectedCategory = 1;
    }

    category.text = updateOrAgainItems!.category.toString();
    convertedCategory = Converter().textConverterToDB(category.text, context, 0);

    operationTool.text = updateOrAgainItems!.operationTool.toString();
    if(operationTool.text == "Nakit"){
      initialLabelIndexForTool = 0;
    }else if(operationTool.text == "Kart"){
      initialLabelIndexForTool = 1;
    }else{
      initialLabelIndexForTool = 2;
    }

    registration.text = updateOrAgainItems!.registration.toString();
    if(registration.text == "0"){
      regsController = 0;
    }else{
      regsController = 1;
    }

    operationDate.text = updateOrAgainItems!.operationDate.toString();
    List <String> parts = operationDate.text.split(".");
    int parseDay = int.parse(parts[0]);
    int parseMonth = int.parse(parts[1]);
    int parseYear = int.parse(parts[2]);
    selectedDate = DateTime(parseYear,parseMonth,parseDay);

    moneyType.text = updateOrAgainItems!.moneyType.toString();

    customize.text = updateOrAgainItems!.processOnce.toString();
    selectedValueCustomize = customize.text;
    bool menuController = _isProcessOnceValidNumber(customize.text);
    menuController == true ? initialLabelIndexCustomize = 1 : initialLabelIndexCustomize = 0;
    convertedCustomize = Converter().textConverterFromDB(customize.text, context, 1);

    realAmount.text = updateOrAgainItems!.realAmount.toString();
    userCategory.text = updateOrAgainItems!.userCategory.toString();
    systemMessageController.text = updateOrAgainItems!.systemMessage.toString();
  }

  bool _isProcessOnceValidNumber(String processOnce) {
    return processOnce.contains(RegExp(r'\d'));
  }
}