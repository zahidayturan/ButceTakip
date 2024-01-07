import 'package:butcekontrol/riverpod_management.dart';
import 'package:butcekontrol/utils/date_time_manager.dart';
import 'package:butcekontrol/utils/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googleapis/cloudsearch/v1.dart';
import '../models/spend_info.dart';
import 'package:collection/collection.dart';

class DbProvider extends ChangeNotifier {
  bool isuseinsert = false ;
  bool deletst = false ;
  bool updatest = false ;
  String month = DateTime.now().month.toString();
  String year = DateTime.now().year.toString() ;
  Future<List<SpendInfo>> ?daylist ;
  List<SpendInfo> ?registeryListTile ;
  List<SpendInfo> ?searchListTile ;
  String ?status ;
  String ?day ;
  String ?operationType;

  void setStatus(String status){
    notifyListeners();
  }

  void setDay(String day){
    this.day = day ;
    notifyListeners();
  }

  Future<void> setMonthandYear(month, year) async{
    this.month = month;
    this.year = year;
    //notifyListeners();
  }

  void refreshDB() async {
    await SQLHelper.getItems();
    //myMethod2();
    notifyListeners();
  }

  void changeisuseinsert(){
    isuseinsert != isuseinsert;
    notifyListeners();
  }

  Future insertDataBase(
      String? operationType ,
      String? category,
      String? operationTool,
      int registration,
      double? amount,
      String? note,
      String operationDate,
      String moneyType,
      double ?realAmount,
      String processOnce,
      String userCategory,
      String systemMessage
      )async {
    String time = operationDate ;
    List <String> parts = time.split(".");
    int parseDay = int.parse(parts[0]);
    int parseMonth = int.parse(parts[1]);
    int parseYear = int.parse(parts[2]);
    final newinfo = SpendInfo(
        operationType,
        category,
        operationTool,
        registration,
        amount,
        note,
        parseDay.toString(),
        parseMonth.toString(),
        parseYear.toString(),
        DateTimeManager.getCurrentTime(),
        operationDate,
        moneyType,
        processOnce,
        realAmount,
        userCategory,
        systemMessage,
    );
    print(newinfo.toMap());
    await SQLHelper.createItem(newinfo);
    isuseinsert = !isuseinsert ;
    notifyListeners();
  }

  Future delete(int id) async{
    await SQLHelper.deleteItem(id);
    deletst = !deletst ;
    refreshDB();
    notifyListeners();
  }

