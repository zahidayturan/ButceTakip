import 'package:butcekontrol/classes/language.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/models/spend_info.dart';
import 'package:butcekontrol/pages/addDataPages/add_data_app_bar.dart';
import 'package:butcekontrol/pages/addDataPages/add_data_menu_list_type.dart';
import 'package:butcekontrol/pages/addDataPages/add_data_menu_table_type.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:butcekontrol/utils/db_helper.dart';
import 'package:butcekontrol/utils/interstitial_ads.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddData extends ConsumerStatefulWidget {
  const AddData({Key? key}) : super(key: key);
  @override
  ConsumerState<AddData> createState() => _AddDataState();
}

class _AddDataState extends ConsumerState<AddData> {


  @override
  void initState(){
    ref.read(addDataRiverpod).pageViewController = PageController(initialPage: ref.read(settingsRiverpod).addDataType!);
    var readSettings = ref.read(settingsRiverpod);
    var readAdd = ref.read(addDataRiverpod);
    readAdd.clearTexts();
    var adCounter = readSettings.adCounter;
    if (adCounter! < 1) {
      _interstitialAdManager.loadInterstitialAd();
    } else {
    }
    super.initState();
  }

  final InterstitialAdManager _interstitialAdManager = InterstitialAdManager();

  void _showInterstitialAd(BuildContext context) {
    //_interstitialAdManager.loadInterstitialAd();
    _interstitialAdManager.showInterstitialAd(context);
  }
  CustomColors renkler = CustomColors();
  @override
  Widget build(BuildContext context) {
    var readSettings = ref.read(settingsRiverpod);
    return SafeArea(
      child: Scaffold(
        //backgroundColor: Colors.white,
        appBar: AddAppBar(),
        body: Column(
          children: [
            Expanded(
              child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  controller: ref.read(addDataRiverpod).pageViewController,
                  children: [
                    AddDataMenuTableType(),
                    AddDataMenuListType()
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 14,top: 14),
              child: operationCustomButton(context),
            )
          ],
        ) ,
        bottomNavigationBar: null,
      ),
    );
  }

  DateTime convertDateTime(String Date){
    var date = Date.split(".");
    return DateTime(int.parse(date[2]), int.parse(date[1]), int.parse(date[0]));
  }

