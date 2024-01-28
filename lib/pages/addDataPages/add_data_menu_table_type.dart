import 'package:butcekontrol/classes/language.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/models/spend_info.dart';
import 'package:butcekontrol/pages/addDataPages/add_customize.dart';
import 'package:butcekontrol/pages/addDataPages/select_category.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:butcekontrol/utils/date_time_manager.dart';
import 'package:butcekontrol/utils/db_helper.dart';
import 'package:butcekontrol/utils/interstitial_ads.dart';
import 'package:butcekontrol/utils/textConverter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:intl/intl.dart' as intl;

class AddDataMenuTableType extends ConsumerStatefulWidget {
  const AddDataMenuTableType({Key? key}) : super(key: key);
  @override
  ConsumerState<AddDataMenuTableType> createState() => _AddDataMenuTableType();
}

class _AddDataMenuTableType extends ConsumerState<AddDataMenuTableType> {
  final InterstitialAdManager _interstitialAdManager = InterstitialAdManager();
  @override
  void initState() {
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

  void _showInterstitialAd(BuildContext context) {
    //_interstitialAdManager.loadInterstitialAd();
    _interstitialAdManager.showInterstitialAd(context);
  }

  
  void dispose() {
    //readAdd.category.dispose();
    //readAdd.customize.dispose();
    //_note.dispose();
    //_amount.dispose();
    //_operationType.dispose();
    //_operationTool.dispose();
    //_registration.dispose();
    //_operationDate.dispose();
    //_moneyType.dispose();
    amountFocusNode;
    dateFocusNode;
    super.dispose();
  }
  FocusNode amountFocusNode = FocusNode();
  FocusNode dateFocusNode = FocusNode();
  CustomColors renkler = CustomColors();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: SizedBox(
        height: size.height * 0.85,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                width: size.width * 0.95,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    typeCustomButton(context),
                    dateCustomButton(context)
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              categoryBarCustom(context, ref),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: size.width * 0.95,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    toolCustomButton(context),
                    regCustomButton(context),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              noteCustomButton(context),
              const SizedBox(
                height: 15,
              ),
              customizeBarCustom(context, ref),
              const SizedBox(
                height: 15,
              ),
              amountCustomButton(),
              const SizedBox(
                height: 5,
              ),
              /*SizedBox(
                  width: size.width * 0.98,
                  child: Text(
                      'DEBUG: ${_operationType.text} - ${readAdd.category.text} - ${readAdd.convertedCategory} - ${readAdd.userCategoryController} - ${_operationTool.text} - ${int.parse(_registration.text)} - ${_amount.text} - ${_note.text} - ${_operationDate.text} -${readAdd.customize.text} - ${readAdd.convertedCustomize} - ${selectedCustomizeMenu} - ${_moneyType.text}',
                      style: const TextStyle(
                          color: Colors.red, fontFamily: 'TL'))),*/
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget typeCustomButton(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var readAdd = ref.read(addDataRiverpod);
    return SizedBox(
        height: 34,
        child: getToggleSwitch(readAdd.initialLabelIndexForType, 2, [translation(context).expenses, translation(context).income], size.width > 392 ? size.width * 0.235 : 92, (index) {
          setState(() {
            if (index == 0) {
              readAdd.operationType.text = "Gider";
              readAdd.selectedCategory = 0;
              readAdd.category.clear();
              readAdd.selectedValue = null;
            } else {
              readAdd.operationType.text = "Gelir";
              readAdd.selectedCategory = 1;
              readAdd.category.clear();
              readAdd.selectedValue = null;
            }
            readAdd.categoryColorChanger = 999;
          });
          readAdd.initialLabelIndexForType = index!;
        }),
    );
  }


  Widget categoryBarCustom(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size;
    var readHome = ref.read(homeRiverpod);
    var readAdd = ref.read(addDataRiverpod);
    return SizedBox(
      height: 38,
      width: size.width * 0.95,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2, left: 2, right: 2),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                color: Theme.of(context).disabledColor,
              ),
              height: 34,
              width: (size.width * 0.95),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 114,
                height: 36,
                decoration: BoxDecoration(
                  color: Theme.of(context).highlightColor,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: Center(
                  child: Text(
                    translation(context).categoryDetails,
                    style: TextStyle(
                      height: 1,
                      color: renkler.yaziRenk,
                      fontSize: 14,
                      fontFamily: 'Nexa4',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              InkWell(
                highlightColor: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(30),
                child: SizedBox(
                  width: (size.width * 0.95) - 114,
                  child: Center(
                    child: Text(
                      readAdd.category.text == ""
                          ? translation(context).tapToSelect
                          : readAdd.category.text,
                      style: TextStyle(
                          height: 1,
                          fontSize: 14,
                          fontFamily: 'Nexa3',
                          color: renkler.koyuuRenk),
                      maxLines: 2,
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    readAdd.editChanger = 0;
                    readAdd.heightChanger = 40.0;
                    //readAdd.category.clear();
                    readAdd.selectedValue = null;
                  });
                  showDialog(
                    context: context,
                    builder: (context) {
                      return CategoryMenu();
                    },
                  ).then((_) => setState(() {}));

                },
              ),
            ],
          ),
        ],
      ),
    );
  }