  void update(){
    updatest = !updatest ;
    refreshDB();
    notifyListeners();
  }
  int foundMaxdayinMoth (){ //find out how many days the month has
    DateTime now = DateTime.now();
    DateTime firstDayOfNextMonth = DateTime(now.year, now.month + 1, 1);
    DateTime lastDayOfMonth = firstDayOfNextMonth.subtract(Duration(days: 1));
    return lastDayOfMonth.day;
  }
  Future<List<double>?> monthlyAssetChange(WidgetRef ref, double FirstTotalAsset) async { //A method that compares the previous 30 days
    DateTime now = DateTime.now();
    double mytotalAsset = FirstTotalAsset;
    List<double> totalList =<double> [];
    for(int i = 0 ; i < 30 ; i++){
      List<SpendInfo> dailyListTotal = await SQLHelper.SQLEntry(
        "SELECT * FROM spendinfo WHERE "
            "operationYear == '${now.year}' AND "
            "operationMonth == '${now.month}' AND "
            "operationDay == '${now.day}'"
      );
      now = now.subtract(Duration(days: i ));
      if(dailyListTotal != null){
        double incomeTotal = dailyListTotal.where((element) => element.operationType == 'Gelir').fold(0, (previousValue, element) => previousValue + element.realAmount!);
        double expenseTotal = dailyListTotal.where((element) => element.operationType == 'Gider').fold(0, (previousValue, element) => previousValue + element.realAmount!);
        double difference = incomeTotal - expenseTotal;
        mytotalAsset -= difference;
        totalList.add(mytotalAsset);
        //print("$i == $nowDay.$nowMonth.$nowYear >> $difference  >> ASSET = $mytotalAsset");
      }else {
        return null;
      }
    }
    return totalList.reversed.toList();
  }
  ///istenilern ay ve yıla göre bütün kayıtları Liste oalrak döndürür.
  Future<List<SpendInfo>> getMonthlyInfo(WidgetRef ref, int monthh, int year) async {
    int startDay = ref.read(settingsRiverpod).monthStartDay ?? 1;
    DateTime startDate = DateTime(int.parse(year.toString()), int.parse(monthh.toString()), startDay);
    DateTime endDate = DateTime(int.parse(year.toString()), int.parse(monthh.toString())+1, startDay-1);
    List<SpendInfo> items = await SQLHelper.getItemsByOperationMonthAndYear(startDate.month.toString() ,startDate.year.toString());
    items = items.where((element) => int.tryParse(element.operationDay!)! > startDay-1).toList();
    List<SpendInfo> itemsNext = await SQLHelper.getItemsByOperationMonthAndYear(endDate.month.toString() ,endDate.year.toString());
    itemsNext = itemsNext.where((element) => int.tryParse(element.operationDay!)! < startDay).toList();
    items.addAll(itemsNext);
    return items;
  }
  //it prepared to use for My_Assistant Widget
  Future<Map<String, List>> myAssistantMethod(WidgetRef ref, int month, int year) async {
    List<SpendInfo> items = await getMonthlyInfo(ref, month, year);
    List<SpendInfo> allItems = await SQLHelper.getItems();
    return <String, List<SpendInfo>>{
      "items" : items,
      "allItems" : allItems
    };
  }

  Future<double> calculateMonthlyChangeBefore(WidgetRef ref) async {
    DateTime now = DateTime.now();
    List<SpendInfo> currentMonth = await getMonthlyInfo(ref, now.month, now.year);
    List<SpendInfo> beforeMonth = await getMonthlyInfo(ref, now.subtract(Duration(days: foundMaxdayinMoth())).month,  now.subtract(Duration(days: foundMaxdayinMoth())).year);
    print("current :  ${getTotalAmount(currentMonth)}");
    print("before : ${getTotalAmount(beforeMonth)}");
    return double.parse(getTotalAmount(currentMonth)[0]) - double.parse(getTotalAmount(beforeMonth)[0]) ;
  }

  //it prepared to use for generalInfo Widget
  Future <Map<String, Object>> myMethod(WidgetRef ref) async {
    int startDay = ref.read(settingsRiverpod).monthStartDay ?? 1;
    DateTime startDate = DateTime(int.parse(year), int.parse(month), startDay);
    DateTime endDate = DateTime(int.parse(year), int.parse(month)+1, startDay-1);
    List<SpendInfo> items = await SQLHelper.getItemsByOperationMonthAndYear(startDate.month.toString() ,startDate.year.toString());
    items = items.where((element) => int.tryParse(element.operationDay!)! > startDay-1).toList();
    List<SpendInfo> itemsNext = await SQLHelper.getItemsByOperationMonthAndYear(endDate.month.toString() ,endDate.year.toString());
    itemsNext = itemsNext.where((element) => int.tryParse(element.operationDay!)! < startDay).toList();
    items.addAll(itemsNext);
    var groupedItems = groupBy(
        items.where((item) => int.tryParse(item.operationDay!)! > startDay-1),
        (item) => item.operationDay);
    var groupedItems2 = groupBy(
        itemsNext.where((item) => int.tryParse(item.operationDay!)! < startDay),
            (item) => item.operationDay);
    var dailyTotals = <String, Map<String, double>>{};
    groupedItems.addAll(groupedItems2);
    groupedItems.forEach((day, dayItems) {
      int itemLength = dayItems.length;
      double itemsMonth = double.tryParse(dayItems.first.operationMonth!)!;
      double itemsYear = double.tryParse(dayItems.first.operationYear!)!;
      double totalAmount = dayItems
          .where((element) => element.operationType == 'Gelir')
          .fold(
          0, (previousValue, element) => previousValue + element.realAmount!);

      double totalAmount2 = dayItems
          .where((element) => element.operationType == 'Gider')
          .fold(
          0, (previousValue, element) => previousValue + element.realAmount!);
      dailyTotals[day!] = {
        'totalAmount': totalAmount,
        'totalAmount2': totalAmount2,
        'itemsLength' : itemLength.toDouble(),
        'itemsMonth' : itemsMonth,
        'itemsYear' : itemsYear
      };
    });
    dailyTotals = Map.fromEntries(dailyTotals.entries.toList()..sort((e1, e2) => int.parse(e2.key).compareTo(int.parse(e1.key))));
    List<MapEntry<String, Map<String, double>>> sortedEntries = dailyTotals.entries.toList();
    sortedEntries.sort((e1, e2) {
      double month1 = e1.value['itemsMonth']!;
      double month2 = e2.value['itemsMonth']!;
      return month1 == 12 ?  month1.compareTo(month2) : month2.compareTo(month1);
    });
    dailyTotals = Map.fromEntries(sortedEntries);
    notifyListeners();
    return {"items" : items, "dailyTotals" : dailyTotals};
  }