  Widget operationCustomButton(BuildContext context) {
    var read = ref.read(databaseRiverpod);
    var readAdd = ref.read(addDataRiverpod);
    var read2 = ref.read(botomNavBarRiverpod);
    var readHome = ref.read(homeRiverpod);
    var size = MediaQuery.of(context).size;
    var readSettings = ref.read(settingsRiverpod);
    var adCounter = readSettings.adCounter;
    String alertContent = '';
    int alertOperator = 0;
    double amount = double.tryParse(readAdd.amount.text) ?? 0.0;
    void setAlertContent(BuildContext context) {
      if (amount == 0 && readAdd.category.text.isEmpty) {
        alertContent = translation(context).enterAmountAndCategory;
        alertOperator = 1;
      } else if (readAdd.category.text.isNotEmpty) {
        alertContent = translation(context).pleaseEnterAnAmount;
        alertOperator = 2;
      } else {
        alertContent = translation(context).enterCategoryWarning;
        alertOperator = 3;
      }
    }

    return Directionality(
      textDirection: TextDirection.ltr,
      child: SizedBox(
        width: size.width * 0.95,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: size.width > 392 ? size.width * 0.34 : 130,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      readAdd.note.text = "";
                      readAdd.amount.text = "";
                      setState(() {
                        readAdd.category.text = "";
                        readAdd.customize.text = "";
                        readAdd.convertedCategory = "";
                        readAdd.convertedCustomize = "";
                        readAdd.userCategoryController = "";
                        readAdd.systemMessage = "";
                      });
                      //operationCustomButton(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        color: Theme.of(context).highlightColor,
                      ),
                      height: 28,
                      width: size.width > 392 ? size.width * 0.26 : 100,
                      child: Center(
                        child: Text(translation(context).deleteAll,
                            style: TextStyle(
                                height: 1,
                                color: renkler.arkaRenk,
                                fontSize: 15,
                                fontFamily: 'Nexa4',
                                fontWeight: FontWeight.w900)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: size.width > 392 ? size.width * 0.39 : 150,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: ()  async{
                      setAlertContent(context);
                      double amount = double.tryParse(readAdd.amount.text) ?? 0.0;
                      if (amount != 0.0 && readAdd.category.text.isNotEmpty)  {
                        if (readAdd.selectedCustomizeMenu == 1 && readAdd.customize.text != "") {
                          amount = double.parse((amount / double.parse(readAdd.customize.text)).toStringAsFixed(2));
                          readAdd.systemMessage = "1/${readAdd.customize.text}";
                          readAdd.convertedCustomize =  "1/${readAdd.customize.text}";
                          readAdd.customize.text = "1/${readAdd.customize.text}";
                        } else if (readAdd.selectedCustomizeMenu == 0 && readAdd.customize.text != "") {
                          print(readAdd.convertedCustomize);
                          readAdd.systemMessage = readAdd.convertedCustomize;
                        }

                        if(readAdd.moneyType.text != readSettings.Prefix && readAdd.operationType.text == "Gider" ) {
                          List<SpendInfo> liste = await SQLHelper.getItemsForIncomeCal(readAdd.moneyType.text);
                          if(liste.isNotEmpty) {
                            liste.sort((a, b) => convertDateTime(a.operationDate!).compareTo(convertDateTime(b.operationDate!))); // eskieden yeniye
                            double remaining = double.parse(readAdd.amount.text);
                            for (var element in liste){
                              if(remaining > 0){
                                List<SpendInfo> listPassive = await SQLHelper.getItemsForPassive(element);
                                if(remaining >= element.amount!){
                                  //elementi pasif yapacağız.
                                  element.moneyType = element.moneyType!.substring(0,3); //pasifleştirme
                                  remaining -= element.amount!; //kalan miktar 0
                                  if(listPassive.isNotEmpty){
                                    print(listPassive[0].amount);
                                    element.amount = element.amount! + listPassive[0].amount! ;
                                    await SQLHelper.deleteItem(listPassive[0].id!);
                                  }
                                  SQLHelper.updateItem(element);
                                }else{ //daha kücük bir miktar harcama yaıldıysa
                                  double firstValue = element.amount!;
                                  element.amount = element.amount! - remaining;
                                  element.realAmount =ref.read(currencyRiverpod).calculateRealAmount(element.amount!, element.moneyType!, ref.read(settingsRiverpod).Prefix!);
                                  remaining = 0 ;
                                  await SQLHelper.updateItem(element) ;
                                  double result = firstValue - element.amount!;
                                  if(element.category == "null" && element.operationDay == "null"){//varlık kaydı.
                                    final newinfo = SpendInfo(
                                      element.operationType,
                                      element.category,
                                      element.operationTool,
                                      element.registration,
                                      result,
                                      element.note,
                                      element.operationDay,
                                      element.operationMonth,
                                      element.operationYear,
                                      element.operationTime,
                                      element.operationDate,
                                      element.moneyType!.substring(0,3),
                                      element.processOnce,
                                      ref.read(currencyRiverpod).calculateRealAmount(result, element.moneyType!, readSettings.Prefix!),
                                      element.userCategory,
                                      element.systemMessage,
                                    );
                                    await SQLHelper.createItem(newinfo).then((value) {
                                      readSettings.setisuseinsert();
                                      Navigator.of(context).pop();
                                    });
                                    remaining = 0 ;
                                  }else{//normal kayıt
                                    if(listPassive.isNotEmpty){
                                      double newAmount =  listPassive[0].amount! + result ;
                                      double newRealAmount = ref.read(currencyRiverpod).calculateRealAmount(
                                        result,
                                        element.moneyType!,
                                        ref.read(settingsRiverpod).Prefix!,
                                      );
                                      remaining = 0 ;
                                      SQLHelper.updateDB(listPassive[0].id, "spendinfo", {"amount" : newAmount , "realAmount" : newRealAmount});
                                    }else{
                                      double newRealAmount = ref.read(currencyRiverpod).calculateRealAmount(
                                        result,
                                        element.moneyType!,
                                        ref.read(settingsRiverpod).Prefix!,
                                      );
                                      read.insertDataBase(element.operationType, element.category, element.operationTool, element.registration!, result, element.note, element.operationDate!, element.moneyType!.substring(0,3), newRealAmount , element.processOnce!, element.userCategory!, element.systemMessage!);
                                    }
                                    remaining = 0 ;
                                  }
                                }
                              }else{
                              }

                            }

                          }else{ ///eğer eklenen dövizden daha önce gelir girişi olmamış kullanıcı hatası

                          }
                        }
                        read.insertDataBase(
                          readAdd.operationType.text,
                          readAdd.convertedCategory,
                          readAdd.operationTool.text,
                          int.parse(readAdd.registration.text),
                          amount,
                          readAdd.note.text,
                          readAdd.operationDate.text,
                          readAdd.moneyType.text,
                          ref.read(currencyRiverpod).calculateRealAmount(
                            amount,
                            readAdd.moneyType.text,
                            ref.read(settingsRiverpod).Prefix!,
                          ),
                          readAdd.convertedCustomize,
                          readAdd.userCategoryController,
                          readAdd.systemMessage,
                        );

                        if (adCounter == 0) {
                          _showInterstitialAd(context);
                          readSettings.resetAdCounter();
                        } else {
                          readSettings.useAdCounter();
                        }
                        Navigator.of(context).pop();
                        read2.setCurrentindex(0);
                        readHome.setStatus();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Theme.of(context).highlightColor,
                            duration: const Duration(seconds: 1),
                            elevation: 0,
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                              translation(context).activityAdded,
                              style: TextStyle(
                                color: renkler.yaziRenk,
                                fontSize: 16,
                                fontFamily: 'Nexa3',
                                fontWeight: FontWeight.w600,
                                height: 1.3,
                              ),
                            ),
                          ),
                        );
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor:
                                Theme.of(context).primaryColor,
                                title: Text(translation(context).missingEntry,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .secondaryHeaderColor,
                                        fontSize: 22,
                                        height: 1,
                                        fontFamily: 'Nexa3')),
                                content: Text(
                                  alertContent,
                                  style: TextStyle(
                                      color: Theme.of(context).canvasColor,
                                      fontSize: 16,
                                      fontFamily: 'Nexa3'),
                                ),
                                shadowColor: renkler.koyuuRenk,
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      if (alertOperator == 1) {
                                        readAdd.amount.clear();
                                        readAdd.category.clear();
                                      } else if (alertOperator == 2) {
                                        readAdd.amount.clear();
                                      } else if (alertOperator == 3) {
                                        readAdd.category.clear();
                                      } else {
                                        readAdd.amount.clear();
                                        readAdd.category.clear();
                                      }
                                      Navigator.of(context).pop();
                                      //FocusScope.of(context).requestFocus(amountFocusNode);
                                    },
                                    child: Text(
                                      translation(context).ok,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .secondaryHeaderColor,
                                          fontSize: 18,
                                          height: 1,
                                          fontFamily: 'Nexa3'),
                                    ),
                                  )
                                ],
                              );
                            });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        color: Theme.of(context).disabledColor,
                      ),
                      height: 34,
                      width: size.width > 392 ? size.width * 0.39 : 150,
                      child: Center(
                        child: Text(translation(context).done,
                            style: TextStyle(
                                height: 1,
                                color: renkler.koyuuRenk,
                                fontSize: 16,
                                fontFamily: 'Nexa4',
                                fontWeight: FontWeight.w900)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}