  Widget customizeBarCustom(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size;
    var readAdd = ref.read(addDataRiverpod);
    return SizedBox(
      height: 38,
      width: size.width * 0.95,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2, left: 2, right: 2),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                //color: Theme.of(context).disabledColor,
                border: Border.all(color: Theme.of(context).highlightColor,width: 1.5)
              ),
              height: 34,
              width: size.width * 0.95,
            ),
          ),
          Row(
            children: [
              Container(
                width: 114,
                height: 36,
                decoration: BoxDecoration(
                  color: Theme.of(context).highlightColor,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 3,right: 3,left: 3),
                        child: Text(
                          translation(context).customize,
                          style: TextStyle(
                            color: renkler.yaziRenk,
                            fontSize: 14,
                            fontFamily: 'Nexa4',
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                highlightColor: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(30),
                child: SizedBox(
                  width: size.width * 0.95 - 114,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              readAdd.customize.text == ""
                                  ? translation(context).tapToCustomize
                                  : readAdd.selectedCustomizeMenu == 0
                                      ? '${translation(context).tekrarTurkEmpty} ${readAdd.customize.text} ${translation(context).turkTekrarOnly}' /// Uyuşmamalar nedeniyle bu şekilde çevrilmiştir
                                      : '${translation(context).taksitArabicOnly} ${readAdd.customize.text} ${translation(context).ayTaksitArapcaEpty} ${translation(context).taksitDevamArabicOnly}',
                              maxLines: 2,
                              style: TextStyle(
                                  height: 1,
                                  fontSize: 14,
                                  fontFamily: 'Nexa3',
                                  color: Theme.of(context).canvasColor),
                            ),
                          ),
                          Icon(
                            //Icons.event_repeat_rounded,
                            Icons.manage_history_rounded,
                            color: Theme.of(context).secondaryHeaderColor,
                            size: 22,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    readAdd.customize.clear();
                    readAdd.selectedValueCustomize = null;
                  });
                  showDialog(
                    context: context,
                    builder: (context) {
                      return CustomizeMenu();
                    },
                  ).then((_) => setState(() {}));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget dateCustomButton(BuildContext context) {
    var readAdd = ref.read(addDataRiverpod);
    Future<void> selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: readAdd.selectedDate ?? DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2030),
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        initialDatePickerMode: DatePickerMode.day,
        keyboardType: TextInputType.number,
        builder: (context, child) {
          FocusScope.of(context).unfocus();
          return Theme(
            data: Theme.of(context).copyWith(
            dialogTheme: DialogTheme(
                shadowColor: Colors.black54,
                  backgroundColor: Theme.of(context).indicatorColor,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)))),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: const RoundedRectangleBorder( borderRadius: BorderRadius.all(Radius.circular(10))),
                foregroundColor: Theme.of(context).canvasColor,
                textStyle: const TextStyle(fontFamily: "Nexa3",height: 1,fontSize: 15)// button text color
              ),
              ),
            dividerTheme: DividerThemeData(
                color: Theme.of(context).canvasColor,
                indent: 10,
                endIndent: 10,
                thickness: 1.5
              ),
            datePickerTheme: DatePickerThemeData(
                dayStyle: const TextStyle(fontFamily: "Nexa3",height: 1,fontSize: 15),
                todayForegroundColor: MaterialStatePropertyAll(Theme.of(context).disabledColor),
                dayOverlayColor: MaterialStatePropertyAll(Theme.of(context).disabledColor),
                headerForegroundColor: renkler.yaziRenk,
                weekdayStyle: TextStyle(fontFamily: "Nexa4",height: 1,fontSize: 15,color: Theme.of(context).secondaryHeaderColor),
                yearForegroundColor: MaterialStatePropertyAll(Theme.of(context).canvasColor),
                yearOverlayColor: MaterialStatePropertyAll(Theme.of(context).disabledColor),
                yearBackgroundColor: MaterialStatePropertyAll(Theme.of(context).primaryColor),
                headerBackgroundColor: renkler.koyuuRenk,
              ),
            textTheme: TextTheme(
                  labelSmall: const TextStyle(
                      ///tarih seçiniz
                      fontSize: 16,
                      fontFamily: 'Nexa4'),
                  titleSmall: TextStyle(
                      ///ay ve yıl
                      fontSize: 16,
                      fontFamily: 'Nexa3',
                      color: renkler.koyuuRenk),
                  headlineMedium: TextStyle(
                      ///gün ay gün
                      fontSize: 26,
                      fontFamily: 'Nexa3',
                      color: renkler.koyuuRenk),
                  bodyLarge: TextStyle(
                      ///alt YILLAR
                      fontSize: 16,
                      fontFamily: 'Nexa3',
                      color: Theme.of(context).disabledColor),
               ),
            colorScheme: ColorScheme(
                brightness: Brightness.light,
                primary: renkler.koyuuRenk, // üst taraf arkaplan rengi
                onPrimary: renkler.arkaRenk, //üst taraf yazı rengi
                secondary: renkler.kirmiziRenk,
                onSecondary: renkler.arkaRenk,
                primaryContainer: renkler.kirmiziRenk,
                error: const Color(0xFFD91A2A),
                onError: const Color(0xFFD91A2A),
                background: renkler.kirmiziRenk,
                onBackground: renkler.yesilRenk,
                surface: Theme.of(context).disabledColor, //ÜST TARAF RENK
                onPrimaryContainer: renkler.yesilRenk,
                onSurface: Theme.of(context).canvasColor, //alt günlerin rengi
              ),
            ),
            child: child!,
          );
        },
      );

      if (picked != null) {
        setState(() {
          readAdd.selectedDate = picked;
          readAdd.operationDate.text =
              intl.DateFormat('dd.MM.yyyy').format(readAdd.selectedDate!);
        });
      }
    }
    var readSettings = ref.read(settingsRiverpod);

    String getFormattedDate(String date){
      List <String> parts = date.split(".");
      int parseDay = int.parse(parts[0]);
      int parseMonth = int.parse(parts[1]);
      int parseYear = int.parse(parts[2]);
      String formattedDate = readSettings.dateFormat == "yyyy.MM.dd" ? "$parseYear.$parseMonth.$parseDay" : readSettings.dateFormat == "MM.dd.yyyy" ? "$parseMonth.$parseDay.$parseYear" : "$parseDay.$parseMonth.$parseYear";
      return formattedDate;
    }

    return SizedBox(
      height: 38,
      width: 134,
      child: Stack(
        children: [
          getDecoratedBox(132, 34, BorderRadius.all(Radius.circular(15)),padding: EdgeInsets.only(top: 2),boxColor: Theme.of(context).highlightColor),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 34,
                child: Center(
                  child: Icon(
                    Icons.edit_calendar_rounded,
                    color: renkler.yaziRenk,
                    size: 22,
                  )
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(40)),
                  color: Theme.of(context).disabledColor,
                ),
                child: SizedBox(
                  height: 38,
                  width: 100,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: InkWell(
                      onTap: () {
                        selectDate(context);
                      },
                      child: Center(
                          child: getLineText(getFormattedDate(readAdd.operationDate.text), renkler.koyuuRenk, 13,fontFamily: "Nexa4")),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget amountCustomButton() {
    var readAdd = ref.read(addDataRiverpod);
    String moneyActivate = readAdd.operationType.text == "Gider" ? "" : "1";
    String getSymbolForMoneyType() {
      String controller = readAdd.moneyType.text;
      if (controller == 'TRY$moneyActivate') {
        return '₺';
      } else if (controller == 'USD$moneyActivate') {
        return '\$';
      } else if (controller == 'EUR$moneyActivate') {
        return '€';
      } else if (controller == 'GBP$moneyActivate') {
        return '£';
      } else if (controller == 'KWD$moneyActivate') {
        return 'د.ك';
      } else if (controller == 'JOD$moneyActivate') {
        return 'د.أ';
      } else if (controller == 'IQD$moneyActivate') {
        return 'د.ع';
      } else if (controller == 'SAR$moneyActivate') {
        return 'ر.س';
      } else {
        setState(() {
          readAdd.moneyType.text = "${ref.read(settingsRiverpod).Prefix}$moneyActivate";
        });
        return getSymbolForMoneyType();
      }
    }

    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.95,
      child: Stack(
        children: [
          Positioned(
            top: 40,
            child: getDecoratedBox(size.width * 0.95, 4, BorderRadius.all(Radius.circular(20)),boxColor: Theme.of(context).highlightColor),
          ),
          Center(
            child: SizedBox(
              width: 250,
              height: 80,
              child: Row(
                children: [
                  readAdd.openMoneyTypeMenu == false
                      ? SizedBox(
                          height: 38,
                          width: 207,
                          child: Stack(
                            children: [
                              Center(
                                child: getDecoratedBox(205, 34, BorderRadius.all(Radius.circular(40)),boxColor:Theme.of(context).highlightColor ),
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 95,
                                    child: Center(
                                      child: getLineText(translation(context).amountDetails, renkler.yaziRenk, 15,fontFamily: "Nexa4",weight: FontWeight.w800),
                                    ),
                                  ),
                                  Container(
                                    width: 112,
                                    height: 38,
                                    decoration:  BoxDecoration(
                                      borderRadius:
                                          const BorderRadius.all(Radius.circular(15)),
                                      color: Theme.of(context).disabledColor,
                                    ),
                                    child: SizedBox(
                                      height: 38,
                                      child: TextFormField(
                                          onTap: () {
                                            //_amount.clear();
                                          },
                                          style: const TextStyle(
                                              color: Color(0xff0D1C26),
                                              fontSize: 17,
                                              fontFamily: 'Nexa4',
                                              fontWeight: FontWeight.w100),
                                          controller: readAdd.amount,
                                          autofocus: false,
                                          focusNode: amountFocusNode,
                                          keyboardType: const TextInputType
                                              .numberWithOptions(decimal: true),
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                              RegExp(r'^\d{0,7}(\.\d{0,2})?'),
                                            )
                                          ],
                                          textAlign: TextAlign.center,
                                          onEditingComplete: () {
                                            FocusScope.of(context).unfocus();
                                          },
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              isDense: true,
                                              hintText: "00.00",
                                              hintStyle: TextStyle(
                                                color: renkler.koyuAraRenk,
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      top: 12))),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                  readAdd.openMoneyTypeMenu == false
                      ? const SizedBox(
                          width: 5,
                        )
                      : const SizedBox(),
                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      setState(() {
                        readAdd.openMoneyTypeMenu == false
                            ? readAdd.openMoneyTypeMenu = true
                            : readAdd.openMoneyTypeMenu = false;
                        readAdd.openMoneyTypeMenu == true
                            ? readAdd.moneyTypeWidth = 250
                            : readAdd.moneyTypeWidth = 38;
                        readAdd.openMoneyTypeMenu == true
                            ? readAdd.moneyTypeHeight = 80
                            : readAdd.moneyTypeHeight = 38;
                      });
                    },
                    child: Container(
                      height: readAdd.moneyTypeHeight,
                      width: readAdd.moneyTypeWidth,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        color: Theme.of(context).disabledColor,
                      ),
                      child: readAdd.openMoneyTypeMenu == false
                          ? Center(
                              child: getLineText(getSymbolForMoneyType(), renkler.koyuuRenk, 22,fontFamily: "TL",weight: FontWeight.w500),)
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    getAmountContainer(() {
                                          setState(() {
                                            readAdd.moneyType.text = 'TRY$moneyActivate';
                                            readAdd.openMoneyTypeMenu = false;
                                            readAdd.moneyTypeWidth = 38.0;
                                            readAdd.moneyTypeHeight = 38.0;
                                          });
                                        },"TRY"),
                                    getAmountContainer(() {
                                              setState(() {
                                                readAdd.moneyType.text = 'USD$moneyActivate';
                                                readAdd.openMoneyTypeMenu = false;
                                                readAdd.moneyTypeWidth = 38.0;
                                                readAdd.moneyTypeHeight = 38.0;
                                              });
                                        },"USD"),
                                    getAmountContainer(() {
                                              setState(() {
                                                readAdd.moneyType.text = 'EUR$moneyActivate';
                                                readAdd.openMoneyTypeMenu = false;
                                                readAdd.moneyTypeWidth = 38.0;
                                                readAdd.moneyTypeHeight = 38.0;
                                              });
                                        },"EUR"),
                                    getAmountContainer(() {
                                              setState(() {
                                                readAdd.moneyType.text = 'GBP$moneyActivate';
                                                readAdd.openMoneyTypeMenu = false;
                                                readAdd.moneyTypeWidth = 38.0;
                                                readAdd.moneyTypeHeight = 38.0;
                                              });
                                        },"GBP"),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    getAmountContainer(() {
                                      setState(() {
                                        readAdd.moneyType.text = 'KWD$moneyActivate';
                                        readAdd.openMoneyTypeMenu = false;
                                        readAdd.moneyTypeWidth = 38.0;
                                        readAdd.moneyTypeHeight = 38.0;
                                      });
                                    },"KWD"),
                                    getAmountContainer(() {
                                      setState(() {
                                        readAdd.moneyType.text = 'JOD$moneyActivate';
                                        readAdd.openMoneyTypeMenu = false;
                                        readAdd.moneyTypeWidth = 38.0;
                                        readAdd.moneyTypeHeight = 38.0;
                                      });
                                    },"JOD"),
                                    getAmountContainer(() {
                                      setState(() {
                                        readAdd.moneyType.text = 'IQD$moneyActivate';
                                        readAdd.openMoneyTypeMenu = false;
                                        readAdd.moneyTypeWidth = 38.0;
                                        readAdd.moneyTypeHeight = 38.0;
                                      });
                                    },"IQD"),
                                    getAmountContainer(() {
                                      setState(() {
                                        readAdd.moneyType.text = 'SAR$moneyActivate';
                                        readAdd.openMoneyTypeMenu = false;
                                        readAdd.moneyTypeWidth = 38.0;
                                        readAdd.moneyTypeHeight = 38.0;
                                      });
                                    },"SAR"),
                                  ],
                                ),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget toolCustomButton(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var readAdd = ref.read(addDataRiverpod);
    return SizedBox(
        height: 34,
        child : getToggleSwitch(
            readAdd.initialLabelIndexForTool, 3,
            [translation(context).cash, translation(context).card, translation(context).otherPaye],
            size.width > 392 ? size.width * 0.18 : 70,
            (index) {
              if (index == 0) {
                readAdd.operationTool.text = "Nakit";
              } else if (index == 1) {
                readAdd.operationTool.text = "Kart";
              } else {
                readAdd.operationTool.text = "Diğer";
              }
              readAdd.initialLabelIndexForTool = index!;
            }
        ),);
  }


  Widget regCustomButton(BuildContext context) {
    var readAdd = ref.read(addDataRiverpod);
    return SizedBox(
      height: 38,
      width: 110,
      child: Stack(
        children: [
          getDecoratedBox(104, 34, BorderRadius.all(Radius.circular(15)),padding:EdgeInsets.only(top: 2),boxColor: Theme.of(context).highlightColor),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 70,
                child: Center(
                  child: getLineText(translation(context).save, renkler.yaziRenk, 13,fontFamily: "Nexa4",weight: FontWeight.w800),
                ),
              ),
              getDecoratedBox(38, 38, BorderRadius.all(Radius.circular(20)),boxColor: Theme.of(context).disabledColor,child: registration(readAdd.regsController)),
            ],
          ),
        ],
      ),
    );
  }
  Widget registration(int regs) {
    var readAdd = ref.read(addDataRiverpod);
    if (regs == 0) {
      return GestureDetector(
          onTap: () {
            setState(() {
              readAdd.regsController = 1;
              readAdd.registration.text = '1';
            });
          },
          child: Center(
            child: Icon(
              Icons.bookmark_add_outlined,
              color: renkler.yaziRenk,
            ),
          ));
    } else {
      return IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            setState(() {
              readAdd.regsController = 0;
              readAdd.registration.text = '0';
            });
          },
          icon: const Icon(
            Icons.bookmark,
            color: Color(0xff0D1C26),
          ));
    }
  }


  Widget noteCustomButton(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var readAdd = ref.read(addDataRiverpod);
    return SizedBox(
      width: size.width * 0.95,
      height: 125,
      child: Stack(
        children: [
          getDecoratedBox(size.width * 0.95, 90,
            BorderRadius.all(Radius.circular(15)),
            padding: EdgeInsets.only(top: 20),
            border: Border.all(color: Theme.of(context).highlightColor, width: 1.5)),
          SizedBox(
            width: size.width * 0.94,
            height: 115,
            child: Stack(
              children: [
                getTextFormField(translation(context).clickToAddNote,readAdd.maxLength,3,readAdd.note,padding:EdgeInsets.only(left: 18, top: 34, right: 18) ),
                Positioned(
                    bottom: 0,
                    right: 20,
                    child: getLineText('${readAdd.note.text.length}/${readAdd.maxLength.toString()}', Theme.of(context).disabledColor, 13,fontFamily: "Nexa4",weight: FontWeight.w800,backgroundColor: Theme.of(context).splashColor)),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getDecoratedBox(boxColor: Theme.of(context).secondaryHeaderColor, 110, 34,
                BorderRadius.all(Radius.circular(20)),
                child : Center(child: getLineText(translation(context).addNote, Theme.of(context).primaryColor, 14,fontFamily:  'Nexa4',weight: FontWeight.w800)),
                padding: EdgeInsets.only(left: 20, right: 20)),
              getDecoratedBox(boxColor :Theme.of(context).shadowColor, 60, 26,
                BorderRadius.all(Radius.circular(10)),
                child : GestureDetector(
                  onTap: () {
                    setState(() {
                      readAdd.note.text = "";
                    });
                  },
                  child: Center(
                    child: getLineText(translation(context).delete,Theme.of(context).canvasColor,12,fontFamily: "Nexa4",weight: FontWeight.w200),
                  ),
                ),
                padding: EdgeInsets.only(right: 20, left: 20)),
            ],
          ),
        ],
      ),
    );
  }


  DateTime convertDateTime(String Date){
    var date = Date.split(".");
    return DateTime(int.parse(date[2]), int.parse(date[1]), int.parse(date[0]));
  }
  Widget getToggleSwitch(int? initialLabel, int totalSwitch,List<String>? labels,double minWidth,Function(int?)? onToggle){
    return ToggleSwitch(
      initialLabelIndex: initialLabel,
      totalSwitches: totalSwitch,
      dividerColor: Theme.of(context).highlightColor,
      labels: labels,
      activeBgColor: [Theme.of(context).disabledColor],
      activeFgColor: const Color(0xff0D1C26),
      inactiveBgColor: Theme.of(context).highlightColor,
      inactiveFgColor: const Color(0xFFE9E9E9),
      minWidth: minWidth,
      cornerRadius: 15,
      radiusStyle: true,
      animate: true,
      curve: Curves.linearToEaseOut,
      customTextStyles: const [
        TextStyle(
            fontSize: 13,
            fontFamily: 'Nexa4',
            height: 1,
            fontWeight: FontWeight.w800)
      ],
      onToggle: onToggle,
    );
  }

  Widget getLineText(String text,Color textColor,double size,{String? fontFamily,FontWeight? weight , Color? backgroundColor}){
    return Text(
      text,style: TextStyle(
      color: textColor,
      height: 1,
      fontFamily: fontFamily ?? "Nexa3",
      fontSize: size,
      fontWeight: weight ?? FontWeight.normal,
      backgroundColor: backgroundColor
    ),
    );
  }

  Widget getDecoratedBox(double width,double height,BorderRadiusGeometry radius,{Color? boxColor,Widget? child,EdgeInsetsGeometry? padding,BoxBorder? border}){
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: SizedBox(
        width: width,
        height: height,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: radius,
            color: boxColor,
            border: border
          ),
          child: child,
        ),
      ),
    );
  }

  Widget getTextFormField(String hintText,int maxLength,int maxLines,TextEditingController? controller,{EdgeInsetsGeometry? padding,}){
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: TextFormField(
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 14,
              color: Theme.of(context).canvasColor,
            ),
            counterText: "",
            border: InputBorder.none),
        cursorRadius: const Radius.circular(10),
        autofocus: false,
        maxLength: maxLength,
        maxLines: maxLines,
        onChanged: (value) {
          setState(() {

          });
        },
        keyboardType: TextInputType.text,
        controller: controller,
        //maxLengthEnforcement: MaxLengthEnforcement.enforced,
      ),
    );
  }

  Widget getAmountContainer(Function()? onTap,String text){
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 32,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
              Radius.circular(15)),
          color: renkler.koyuuRenk,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 14,
                fontFamily: 'Nexa4',
                color: renkler.arkaRenk),
          ),
        ),
      ),
    );

  }
}