  Future <List<SpendInfo>> myMethod2() async{
    List<SpendInfo> items =
    registeryListTile =  await SQLHelper.getItemsByOperationDayMonthAndYear(day!, month, year);
    notifyListeners();
    return items;
  }

  Future <Map<String, double>> myMethodForAssistantChart(WidgetRef ref) async {
    int startDay = ref.read(settingsRiverpod).monthStartDay ?? 1;
    DateTime startDate = DateTime(int.parse(year), int.parse(month), startDay);
    DateTime endDate = DateTime(int.parse(year), int.parse(month)+1, startDay-1);
    List<SpendInfo> items = await SQLHelper.getItemsByOperationMonthAndYear(startDate.month.toString() ,startDate.year.toString());
    items = items.where((element) => int.tryParse(element.operationDay!)! > startDay-1).toList();
    List<SpendInfo> itemsNext = await SQLHelper.getItemsByOperationMonthAndYear(endDate.month.toString() ,endDate.year.toString());
    itemsNext = itemsNext.where((element) => int.tryParse(element.operationDay!)! < startDay).toList();
    items.addAll(itemsNext);
    var groupedItems = groupBy(
        items.where((item) => int.tryParse(item.operationDay!)! > startDay-1),
            (item) => item.operationDay);
    var groupedItems2 = groupBy(
        itemsNext.where((item) => int.tryParse(item.operationDay!)! < startDay),
            (item) => item.operationDay);
    var dailyTotals = <String, Map<String, double>>{};
    groupedItems.addAll(groupedItems2);
    groupedItems.forEach((day, dayItems) {
      double itemsMonth = double.tryParse(dayItems.first.operationMonth!)!;
      double itemsYear = double.tryParse(dayItems.first.operationYear!)!;
      double totalAmount = dayItems
          .where((element) => element.operationType == 'Gelir')
          .fold(
          0, (previousValue, element) => previousValue + element.realAmount!);

      double totalAmount2 = dayItems
          .where((element) => element.operationType == 'Gider')
          .fold(
          0, (previousValue, element) => previousValue + element.realAmount!);
      dailyTotals[day!] = {
        'totalAmount': totalAmount,
        'totalAmount2': totalAmount2,
        'itemsMonth' : itemsMonth,
      };
    });
    dailyTotals = Map.fromEntries(dailyTotals.entries.toList()..sort((e1, e2) => int.parse(e2.key).compareTo(int.parse(e1.key))));
    List<MapEntry<String, Map<String, double>>> sortedEntries = dailyTotals.entries.toList();
    sortedEntries.sort((e1, e2) {
      double month1 = e1.value['itemsMonth']!;
      double month2 = e2.value['itemsMonth']!;
      return month1 == 12 ?  month1.compareTo(month2) : month2.compareTo(month1);
    });
    dailyTotals = Map.fromEntries(sortedEntries);
    notifyListeners();

    Map<String, double> differences = {};

    dailyTotals.forEach((key, values) {
      double totalAmount = values['totalAmount'] ?? 0.0;
      double totalAmount2 = values['totalAmount2'] ?? 0.0;
      differences[key] = totalAmount - totalAmount2;
    });
    return differences;
  }



