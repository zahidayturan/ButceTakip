import 'package:butcetakip/UI/fezai_checkbox.dart';
import 'package:butcetakip/classes/language.dart';
import 'package:butcetakip/constants/material_color.dart';
import 'package:butcetakip/utils/firestore_helper.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' as intl;
import '../app/data/models/currency_info.dart';
import '../classes/app_bar_for_page.dart';
import '../riverpod_management.dart';

class Calculator extends ConsumerStatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  ConsumerState<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends ConsumerState<Calculator> {
  @override
  Widget build(BuildContext context) {
    CustomColors renkler = CustomColors();
    var size = MediaQuery.of(context).size;
    var watchCurrency = ref.watch(currencyRiverpod);
    var read2 = ref.read(botomNavBarRiverpod);
    return WillPopScope(
      onWillPop: () async {
        read2.setCurrentindex(0);
        return false;
      },
      child: Container(
        color: const Color(0xFF03111A),
        child: SafeArea(
          child: Scaffold(
            appBar: AppBarForPage(title: translation(context).calculatorTitle),
            resizeToAvoidBottomInset: false,
            body: Container(
              color: Theme.of(context).highlightColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ref.read(currencyRiverpod).lastApiUpdateDate != null
                    ? currencyConverter(context)
                    : Center(
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.width * .17,
                            width: size.width * .17,
                            child: CircularProgressIndicator(
                              color: Theme.of(context).disabledColor,
                              backgroundColor: renkler.koyuuRenk,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              translation(context).currencyConverterWarning,
                              style: TextStyle(
                                  color: renkler.yaziRenk, fontSize: 15),
                            ),
                          )
                        ],
                      )),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextEditingController nums = TextEditingController();
  TextEditingController sonuc = TextEditingController();
  void dispose2() {
    nums.dispose();
    sonuc.dispose();
    super.dispose();
  }

  PageController pageCurrency = PageController();
  PageController pageCurrency2 = PageController(initialPage: 1);
  int selectedCurrency = 0;
  int selectedCurrency2 = 1;
  void switchCurrency(BuildContext context) {
    double kur = 16.5;
    double amount = 0.0;
    double kurdolar = (double.tryParse(ref.read(currencyRiverpod).TRY!)! /
        double.tryParse(ref.read(currencyRiverpod).USD!)!);
    double kureuro = 21.49;
    if (selectedCurrency == selectedCurrency2) {
      kur = 1;
    } else if (selectedCurrency == 0 && selectedCurrency2 == 1) {
      kur = 1 / kurdolar;
    } else if (selectedCurrency == 0 && selectedCurrency2 == 2) {
      kur = 1 / kureuro;
    } else if (selectedCurrency == 1 && selectedCurrency2 == 0) {
      kur = kurdolar;
    } else if (selectedCurrency == 1 && selectedCurrency2 == 2) {
      kur = kurdolar / kureuro;
    } else if (selectedCurrency == 2 && selectedCurrency2 == 0) {
      kur = kureuro;
    } else if (selectedCurrency == 2 && selectedCurrency2 == 1) {
      kur = kureuro / kurdolar;
    } else {
      kur = 10;
    }
    setState(() {
      amount = double.parse(nums.text) * kur;
      sonuc.text = amount.toStringAsFixed(2);
    });
  }

  String first = "TRY";
  String second = "USD";
  String? mode;
  String? date;
  String year = "-";
  String month = "-";
  String day = "-";
  currencyInfo? currency;
  bool currentRates = true;
  bool historyRates = false;
  final TextEditingController _controllerFirst = TextEditingController();
  final TextEditingController _controllerSecond = TextEditingController();

  void calculateCurrencyConvert(var readCurrency, String value) {
    if (_controllerFirst.text != "") {
      var result = readCurrency.calculateRealAmount(
          double.tryParse(_controllerFirst.text)!, first, second,
          currency: currency);
      _controllerSecond.text = result.toString();
    } else {
      _controllerSecond.text = "";
    }
  }

  List<currencyInfo> historyfirst = [];
  List<String> years = ["-"];
  List<String> months = ["-"];
  List<String> days = ["-"];

  Widget currencyConverter(BuildContext context) {
    var renkler = CustomColors();
    var size = MediaQuery.of(context).size;
    DateTime now = DateTime.now();
    String formattedDate =
        intl.DateFormat(ref.read(settingsRiverpod).dateFormat).format(now);
    var readCurrency = ref.read(currencyRiverpod);
    Future<List<currencyInfo>> historyCurrency =
        firestoreHelper.getHistoryCurrency();

    List<String> moneyPrefix = <String>[
      'TRY',
      "USD",
      "EUR",
      "GBP",
      "KWD",
      "JOD",
      "IQD",
      "SAR"
    ];

    var dateText =
        currency?.lastApiUpdateDate?.split(" ")[0].replaceAll("-", ".") ??
            readCurrency.lastApiUpdateDate!.split(" ")[0].replaceAll("-", ".");

    DateTime dateTextForFormat = DateTime(int.parse(dateText.split(".")[0]),
        int.parse(dateText.split(".")[1]), int.parse(dateText.split(".")[2]));

    var readSettings = ref.watch(settingsRiverpod);
    return SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 15, bottom: 20, left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 24,
          children: [
            Text(
              translation(context).currencyConverter,
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Nexa4',
                color: Theme.of(context).disabledColor,
              ),
            ),
            SizedBox(
              height: size.height * .16,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 30,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Theme.of(context).disabledColor,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Center(
                                child: Text(
                                  translation(context).select,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Nexa3',
                                    height: 1,
                                    color: renkler.arkaRenk,
                                  ),
                                ),
                              ),
                              items: moneyPrefix
                                  .map((item) => DropdownMenuItem(
                                        value: item,
                                        child: Center(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2),
                                            child: Text(
                                              item,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  height: 1,
                                                  fontFamily: 'Nexa3',
                                                  color: renkler.koyuuRenk),
                                            ),
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              value: first.toString(),
                              onChanged: (newValue) {
                                setState(() {
                                  first = newValue!;
                                });
                                calculateCurrencyConvert(
                                    readCurrency, _controllerFirst.text);
                              },
                              //barrierColor: renkler.koyuAraRenk.withOpacity(0.8),
                              buttonStyleData: ButtonStyleData(
                                overlayColor: WidgetStatePropertyAll(renkler
                                    .koyuAraRenk), // BAŞLANGIÇ BASILMA RENGİ
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                height: 30,
                                width: 80,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                //maxHeight: 150,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: renkler.sariRenk,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5))),
                              ),
                              menuItemStyleData: MenuItemStyleData(
                                overlayColor: WidgetStatePropertyAll(
                                    renkler.koyuAraRenk), // MENÜ BASILMA RENGİ
                                height: 34,
                              ),
                              iconStyleData: IconStyleData(
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                ),
                                iconSize: 24,
                                iconEnabledColor: renkler.koyuAraRenk,
                                iconDisabledColor:
                                    Theme.of(context).secondaryHeaderColor,
                                openMenuIcon: Icon(
                                  Icons.arrow_drop_up,
                                  color: Theme.of(context).canvasColor,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: size.width * .33,
                          height: 30,
                          decoration: BoxDecoration(
                              color: Theme.of(context).canvasColor,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: Theme.of(context).dialogBackgroundColor,
                                strokeAlign: BorderSide.strokeAlignCenter,
                                width: 1,
                              )),
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 36,
                                  //height: 30,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: FittedBox(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 3),
                                        child: Text(
                                          readSettings.convertPrefix(first),
                                          style: TextStyle(
                                            height: 1,
                                            color: Theme.of(context).cardColor,
                                            fontFamily: "TL",
                                            fontSize: 24,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 2),
                                SizedBox(
                                  width: size.width * 0.33 - 39,
                                  child: TextField(
                                    onChanged: (value) async {
                                      calculateCurrencyConvert(
                                          readCurrency, value);
                                    },
                                    textAlign: TextAlign.center,
                                    controller: _controllerFirst,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      fontSize: 15,
                                      height: 1,
                                    ),
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d{0,8}(\.\d{0,2})?'),
                                      )
                                    ],
                                    decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: const EdgeInsets.only(
                                            top: 3, left: 2, right: 2),
                                        hintText: translation(context).amount,
                                        hintStyle: TextStyle(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          fontSize: 15,
                                        ),
                                        border: InputBorder.none),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _controllerFirst.text = "";
                            _controllerSecond.text = "";
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.backspace,
                                color: Theme.of(context).disabledColor,
                                size: 18,
                              ),
                              const SizedBox(width: 5),
                              Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Text(
                                  translation(context).delete,
                                  style: TextStyle(
                                    height: 1,
                                    color: renkler.arkaRenk,
                                    fontFamily: "Nexa3",
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            readSettings.localChanger() != const Locale("ar")
                                ? Icons.double_arrow_rounded
                                : Icons.keyboard_double_arrow_left_rounded,
                            color: renkler.arkaRenk,
                            size: 28,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                var a = first;
                                first = second;
                                second = a;
                              });
                              calculateCurrencyConvert(
                                  readCurrency, _controllerFirst.text);
                            },
                            child: Image.asset(
                              "assets/icons/swap2.png",
                              width: 26,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 30,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Theme.of(context).disabledColor,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Center(
                                child: Text(
                                  translation(context).all,
                                  style: TextStyle(
                                    fontSize: 14,
                                    height: 1,
                                    fontFamily: 'Nexa3',
                                    color: renkler.arkaRenk,
                                  ),
                                ),
                              ),
                              items: moneyPrefix
                                  .map((item) => DropdownMenuItem(
                                        value: item,
                                        child: Center(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2),
                                            child: Text(
                                              item,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  height: 1,
                                                  fontFamily: 'Nexa3',
                                                  color: renkler.koyuuRenk),
                                            ),
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              value: second.toString(),
                              onChanged: (newValue) {
                                setState(() {
                                  second = newValue!;
                                });
                                calculateCurrencyConvert(
                                    readCurrency, _controllerFirst.text);
                              },
                              //barrierColor: renkler.koyuAraRenk.withOpacity(0.8),
                              buttonStyleData: ButtonStyleData(
                                overlayColor: WidgetStatePropertyAll(renkler
                                    .koyuAraRenk), // BAŞLANGIÇ BASILMA RENGİ
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                height: 30,
                                width: 80,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                //maxHeight: 150,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: renkler.sariRenk,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5))),
                              ),
                              menuItemStyleData: MenuItemStyleData(
                                overlayColor: WidgetStatePropertyAll(
                                    renkler.koyuAraRenk), // MENÜ BASILMA RENGİ
                                height: 34,
                              ),
                              iconStyleData: IconStyleData(
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                ),
                                iconSize: 24,
                                iconEnabledColor: renkler.koyuAraRenk,
                                iconDisabledColor:
                                    Theme.of(context).secondaryHeaderColor,
                                openMenuIcon: Icon(
                                  Icons.arrow_drop_up,
                                  color: Theme.of(context).canvasColor,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: size.width * .33,
                          height: 30,
                          decoration: BoxDecoration(
                              color: Theme.of(context).canvasColor,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: Theme.of(context).dialogBackgroundColor,
                                strokeAlign: BorderSide.strokeAlignCenter,
                                width: 1,
                              )),
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: size.width * 0.33 - 39,
                                  child: TextField(
                                    readOnly: true,
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    controller: _controllerSecond,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        fontSize: 15,
                                        height: 1),
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d{0,8}(\.\d{0,2})?'),
                                      )
                                    ],
                                    decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(
                                            top: 3, left: 2, right: 2),
                                        isDense: true,
                                        hintText: translation(context).result,
                                        hintStyle: TextStyle(
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            fontSize: 15,
                                            height: 1),
                                        border: InputBorder.none),
                                  ),
                                ),
                                const SizedBox(width: 2),
                                SizedBox(
                                  width: 36,
                                  //height: 30,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: FittedBox(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 3, right: 2),
                                        child: Text(
                                          readSettings.convertPrefix(second),
                                          style: TextStyle(
                                            height: 1,
                                            color: Theme.of(context).cardColor,
                                            fontFamily: "TL",
                                            fontSize: 24,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (_controllerFirst.text != "") {
                              Clipboard.setData(
                                  ClipboardData(text: _controllerSecond.text));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: const Color(0xff0D1C26),
                                  duration: const Duration(seconds: 1),
                                  elevation: 0,
                                  behavior: SnackBarBehavior.floating,
                                  content: Text(
                                    '${translation(context).copiedToClipboard}  ${_controllerSecond.text}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: 'Nexa3',
                                      fontWeight: FontWeight.w600,
                                      height: 1.3,
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                          child: SizedBox(
                            //width: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Text(
                                    translation(context).copy,
                                    style: TextStyle(
                                      height: 1,
                                      color: renkler.arkaRenk,
                                      fontFamily: "Nexa3",
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.copy,
                                  color: Theme.of(context).disabledColor,
                                  size: 19,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            historyRates && currency == null
                ? SizedBox(
                    height: size.height * .26,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).disabledColor,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2<String>(
                                    isExpanded: true,
                                    hint: Center(
                                      child: Text(
                                        "-",
                                        style: TextStyle(
                                          fontSize: 12,
                                          height: 1,
                                          fontFamily: 'Nexa3',
                                          color: renkler.koyuuRenk,
                                        ),
                                      ),
                                    ),
                                    items: days
                                        .map((item) => DropdownMenuItem(
                                              value: item,
                                              child: Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 2),
                                                  child: Text(
                                                    item,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        height: 1,
                                                        fontFamily: 'Nexa3',
                                                        color:
                                                            renkler.koyuuRenk),
                                                  ),
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    value: day,
                                    onChanged: (newValue) {
                                      setState(() {
                                        day = newValue!;
                                        mode = "day";
                                      });
                                      Future.delayed(
                                              Duration(milliseconds: 100))
                                          .then((value) {
                                        setState(() {});
                                      });
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      overlayColor: MaterialStatePropertyAll(renkler
                                          .koyuAraRenk), // BAŞLANGIÇ BASILMA RENGİ
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      height: 18,
                                      width: 50,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: 200,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          color: renkler.sariRenk,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5))),
                                    ),
                                    menuItemStyleData: MenuItemStyleData(
                                      overlayColor: MaterialStatePropertyAll(
                                          renkler
                                              .koyuAraRenk), // MENÜ BASILMA RENGİ
                                      height: 32,
                                    ),
                                    iconStyleData: IconStyleData(
                                      icon: const Icon(
                                        Icons.arrow_drop_down,
                                      ),
                                      iconSize: 24,
                                      iconEnabledColor: renkler.koyuAraRenk,
                                      iconDisabledColor: Theme.of(context)
                                          .secondaryHeaderColor,
                                      openMenuIcon: Icon(
                                        Icons.arrow_drop_up,
                                        color: Theme.of(context).canvasColor,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).disabledColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2<String>(
                                    isExpanded: true,
                                    hint: Center(
                                      child: Text(
                                        "-",
                                        style: TextStyle(
                                          fontSize: 12,
                                          height: 1,
                                          fontFamily: 'Nexa3',
                                          color: renkler.koyuuRenk,
                                        ),
                                      ),
                                    ),
                                    items: months
                                        .map((item) => DropdownMenuItem(
                                              value: item,
                                              child: Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 2),
                                                  child: Text(
                                                    item,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        height: 1,
                                                        fontFamily: 'Nexa3',
                                                        color:
                                                            renkler.koyuuRenk),
                                                  ),
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    value: month,
                                    onChanged: (newValue) {
                                      setState(() {
                                        month = newValue!;
                                        mode = "month";
                                      });
                                      Future.delayed(
                                              Duration(milliseconds: 100))
                                          .then((value) {
                                        setState(() {});
                                      });
                                    },
                                    //barrierColor: renkler.koyuAraRenk.withOpacity(0.8),
                                    buttonStyleData: ButtonStyleData(
                                      overlayColor: MaterialStatePropertyAll(renkler
                                          .koyuAraRenk), // BAŞLANGIÇ BASILMA RENGİ
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      height: 18,
                                      width: 50,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: 200,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          color: renkler.sariRenk,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5))),
                                    ),
                                    menuItemStyleData: MenuItemStyleData(
                                      overlayColor: MaterialStatePropertyAll(
                                          renkler
                                              .koyuAraRenk), // MENÜ BASILMA RENGİ
                                      height: 32,
                                    ),
                                    iconStyleData: IconStyleData(
                                      icon: const Icon(
                                        Icons.arrow_drop_down,
                                      ),
                                      iconSize: 24,
                                      iconEnabledColor: renkler.koyuAraRenk,
                                      iconDisabledColor: Theme.of(context)
                                          .secondaryHeaderColor,
                                      openMenuIcon: Icon(
                                        Icons.arrow_drop_up,
                                        color: Theme.of(context).canvasColor,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).disabledColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2<String>(
                                    isExpanded: true,
                                    hint: Center(
                                      child: Text(
                                        "-",
                                        style: TextStyle(
                                          fontSize: 12,
                                          height: 1,
                                          fontFamily: 'Nexa3',
                                          color: renkler.koyuuRenk,
                                        ),
                                      ),
                                    ),
                                    items: years
                                        .map((item) => DropdownMenuItem(
                                              value: item,
                                              child: Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 2),
                                                  child: Text(
                                                    item,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        height: 1,
                                                        fontFamily: 'Nexa3',
                                                        color:
                                                            renkler.koyuuRenk),
                                                  ),
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    value: year,
                                    onChanged: (newValue) {
                                      setState(() {
                                        year = newValue!;
                                        mode = "year";
                                      });
                                      Future.delayed(
                                              Duration(milliseconds: 100))
                                          .then((value) {
                                        setState(() {});
                                      });
                                    },
                                    //barrierColor: renkler.koyuAraRenk.withOpacity(0.8),
                                    buttonStyleData: ButtonStyleData(
                                      overlayColor: MaterialStatePropertyAll(renkler
                                          .koyuAraRenk), // BAŞLANGIÇ BASILMA RENGİ
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      height: 18,
                                      width: 80,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: 200,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          color: renkler.sariRenk,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5))),
                                    ),
                                    menuItemStyleData: MenuItemStyleData(
                                      overlayColor: MaterialStatePropertyAll(
                                          renkler
                                              .koyuAraRenk), // MENÜ BASILMA RENGİ
                                      height: 32,
                                    ),
                                    iconStyleData: IconStyleData(
                                      icon: const Icon(
                                        Icons.arrow_drop_down,
                                      ),
                                      iconSize: 24,
                                      iconEnabledColor: renkler.koyuAraRenk,
                                      iconDisabledColor: Theme.of(context)
                                          .secondaryHeaderColor,
                                      openMenuIcon: Icon(
                                        Icons.arrow_drop_up,
                                        color: Theme.of(context).canvasColor,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (historyRates) {
                                    setState(() {
                                      date = null;
                                      currency = null;
                                      currentRates = true;
                                      historyRates = false;
                                    });
                                    calculateCurrencyConvert(
                                        readCurrency, _controllerFirst.text);
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: FittedBox(
                                    child: Text(
                                      translation(context).close,
                                      style: TextStyle(
                                        height: 1,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: FutureBuilder(
                            future: historyCurrency,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var temp = snapshot.data;
                                if (historyfirst.isEmpty) {
                                  parsedDate(ref, temp!);
                                  Future.delayed(Duration(milliseconds: 100))
                                      .then((value) {
                                    setState(() {});
                                  });
                                }
                                historyfirst = filterDateCurrency(ref, temp!,
                                    day: int.tryParse(day),
                                    month: int.tryParse(month),
                                    year: int.tryParse(year));
                                return GridView.builder(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  physics: const BouncingScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: size.width * .02,
                                          mainAxisSpacing: size.height * .008,
                                          childAspectRatio: 3.35),
                                  itemCount: historyfirst.length,
                                  itemBuilder: (context, index) {
                                    int? darkMode = readSettings.DarkMode;
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          date = historyfirst[index]
                                              .lastApiUpdateDate!
                                              .split(" ")[0]
                                              .replaceAll("-", ".");
                                          currency = historyfirst[index];
                                        });
                                        calculateCurrencyConvert(readCurrency,
                                            _controllerFirst.text);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFF0D1C26),
                                          boxShadow: darkMode == 1
                                              ? [
                                                  BoxShadow(
                                                    color: Colors.black54
                                                        .withOpacity(0.8),
                                                    spreadRadius: 1,
                                                    blurRadius: 2,
                                                    offset: const Offset(-1, 2),
                                                  )
                                                ]
                                              : [
                                                  BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.2),
                                                      spreadRadius: 0.5,
                                                      blurRadius: 2,
                                                      offset:
                                                          const Offset(0, 2))
                                                ],
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5)),
                                          border: Border.all(
                                              color: Theme.of(context)
                                                  .indicatorColor, // Set border color
                                              width: 1.0),
                                          //color: Theme.of(context).primaryColor,
                                        ),
                                        child: Center(
                                          child: Text(
                                            historyfirst[index]
                                                .lastApiUpdateDate!
                                                .split(" ")[0]
                                                .replaceAll("-", "."),
                                            style: const TextStyle(
                                                color: Color(0xFFE9E9E9),
                                                fontFamily: "Nexa3"),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return Center(
                                  child: Text(
                                    translation(context).loading,
                                    style: TextStyle(
                                        color: Theme.of(context).disabledColor,
                                        fontFamily: "Nexa2",
                                        fontSize: 13),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: size.height * .08,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 3),
                                  child: fezaiCheckBox(
                                    value: currentRates,
                                    clickedColor:
                                        Theme.of(context).disabledColor,
                                    onChanged: (value) {
                                      if (historyRates) {
                                        setState(() {
                                          date = null;
                                          currency = null;
                                          currentRates = value;
                                          historyRates = false;
                                        });
                                        calculateCurrencyConvert(readCurrency,
                                            _controllerFirst.text);
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Text(
                                    translation(context)
                                        .calculateFromCurrentExchangeRate,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Nexa3",
                                        fontSize: 14),
                                  ),
                                ),
                                Text(
                                  formattedDate,
                                  style: TextStyle(
                                      color: Theme.of(context).disabledColor,
                                      fontFamily: "Nexa4",
                                      fontSize: 13),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 3),
                                  child: fezaiCheckBox(
                                    value: historyRates,
                                    clickedColor:
                                        Theme.of(context).disabledColor,
                                    onChanged: (value) {
                                      if (currentRates) {
                                        setState(() {
                                          currentRates = false;
                                          historyRates = value;
                                        });
                                        calculateCurrencyConvert(readCurrency,
                                            _controllerFirst.text);
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Text(
                                    translation(context)
                                        .calculateFromOldExchangeRate,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Nexa3",
                                        fontSize: 14),
                                  ),
                                ),
                                historyRates
                                    ? GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            currency = null;
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).disabledColor,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Text("Yeni Tarih Seç",
                                              style: TextStyle(
                                                  color: Color(0xFF0D1C26))),
                                        ),
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * .04,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  currency != null
                                      ? "${translation(context).exchangeRate} "
                                      : "${translation(context).currentExchangeRate} ",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: "Nexa4",
                                      fontWeight: FontWeight.w900),
                                  maxLines: 3,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      " $first ",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: "Nexa3",
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                    Text(
                                      " $second ",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: "Nexa3",
                                      ),
                                    ),
                                    Text(
                                      ": ${readCurrency.calculateRate(first, second, currency: currency)}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: "Nexa3",
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  translation(context).lastUpdate,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: "Nexa4",
                                      fontWeight: FontWeight.w900),
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  "${intl.DateFormat(ref.read(settingsRiverpod).dateFormat).format(dateTextForFormat)} / ${currency != null ? convertHourAndMinute(currency!.lastApiUpdateDate) : convertHourAndMinute(readCurrency.lastApiUpdateDate)} ",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: "Nexa3"),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  String convertHourAndMinute(String? date) {
    DateTime? dateFormat =
        DateTime.tryParse(date.toString())?.subtract(const Duration(hours: 3));
    return dateFormat != null
        ? "${dateFormat.hour.toString().length == 1 ? "0${dateFormat.hour}" : dateFormat.hour}:${dateFormat.minute.toString().length == 1 ? "0${dateFormat.minute}" : dateFormat.minute}"
        : "0.0";
  }

  String convertDateFormat(String? date) {
    List<String> temp = date!.split(" ")[0].split("-");
    return "${temp[2]}.${temp[1]}.${temp[0]}";
  }

  List<currencyInfo> filterDateCurrency(WidgetRef ref, List<currencyInfo> data,
      {int? day, int? month, int? year}) {
    List<currencyInfo> list = [];
    for (var element in data) {
      List date = element.lastApiUpdateDate!.split(" ")[0].split("-");
      if (day != null || month != null || year != null) {
        if (day == int.parse(date[2]) &&
            month == int.parse(date[1]) &&
            year == int.parse(date[0])) {
          list.add(element);
        } else if (day == int.parse(date[2]) &&
            month == int.parse(date[1]) &&
            year == int.parse(date[0])) {
          list.add(element);
        } else if (day == int.parse(date[2]) &&
            month == null &&
            year == int.parse(date[0])) {
          list.add(element);
        } else if (day == int.parse(date[2]) &&
            month == int.parse(date[1]) &&
            year == null) {
          list.add(element);
        } else if (day == null &&
            month == int.parse(date[1]) &&
            year == int.parse(date[0])) {
          list.add(element);
        } else if (day == null && month == null && year == int.parse(date[0])) {
          list.add(element);
        } else if (day == null && month == int.parse(date[1]) && year == null) {
          list.add(element);
        } else if (day == int.parse(date[2]) && month == null && year == null) {
          list.add(element);
        } else {}
      } else {
        list.add(element);
      }
    }
    parsedDate(ref, list);
    return list;
  }

  void parsedDate(WidgetRef ref, List<currencyInfo> a, {String? click}) {
    if (mode == "day") {
      months.clear();
      years.clear();
      days.remove("-");
    } else if (mode == "month") {
      years.clear();
      days.clear();
      months.remove("-");
    } else if (mode == "year") {
      months.clear();
      days.clear();
      years.remove("-");
    } else {
      years.clear();
      days.clear();
      months.clear();
    }

    for (var element in a) {
      if (!(years
          .contains(element.lastApiUpdateDate!.split(" ")[0].split("-")[0]))) {
        years.add(element.lastApiUpdateDate!.split(" ")[0].split("-")[0]);
      }
      if (!(months
          .contains(element.lastApiUpdateDate!.split(" ")[0].split("-")[1]))) {
        months.add(element.lastApiUpdateDate!.split(" ")[0].split("-")[1]);
      }
      if (!(days
          .contains(element.lastApiUpdateDate!.split(" ")[0].split("-")[2]))) {
        days.add(element.lastApiUpdateDate!.split(" ")[0].split("-")[2]);
      }
    }
    //years.sort((a, b) => int.parse(a).compareTo(int.tryParse(b)!));
    //months.sort((a, b) => int.parse(a).compareTo(int.tryParse(b)!));

    years.sort(
        (a, b) => int.tryParse(a.toString())!.compareTo(int.tryParse(b)!));
    months.sort(
        (a, b) => int.tryParse(a.toString())!.compareTo(int.tryParse(b)!));
    days.sort(
        (a, b) => int.tryParse(a.toString())!.compareTo(int.tryParse(b)!));

    years.insert(0, "-");
    months.insert(0, "-");
    days.insert(0, "-");
  }
}