  Future <List<SpendInfo>> registeryList() async {
    List<SpendInfo> items = await SQLHelper.getRegisteryQuery();
    registeryListTile = items ;
    notifyListeners();
    return items ;
  }
  Future <List<SpendInfo>> lastOperationList(int itemLength) async {
    List<SpendInfo> items = await SQLHelper.getLastOperation(itemLength);
    registeryListTile = items ;
    notifyListeners();
    return items ;
  }
  String getTotalAmountByKart(List<SpendInfo> items) {//Bütün Kart Bütçe Gösteriliyor.
    double totalAmount = items
        .where((element) => element.operationTool == 'Kart')
        .where((element) => element.operationType == 'Gelir')
        .fold(0, (previousValue, element) => previousValue + element.realAmount!);
    double totalAmount2 = items
        .where((element) => element.operationTool == 'Kart')
        .where((element) => element.operationType == 'Gider')
        .fold(0, (previousValue, element) => previousValue + element.realAmount!);
    return (totalAmount - totalAmount2).toStringAsFixed(1);
  }

  String getTotalAmountByNakit(List<SpendInfo> items) {//Bütün Nakit Bütçe Gösteriliyor.
    double totalAmount = items
        .where((element) => element.operationTool == 'Nakit')
        .where((element) => element.operationType == 'Gelir')
        .fold(0, (previousValue, element) => previousValue + element.realAmount!);
    double totalAmount2 = items
        .where((element) => element.operationTool == 'Nakit')
        .where((element) => element.operationType == 'Gider')
        .fold(0, (previousValue, element) => previousValue + element.realAmount!);
    return (totalAmount - totalAmount2).toStringAsFixed(1);
  }

  String getTotalAmountByDiger(List<SpendInfo> items) {//Bütün Diğer Bütçe Gösteriliyor.
    double totalAmount = items
        .where((element) => element.operationTool == 'Diger')
        .where((element) => element.operationType == 'Gelir')
        .fold(0, (previousValue, element) => previousValue + element.realAmount!);
    double totalAmount2 = items
        .where((element) => element.operationTool == 'Diger')
        .where((element) => element.operationType == 'Gider')
        .fold(0, (previousValue, element) => previousValue + element.realAmount!);
    return (totalAmount - totalAmount2).toStringAsFixed(1);
  }

  List<String> getTotalAmount(List<SpendInfo> items) {  //Bütün net Bütçe Gösteriliyor.
    double totalAmount = items
        .where((element) => element.operationType == 'Gelir')
        .fold(0, (previousValue, element) => previousValue + element.realAmount!);
    double totalAmount2 = items
        .where((element) => element.operationType == 'Gider')
        .fold(0, (previousValue, element) => previousValue + element.realAmount!);

    double totalAmountEx = totalAmount - totalAmount2;
    String formattedTotalAmountEx = totalAmountEx.toStringAsFixed(2);
    if (formattedTotalAmountEx.length >= 10) {
      formattedTotalAmountEx = totalAmountEx.toStringAsFixed(0);
    }
    else if (formattedTotalAmountEx.length >= 8) {
      formattedTotalAmountEx = totalAmountEx.toStringAsFixed(1);
    }
    List<String> totalAmountList = [formattedTotalAmountEx,totalAmountEx.toStringAsFixed(2)];
    return totalAmountList;
  }

  List<String> getTotalAmountPositive(List<SpendInfo> items) { //Gelir olan Kayıtları listeliyor.
    double totalAmount = items
        .where((element) => element.operationType == 'Gelir')
        .fold(0, (previousValue, element) => previousValue + element.realAmount!);

    String formattedPositiveAmount = totalAmount.toStringAsFixed(2);
    if (formattedPositiveAmount.length >= 10) {
      formattedPositiveAmount = totalAmount.toStringAsFixed(0);
    }
    else if (formattedPositiveAmount.length >= 8) {
      formattedPositiveAmount = totalAmount.toStringAsFixed(1);
    }
    List<String> positiveAmountList = [formattedPositiveAmount,totalAmount.toStringAsFixed(2)];

    return positiveAmountList;
  }

  List<String> getTotalAmountNegative(List<SpendInfo> items) { //Gider olan Kayıtları listeliyor.
    double totalAmount2 = items
        .where((element) => element.operationType == 'Gider')
        .fold(0, (previousValue, element) => previousValue + element.realAmount!);

    String formattedNegativeAmount = totalAmount2.toStringAsFixed(2);
    if (formattedNegativeAmount.length >= 10) {
      formattedNegativeAmount = totalAmount2.toStringAsFixed(0);
    }
    else if (formattedNegativeAmount.length >= 8) {
      formattedNegativeAmount = totalAmount2.toStringAsFixed(1);
    }
    List<String> negativeAmountList = [formattedNegativeAmount,totalAmount2.toStringAsFixed(2)];
    return negativeAmountList;
  }


  static String todayNow = DateTimeManager.getCurrentDay();
  static String monthNow = DateTimeManager.getCurrentMonth();
  static String yearNow = DateTimeManager.getCurrentYear();

  Future<List<SpendInfo>> myDailyMethod() async {
    List<SpendInfo> items = await SQLHelper.getItemsByOperationDayMonthAndYear(todayNow,monthNow,yearNow);
    return items;
  }
  Future<void> beforeMonthSubCalculate(WidgetRef ref) async {
    int startDay = ref.read(settingsRiverpod).monthStartDay ?? 1;
    DateTime startDate = DateTime(int.parse(year), int.parse(month), startDay);
    DateTime endDate = DateTime(int.parse(year), int.parse(month)+1, startDay-1);
    ///AYIN KAPSADIĞI TARİHLER BELİRLENDİ

  }

  Future<Map<String, Map<String, double>>> monthlyStatusInfo(WidgetRef ref) async {
    int startDay = ref.read(settingsRiverpod).monthStartDay ?? 1;
    DateTime startDate = DateTime(int.parse(year), int.parse(month), startDay);
    DateTime endDate = DateTime(int.parse(year), int.parse(month)+1, startDay-1);
    ///AYIN KAPSADIĞI TARİHLER BELİRLENDİ

    List<SpendInfo> items = await SQLHelper.getItemsByOperationMonthAndYear(startDate.month.toString() ,startDate.year.toString());
    items = items.where((element) => int.tryParse(element.operationDay!)! > startDay-1).toList();
    List<SpendInfo> itemsNext = await SQLHelper.getItemsByOperationMonthAndYear(endDate.month.toString() ,endDate.year.toString());
    itemsNext = itemsNext.where((element) => int.tryParse(element.operationDay!)! < startDay).toList();
    items.addAll(itemsNext);
    ///AYIN KAPSADIĞI TARİHLERE GÖRE ITEMLER ÇEKİLDİ
    var groupedItems = groupBy(
        items.where((item) => int.tryParse(item.operationDay!)! > startDay-1),
            (item) => item.operationDay);
    var groupedItems2 = groupBy(
        itemsNext.where((item) => int.tryParse(item.operationDay!)! < startDay),
            (item) => item.operationDay);
    groupedItems.addAll(groupedItems2);
    ///GÜNLERE GÖRE GRUPLANDI

    var dailyTotals = <String, Map<String, double>>{};
    groupedItems.forEach((day, dayItems) {
      int itemLength = dayItems.length;
      double itemsMonth = double.tryParse(dayItems.first.operationMonth!)!;
      double itemsYear = double.tryParse(dayItems.first.operationYear!)!;
      double totalAmount = dayItems
          .where((element) => element.operationType == 'Gelir')
          .fold(
          0, (previousValue, element) => previousValue + element.realAmount!);
      double totalAmount2 = dayItems
          .where((element) => element.operationType == 'Gider')
          .fold(
          0, (previousValue, element) => previousValue + element.realAmount!);
      dailyTotals[day!] = {
        'totalAmount': totalAmount,
        'totalAmount2': totalAmount2,
        'itemsLength' : itemLength.toDouble(),
        'itemsMonth' : itemsMonth,
        'itemsYear' : itemsYear,
      };
    });
    ///Gruplanan günlerin verileri gruplandı

    return dailyTotals;
  }

  Future<List<MapEntry<String, List<double>>>> monthlyStatusInfoForCategory(WidgetRef ref) async {
    int startDay = ref.read(settingsRiverpod).monthStartDay ?? 1;
    DateTime startDate = DateTime(int.parse(year), int.parse(month), startDay);
    DateTime endDate = DateTime(int.parse(year), int.parse(month)+1, startDay-1);
    ///AYIN KAPSADIĞI TARİHLER BELİRLENDİ
    List<SpendInfo> items = await SQLHelper.getItemsByOperationMonthAndYear(startDate.month.toString() ,startDate.year.toString());
    items = items.where((element) => int.tryParse(element.operationDay!)! > startDay-1).toList();
    List<SpendInfo> itemsNext = await SQLHelper.getItemsByOperationMonthAndYear(endDate.month.toString() ,endDate.year.toString());
    itemsNext = itemsNext.where((element) => int.tryParse(element.operationDay!)! < startDay).toList();
    items.addAll(itemsNext);
    ///AYIN KAPSADIĞI TARİHLERE GÖRE ITEMLER ÇEKİLDİ
    /*
    Bütün listeyi önce giderler olarak filtrele
    Filtrelenen listeyi kategoriye göre grupla
    Gruplanan kategeorilerin tutarlarını ve kaç tane olduğunu ayrı ayrı topla
    Tutara göre sırala
     */
    List<MapEntry<String, List<double>>> itemList = [];
    var giderList = items.where((element) => element.operationType == "Gider").toList();
    var groupedByCategory = groupBy(giderList, (SpendInfo item) => item.category);

    var categoryAndAmount = <String, List<double>>{};
    groupedByCategory.forEach((category, itemList) {
      var totalAmount = itemList.fold(0.0, (sum, item) => sum + (item.amount ?? 0));
      categoryAndAmount[category!] = [totalAmount,itemList.length.toDouble()];
    });
    var sortedCategoryAndAmount = categoryAndAmount.entries.toList()
      ..sort((a, b) => b.value.first.compareTo(a.value.first));
    if(sortedCategoryAndAmount.isNotEmpty){
      itemList = sortedCategoryAndAmount;
    }
    //int categoryCount = itemList.isNotEmpty ? groupedByCategory[itemList.first.key]!.length : 0;

    ///AYIN EN ÇOK HARCAMA YAPILAN KATEGORİSİ
    return itemList;
  }

  Future<double> monthlyStatusInfoForCompare(WidgetRef ref) async {
    int startDay = ref.read(settingsRiverpod).monthStartDay ?? 1;
    DateTime startDateBefore = DateTime(int.parse(year), int.parse(month)-1, startDay);

    DateTime endDateBefore = DateTime(int.parse(year), int.parse(month), startDay-1);

    List<SpendInfo> itemsBeforeMonth = await SQLHelper.getItemsByOperationMonthAndYear(startDateBefore.month.toString() ,startDateBefore.year.toString());
    itemsBeforeMonth = itemsBeforeMonth.where((element) => int.tryParse(element.operationDay!)! > startDay-1).toList();
    List<SpendInfo> itemsNextBeforeMonth = await SQLHelper.getItemsByOperationMonthAndYear(endDateBefore.month.toString() ,endDateBefore.year.toString());
    itemsNextBeforeMonth = itemsNextBeforeMonth.where((element) => int.tryParse(element.operationDay!)! < startDay).toList();
    itemsBeforeMonth.addAll(itemsNextBeforeMonth);

    double totalAmountIncome = 0.0;
    double totalAmountExpense = 0.0;
    itemsBeforeMonth.forEach((element) {


      if(element.operationType == "Gider"){
        totalAmountExpense = totalAmountExpense + element.amount!.toDouble();
      }else{
        totalAmountIncome = totalAmountIncome + element.amount!.toDouble();
      }
    });

    double item = 0.0;
    item = totalAmountIncome - totalAmountExpense;
    return item;
  }

  Future<List<SpendInfo>> monthlyStatusInfoForMostExpenses(WidgetRef ref) async {
    int startDay = ref.read(settingsRiverpod).monthStartDay ?? 1;
    DateTime startDate = DateTime(int.parse(year), int.parse(month), startDay);
    DateTime endDate = DateTime(int.parse(year), int.parse(month)+1, startDay-1);
    ///AYIN KAPSADIĞI TARİHLER BELİRLENDİ

    List<SpendInfo> items = await SQLHelper.getItemsByOperationMonthAndYear(startDate.month.toString() ,startDate.year.toString());
    items = items.where((element) => int.tryParse(element.operationDay!)! > startDay-1).toList();
    List<SpendInfo> itemsNext = await SQLHelper.getItemsByOperationMonthAndYear(endDate.month.toString() ,endDate.year.toString());
    itemsNext = itemsNext.where((element) => int.tryParse(element.operationDay!)! < startDay).toList();
    items.addAll(itemsNext);
    ///AYIN KAPSADIĞI TARİHLERE GÖRE ITEMLER ÇEKİLDİ
    var mostExpensiveSpending;

    var giderItems = items.where((element) => element.operationType == "Gider").toList();

    if (giderItems.isNotEmpty) {
      mostExpensiveSpending = giderItems.reduce((a, b) => a.amount! > b.amount! ? a : b);
    } else {
      //print("Gider türünde öğe bulunamadı.");
    }
    List<SpendInfo> resultList = [];
    mostExpensiveSpending != null ? resultList.add(mostExpensiveSpending) : null;
    ///gider olan nesne varsa listeye en pahalısını ekler
    ///gider yoksa boş olarak liste döndürülür
    ///diğer tarafta null kontrolü yapılması lazım
    return resultList;
  }

  bool searchSort = false ;
  void setSearcSort(){
    searchSort = !searchSort;
    notifyListeners();
  }
  void resetSearchListTile(){
    searchListTile?.clear();
    notifyListeners();
  }
  String searchText = "";
  void searchItem(searchText) async {
    searchListTile = await SQLHelper.searchItem(searchText);
    var sortedlist;
    searchListTile!.sort((a, b) {
      DateTime dateA = convertDate(a.operationDate!);
      DateTime dateB = convertDate(b.operationDate!);
      switch(searchSort){
        case true:
          sortedlist = dateA.compareTo(dateB);
          break;
        case false:
          sortedlist = dateB.compareTo(dateA);
          break;
      }
      return sortedlist;
    });
    notifyListeners();
  }
  DateTime convertDate(String Date) {
    // Date format: "dd.MM.yyyy
    if(Date == "null"){
      Date = "00.00.0000";
    }
    List<String> dateSplit = Date.split(".");
    int day = int.parse(dateSplit[0]);
    int month = int.parse(dateSplit[1]);
    int year = int.parse(dateSplit[2]);
    return DateTime(year, month, day);
  }

}