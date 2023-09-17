import 'package:butcekontrol/constans/fezai_checkbox.dart';
import 'package:butcekontrol/classes/language.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/models/currency_info.dart';
import 'package:butcekontrol/utils/firestore_helper.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' as intl;
import '../classes/app_bar_for_page.dart';
import '../riverpod_management.dart';

class Calculator extends ConsumerStatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  ConsumerState<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends ConsumerState<Calculator> {
  bool sayi2ishere = false;
  bool firstselect = false;
  bool secondselect = false;
  final PageController _pagecont = PageController(initialPage: 0);
  int _currentPageindex = 0;

  void changePage(int pageindex) {
    _pagecont.animateToPage(pageindex, duration: const Duration(milliseconds: 250), curve: Curves.linear).then((value) {
        setState(() {
          _currentPageindex = pageindex;
          }
        );
      },
    );
  }

  String result = "0";
  String num1 = "";
  String num2 = "";
  String operand = "";

  void onTabbtn(String btnValue) {
    if (btnValue == "C") {
      result = "0";
      num1 = "";
      num2 = "";
      operand = "";
    } else if (btnValue == "?") {
      result = "ibrahim ethem";
    } else if (btnValue == "½") {
      result = (double.parse(result) / 2).toString();
    } else if (btnValue == "<=") {
      if (result.length != 1) {
        result = result.substring(0, result.length - 1);
      } else {
        result = "0";
      }
    } else if (btnValue == "/" ||
        btnValue == "x" ||
        btnValue == "-" ||
        btnValue == "+") {
      num1 = result;
      operand = btnValue;
      result = "0";
    } else if (btnValue == ",") {
      if (result.contains(".")) {
        return;
      } else {
        result = "$result.";
      }
    } else if (btnValue == "=") {
      num2 = result;
      if (operand == "+") {
        result = (double.parse(num1) + double.parse(num2)).toString();
      }
      if (operand == "-") {
        result = (double.parse(num1) - double.parse(num2)).toString();
      }
      if (operand == "/") {
        if (num2 != "0") {
          result = (double.parse(num1) / double.parse(num2)).toString();
        } else {
          result = "TANIMSIZ";
        }
      }
      if (operand == "x") {
        result = (double.parse(num1) * double.parse(num2)).toString();
      }
      num1 = "";
      num2 = "";
      operand = "";
    } else {
      if (result == "0") {
        result = btnValue;
      } else {
        result = result + btnValue;
      }
    }
    setState(() {
      if (result.length > 15) {
        result = "overFlow";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    CustomColors renkler = CustomColors();
    var size = MediaQuery.of(context).size;
    var watchCurrency = ref.watch(currencyRiverpod);
    return Container(
      color: const Color(0xFF03111A),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBarForPage(title: translation(context).calculatorTitle),
          resizeToAvoidBottomInset: false,
          //backgroundColor: const Color(0xffF2F2F2),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  bottom: 7.0,
                  right: 20.0,
                  left: 20.0,
                ),
                child: SizedBox(
                  height: size.height * 0.55,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    child: Container(
                      color: Theme.of(context).highlightColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: PageView(
                          controller: _pagecont,
                          onPageChanged: (value) =>
                              setState(() => _currentPageindex = value),
                          children: [
                            //calculator(), //Page 1
                            ref.read(currencyRiverpod).lastApiUpdateDate != null ? currencyConverter(context)
                                : Center(
                            child: SizedBox(
                              height: size.width * .17,
                              width: size.width * .17,
                              child: CircularProgressIndicator(
                                color: Theme.of(context).disabledColor,
                                backgroundColor: renkler.koyuuRenk,
                              ),
                            )
                        ), //Page 2
                            krediPage(), //Page 4
                            yuzdePage(), // Page 3
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: size.width / 3,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 2.0,
                              color: Theme.of(context).canvasColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      height: 20,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width / 3,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 2.0,
                              color: Theme.of(context).canvasColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    borderRadius:  BorderRadius.circular(20),
                    onTap: () {
                      changePage(0);
                    },
                    child: SizedBox(
                      height: size.width / 4,
                      width: size.width / 4,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Theme.of(context).highlightColor,
                          borderRadius: BorderRadius.circular(20),
                          border: _currentPageindex == 0
                              ? Border.all(
                            color: Theme.of(context).disabledColor,
                            width: 3,
                          )
                              : null,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.currency_exchange_rounded,
                                size: 36,
                                color: renkler.arkaRenk,
                              ),
                              Center(
                                child: Text(
                                  translation(context).currencyConverter,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    height: 1,
                                      fontSize: 15,
                                    overflow: TextOverflow.ellipsis
                                  ),
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    borderRadius:  BorderRadius.circular(20),
                    onTap: () {
                      changePage(1);
                    },
                    child: SizedBox(
                      height: size.width / 4,
                      width: size.width / 4,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Theme.of(context).highlightColor,
                          borderRadius: BorderRadius.circular(20),
                          border: _currentPageindex == 1
                              ? Border.all(
                                  color: Theme.of(context).disabledColor,
                                  width: 3,
                                )
                              : null,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.credit_card_rounded,
                                size: 40,
                                color: renkler.arkaRenk,
                              ),
                              Center(
                                child: Text(
                                  translation(context).calculateInterestCredit,
                                  style: const TextStyle(
                                    height: 1,
                                    color: Colors.white,
                                      fontSize: 15,
                                      overflow: TextOverflow.ellipsis
                                  ),
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    borderRadius:  BorderRadius.circular(20),
                    onTap: () {
                      changePage(2);
                    },
                    child: SizedBox(
                      height: size.width / 4,
                      width: size.width / 4,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Theme.of(context).highlightColor,
                          borderRadius: BorderRadius.circular(20),
                          border: _currentPageindex == 2
                              ? Border.all(
                            color: Theme.of(context).disabledColor,
                            width: 3,
                          )
                              : null,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.percent_rounded,
                                size: 40,
                                color: renkler.arkaRenk,
                              ),
                              Center(
                                child: Text(
                                  translation(context).calculatePercentage,
                                  style: const TextStyle(
                                    height: 1,
                                    color: Colors.white,
                                    fontSize: 15,
                                      overflow: TextOverflow.ellipsis
                                  ),
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget calculator() {
    CustomColors renkler = CustomColors();
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 7.0),
              child: Text(
                result,
                style: TextStyle(
                  color: Theme.of(context).disabledColor,
                  fontSize: 35,
                ),
              ),
            ),
          ],
        ),
        const Divider(color: Colors.white, thickness: 2),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buttonCreate(
                    "C",
                    size,
                  ),
                  buttonCreate("<=", size),
                  buttonCreate("½", size),
                  buttonCreate("/", size)
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buttonCreate("7", size),
                  buttonCreate("8", size),
                  buttonCreate("9", size),
                  buttonCreate("x", size)
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buttonCreate("4", size),
                  buttonCreate("5", size),
                  buttonCreate("6", size),
                  buttonCreate("-", size)
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buttonCreate("1", size),
                  buttonCreate("2", size),
                  buttonCreate("3", size),
                  buttonCreate("+", size)
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buttonCreate("?", size),
                  buttonCreate("0", size),
                  buttonCreate(",", size),
                  equalsBtnCreat(size),
                ],
              ),
            ],
          ),
        ), //Tus takımı bulunacaktır.
      ],
    );
  }

  double toplamAnaPara = 0;
  double faizTutari = 0;
  double toplamOdenecekTutar = 0;
  double aylikTaksit = 0;
  List<String> tutarList = ["0", "0", "0", "0"];

  void faizHesapla(TextEditingController anaPara, TextEditingController faizYuzde, int vadeSuresi) {
    if (faizYuzde.text.isEmpty || anaPara.text.isEmpty) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 40,
              color: const Color(0xFF0D1C26),
              child: Center(
                child: Text(
                  translation(context).pleaseFillInTheRequiredFields,
                  style: TextStyle(
                    fontFamily: 'Nexa3',
                    fontSize: 18,
                    color: Theme.of(context).disabledColor,
                  ),
                ),
              ),
            );
          });
    } else {
      faizTutari = double.parse(anaPara.text) /
          100 *
          double.parse(faizYuzde.text) *
          vadeSuresi /
          12;
      toplamAnaPara = double.parse(anaPara.text);
      toplamOdenecekTutar = faizTutari + toplamAnaPara;
      aylikTaksit = toplamOdenecekTutar / vadeSuresi;

      tutarList[0] = aylikTaksit.toStringAsFixed(2);
      tutarList[1] = toplamAnaPara.toStringAsFixed(2);
      tutarList[2] = faizTutari.toStringAsFixed(2);
      tutarList[3] = toplamOdenecekTutar.toStringAsFixed(2);
      setState(() {});
    }
  }

  void sifirla() {
    tutarList = ["0", "0", "0", "0"];
    setState(() {});
  }

  GlobalKey dropDownKey = GlobalKey();
  TextEditingController anaPara = TextEditingController();
  TextEditingController faizYuzde = TextEditingController();
  @override
  void dispose() {
    anaPara.dispose();
    faizYuzde.dispose();
    dropDownKey;
    super.dispose();
  }

  Widget krediPage() {
    GlobalKey heseplamalarSonucu = GlobalKey();
    var size = MediaQuery.of(context).size;
    var renkler = CustomColors();
    var readSettings = ref.read(settingsRiverpod);
    final List<String> monthList = [
      "3",
      "6",
      "9",
      "12",
      "18",
      "24",
      "30",
      "36",
      "44",
      "48"
    ];
    String selectedValue = monthList[0];

    /// vade kismindaki
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  translation(context).creditCalculation,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Nexa4',
                    height: 1,
                    color: Theme.of(context).disabledColor,
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: Icon(
                    Icons.credit_card_rounded,
                    color: renkler.sariRenk,
                  ),
                ),
              ],
            ),

            /// çıkış butonu
            SizedBox(
              height: size.height / 45,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    translation(context).amount2,
                    //textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'Nexa4',
                      height: 1,
                      color: renkler.yaziRenk,
                    ),
                  ),
                ),
                Container(
                  // ana paranin para kisminin arka pilan rengi
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: renkler.yaziRenk,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 96,
                        height: 30,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4,right: 4,left: 4),
                          child: TextFormField(
                            maxLength: 7,
                            controller: anaPara,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            style: TextStyle(
                              color: renkler.koyuuRenk,
                              fontFamily: 'Nexa4',
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                              counterText: '',

                              /// kalan karakteri gösteren yazıyı kaldırıyor.
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 5),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(style: BorderStyle.none),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(style: BorderStyle.none),
                              ),
                              hintText: "0.0",
                              isDense: true,
                              hintStyle: TextStyle(
                                color: renkler.koyuuRenk,
                                fontSize: 17,
                                fontFamily: 'Nexa4',
                              ),
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            /// ana para
            SizedBox(
              height: size.height / 45,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    translation(context).interestPercent,
                    //textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'Nexa4',
                      height: 1,
                      color: renkler.yaziRenk,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: renkler.yaziRenk,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 60,
                        height: 30,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: TextFormField(
                            maxLength: 5,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^\d{0,2}(\.\d{0,2})?'),
                              ),
                            ],
                            controller: faizYuzde,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              color: renkler.koyuuRenk,
                              fontSize: 16,
                              fontFamily: 'Nexa4',
                            ),
                            decoration: InputDecoration(
                              counterText: '',
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 5),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  style: BorderStyle.none,
                                ),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  style: BorderStyle.none,
                                ),
                              ),
                              hintText: "0.0",
                              isDense: true,
                              hintStyle: TextStyle(
                                color: renkler.koyuuRenk,
                                fontSize: 16,
                                fontFamily: 'Nexa4',
                                height: 1
                              ),
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Text(
                          " % ",
                          style: TextStyle(
                              fontFamily: 'Nexa4',
                              fontSize: 16,
                              height: 1,
                              color: renkler.koyuuRenk),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            /// faiz yuzde
            SizedBox(
              height: size.height / 45,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    translation(context).maturity,
                    //textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'Nexa4',
                      height: 1,
                      color: renkler.yaziRenk,
                    ),
                  ),
                ),
                Container(
                  width: 45,
                  height: 30,
                  decoration: BoxDecoration(
                      color: renkler.yaziRenk,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: DropdownButtonFormField<String>(
                      key: dropDownKey,
                      /// bunun kullanim nedeni sıfırla yapınca varsayılan vade gelmesi için
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 15),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            style: BorderStyle.none,
                          )),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            style: BorderStyle.none,
                          ))),
                      iconEnabledColor: renkler.koyuuRenk,
                      dropdownColor: renkler.arkaRenk,
                      value: selectedValue,
                      alignment: Alignment.center,
                      menuMaxHeight: 200,
                      iconSize: 0,
                      style: TextStyle(
                        color: renkler.koyuuRenk,
                        fontFamily: 'Nexa4',
                        fontSize: 16,
                      ),
                      onChanged: (value) {
                        selectedValue = value!;
                      },
                      items: monthList.map((value) {
                        return DropdownMenuItem(
                          alignment: Alignment.center,
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height / 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      anaPara.clear();
                      faizYuzde.clear();
                      selectedValue = monthList[0];
                      dropDownKey = GlobalKey();
                      sifirla();
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: size.height / 25,
                    //width: size.width / 4.5,
                    decoration: BoxDecoration(
                        color: renkler.arkaRenk,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        translation(context).deleteAll2,
                        style: TextStyle(
                          color: renkler.koyuuRenk,
                          fontSize: 17,
                          height: 1,
                          fontFamily: "Nexa4",
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    faizHesapla(anaPara, faizYuzde,
                        int.parse(selectedValue.toString()));
                    heseplamalarSonucu = GlobalKey();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: size.height / 25,
                    width: size.width / 3,
                    decoration: BoxDecoration(
                        color: Theme.of(context).disabledColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Text(
                      translation(context).calculate,
                      style: TextStyle(
                        color: renkler.koyuuRenk,
                        fontSize: 17,
                        height: 1,
                        fontFamily: "Nexa4",
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: size.height / 100,
            ),
            SizedBox(
              height: size.height / 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text: translation(context).monthlyEqualInstalments,
                          style: TextStyle(
                            color: renkler.yaziRenk,
                            fontFamily: 'Nexa4',
                            fontSize: 16,
                            height: 1
                          ),
                        ),
                        TextSpan(
                            text: tutarList[0],
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Nexa4',
                              color: renkler.yaziRenk,
                                height: 1
                            )),
                            TextSpan(
                              text: readSettings.prefixSymbol,
                              style: TextStyle(
                                fontFamily: 'TL',
                                fontSize: 16,
                                height: 1,
                                color: renkler.yaziRenk,
                              ),
                            ),

                      ]))
                    ],
                  ), // aylık eşit taksit
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text: translation(context).totalAmount,
                          style: TextStyle(
                            color: renkler.yaziRenk,
                            fontFamily: 'Nexa4',
                            fontSize: 16,
                              height: 1
                          ),
                        ),
                        TextSpan(
                            text: tutarList[1],
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Nexa4',
                              color: renkler.yaziRenk,
                                height: 1
                            )),
                            TextSpan(
                              text: readSettings.prefixSymbol,
                              style: TextStyle(
                                fontFamily: 'TL',
                                fontSize: 16,
                                height: 1,
                                color: renkler.yaziRenk,
                              ),
                            ),

                      ]))
                    ],
                  ), // toplam ana para
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text: translation(context).totalInterest,
                          style: TextStyle(
                            color: renkler.yaziRenk,
                            fontFamily: 'Nexa4',
                            fontSize: 16,
                              height: 1
                          ),
                        ),
                        TextSpan(
                            text: tutarList[2],
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Nexa4',
                              color: renkler.yaziRenk,
                                height: 1
                            )),
                            TextSpan(
                              text: readSettings.prefixSymbol,
                              style: TextStyle(
                                fontFamily: 'TL',
                                fontSize: 16,
                                height: 1,
                                color: renkler.yaziRenk,
                              ),
                            ),
                      ]))
                    ],
                  ), // toplam faiz
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text: translation(context).totalPayment,
                          style: TextStyle(
                            color: Theme.of(context).disabledColor,
                            fontFamily: 'Nexa4',
                            fontSize: 17,
                              height: 1
                          ),
                        ),
                        TextSpan(
                            text: tutarList[3],
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Nexa4',
                              color: Theme.of(context).disabledColor,
                                height: 1
                            )),
                        TextSpan(
                          text: readSettings.prefixSymbol,
                          style: TextStyle(
                            fontFamily: 'TL',
                            fontSize: 17,
                            height: 1,
                            color: Theme.of(context).disabledColor,
                          ),
                        ),
                      ]))
                    ],
                  ), // toplam ödeme
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextEditingController nums = TextEditingController();
  TextEditingController sonuc = TextEditingController();
  void dispose2() {
    nums.dispose();
    sonuc.dispose();
    dropDownKey;
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

  TextEditingController sayi2Controller = TextEditingController();
  TextEditingController sayi1Controller = TextEditingController();
  TextEditingController yuzdeOranController = TextEditingController();
  TextEditingController sonucController = TextEditingController();
  Widget yuzdePage() {
    double sonuc = 0;
    var size = MediaQuery.of(context).size;
    CustomColors renkler = CustomColors();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  translation(context).percentageCalculation,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Nexa4',
                    color: Theme.of(context).disabledColor,
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: Icon(
                    Icons.percent_rounded,
                    color: renkler.sariRenk,
                  ),
                ),
              ],
            ),
            /// çıkış butonu
            SizedBox(
              height: size.height / 50,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    sayi2ishere
                    ? Text(
                        translation(context).firstNumber,
                        style: TextStyle(
                          fontFamily: "Nexa4",
                          fontSize: 17,
                          height: 1,
                          color: renkler.arkaRenk,
                        ),
                      )
                    : Text(
                      translation(context).number,
                      style: TextStyle(
                        fontFamily: "Nexa4",
                        fontSize: 17,
                        height: 1,
                        color: renkler.arkaRenk,
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 130,
                      decoration: BoxDecoration(
                        color: renkler.yaziRenk,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          maxLength: 12,
                          style: TextStyle(
                              color: renkler.koyuuRenk,
                              fontSize: 16,
                              fontFamily: 'Nexa4',
                            height: 1
                            ),
                          onChanged: (value) {
                            if (firstselect == true) {
                              if (sayi2Controller.text != "" && sayi1Controller.text != "") {
                                sonuc = ((double.parse(sayi2Controller.text) / double.parse(sayi1Controller.text)) * 100);
                                yuzdeOranController.text = sonuc.toStringAsFixed(3);
                              }
                            } else if (secondselect == true) {
                              if (sayi1Controller.text != "" && sayi2Controller.text != "") {
                                sonuc = ((double.parse(sayi2Controller.text) - double.parse(sayi1Controller.text)) * 100) / double.parse(sayi1Controller.text);
                                yuzdeOranController.text = sonuc.toStringAsFixed(3);
                              }
                            } else if (yuzdeOranController.text != "") {
                              sonuc = double.parse(sayi1Controller.text) * (double.parse(yuzdeOranController.text) / 100);
                              sonucController.text = sonuc.toStringAsFixed(3);
                            }
                          },
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'^\d{0,8}(\.\d{0,2})?'),)
                          ],
                          controller: sayi1Controller,
                          decoration: InputDecoration(
                            hintText: translation(context).enteraNumber,
                          hintStyle: const TextStyle(
                            height: 1,
                            fontSize: 14,
                            fontFamily: 'Nexa3',
                            color: Colors.black,
                          ),
                          counterText: '',
                          isDense: true,
                          enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            style: BorderStyle.none,
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                      ),
                    ),
                ),
              ],
            ),
            sayi2ishere
              ? Column(
                children: [
                  SizedBox(
                    height: size.height / 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        translation(context).secondNumber,
                        style: TextStyle(
                          fontFamily: "Nexa4",
                          fontSize: 16,
                          height: 1,
                          color: renkler.arkaRenk,
                        ),
                      ),
                      Container(
                          height: 30,
                          width: 130,
                        decoration: BoxDecoration(
                          color: renkler.yaziRenk,
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5,right: 5),
                          child: TextField(
                            maxLength: 12,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: renkler.koyuuRenk,
                                fontSize: 16,
                                fontFamily: 'Nexa4'),
                            onChanged: (value) {
                              if (firstselect == true) {
                                if (sayi2Controller.text != "" && sayi1Controller.text != "") {
                                  sonuc = ((double.parse(sayi2Controller.text) / double.parse(sayi1Controller.text)) * 100);
                                  yuzdeOranController.text = sonuc.toStringAsFixed(2);
                                }
                              } else if (secondselect == true) {
                                if (sayi1Controller.text != "" && sayi2Controller.text != "") {
                                  sonuc = ((double.parse(sayi2Controller.text) - double.parse(sayi1Controller.text)) * 100) / double.parse(sayi1Controller.text);
                                  yuzdeOranController.text = sonuc.toStringAsFixed(2);
                                }
                              }
                            },
                            controller: sayi2Controller,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'^\d{0,8}(\.\d{0,2})?'),)
                            ],
                            decoration: InputDecoration(
                              counterText: '',
                              hintText: translation(context).enteraNumber,
                              hintStyle: const TextStyle(
                                height: 1,
                                  fontSize: 14,
                                  fontFamily: 'Nexa3',
                                color : Colors.black
                              ),
                              isDense: true,
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  style: BorderStyle.none,
                                ),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  style: BorderStyle.none,
                                ),
                              ),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              )
                            ),
                          ),
                        )
                      )
                            ],
                  ),
                ],
              )
              : const SizedBox(height: 1),
                SizedBox(
                  height: size.height / 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    sayi2ishere
                    ? Text(
                      translation(context).result2,
                      style: const TextStyle(
                        fontFamily: "Nexa4",
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    )
                    : Text(
                      translation(context).percentageRate,
                      style: const TextStyle(
                        fontFamily: "Nexa4",
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 130,
                      decoration: BoxDecoration(
                        color: renkler.yaziRenk,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding:  const EdgeInsets.only(left: 5,right: 5),
                        child: TextField(
                          textAlign: TextAlign.center,
                          maxLength: sayi2ishere ? null : 10,
                          readOnly: sayi2ishere ? true : false,
                          style: TextStyle(
                              color: renkler.koyuuRenk,
                              fontFamily: 'Nexa4',
                              fontSize: 16
                          ),
                          onChanged: (value) {
                            if (sayi1Controller.text.isNotEmpty &&
                                yuzdeOranController.text.isNotEmpty) {
                              // Virgülü noktaya dönüştür
                              final sayi1 =
                                  sayi1Controller.text.replaceAll(',', '.');
                              final yuzdeOran = yuzdeOranController.text
                                  .replaceAll(',', '.');

                              sonuc = double.parse(sayi1) * (double.parse(yuzdeOran) / 100);
                              sonucController.text = sonuc.toStringAsFixed(2);
                            }
                          },
                          controller: yuzdeOranController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'^\d{0,8}(\.\d{0,2})?'),)
                          ],
                          decoration: InputDecoration(
                              isDense: true,
                              counterText: '',
                              hintText: sayi2ishere
                                  ? null
                                  : translation(context).enteraPercentage,
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  height: 1,
                                  fontFamily: 'Nexa3',
                                  color: renkler.koyuAraRenk),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  style: BorderStyle.none,
                                ),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  style: BorderStyle.none,
                                ),
                              ),
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              disabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  style: BorderStyle.none,
                                ),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                height: 3,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  color: Theme.of(context).disabledColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 5),
              child: !sayi2ishere
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          translation(context).result,
                          style: TextStyle(
                              fontFamily: "Nexa4",
                              fontSize: 17,
                              color: renkler.yaziRenk),
                        ),
                        Container(
                          height: 30,
                          width: 130,
                          decoration: BoxDecoration(
                              color: renkler.yaziRenk,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 5, bottom: 2, right: 5),
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              readOnly: true,
                              style: TextStyle(
                                  color: renkler.koyuuRenk,
                                  fontFamily: 'Nexa4',
                                  fontSize: 16),
                              controller: sonucController,
                              decoration: const InputDecoration(
                                  isDense: true,
                                  counterText: '',
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(height: 1),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: size.height * .14,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      fezaiCheckBox(
                        value: sayi2ishere,
                        clickedColor: Theme.of(context).disabledColor,
                        size: 15,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              sayi2ishere = value;
                              firstselect = true;
                              secondselect = false;
                            });
                          }
                        },
                      ),
                      const SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          translation(context).processTheSecondNumber,
                          style: TextStyle(
                            color: renkler.arkaRenk,
                            fontFamily: "Nexa4",
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  sayi2ishere
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            fezaiCheckBox(
                              value: firstselect,
                              clickedColor: Theme.of(context).disabledColor,
                              size: 15,
                              onChanged: (value) {
                                if (secondselect) {
                                  setState(() {
                                    firstselect = value;
                                    secondselect = false;
                                  });
                                }
                              },
                            ),
                            const SizedBox(width: 10),
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                translation(context)
                                    .secondNumberPercentageOfFirstNumber,
                                style: TextStyle(
                                  color: renkler.arkaRenk,
                                  fontFamily: "Nexa4",
                                  fontSize: 16,
                                ),
                              ),
                            )
                          ],
                        )
                      : const SizedBox(
                          width: 1,
                        ),
                  sayi2ishere
                      ? const SizedBox(
                          height: 5,
                        )
                      : const SizedBox(
                          width: 5,
                        ),
                  sayi2ishere
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            fezaiCheckBox(
                              value: secondselect,
                              clickedColor: Theme.of(context).disabledColor,
                              size: 15,
                              onChanged: (value) {
                                if (value != null) {
                                  if (firstselect) {
                                    setState(() {
                                      firstselect = false;
                                      secondselect = value;
                                    });
                                  }
                                }
                              },
                            ),
                            const SizedBox(width: 10),
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                translation(context).rateOfChange,
                                style: TextStyle(
                                  color: renkler.arkaRenk,
                                  fontFamily: "Nexa4",
                                  fontSize: 16,
                                ),
                              ),
                            )
                          ],
                        )
                      : const SizedBox(width: 1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String first = "TRY";
  String second = "USD";
  String ?date;
  currencyInfo ?currency ;
  bool currentRates = true;
  bool historyRates = false;
  final TextEditingController _controllerFirst = TextEditingController();
  final TextEditingController _controllerSecond = TextEditingController();

  void calculateCurrencyConvert(var readCurrency, String value){
    if(_controllerFirst.text != ""){
      var result = readCurrency.calculateRealAmount(double.tryParse(_controllerFirst.text)!, first, second, currency: currency);
      _controllerSecond.text = result.toString();
    }else{
      _controllerSecond.text = "";
    }
  }
  Widget currencyConverter(BuildContext context) {
    var renkler = CustomColors();
    var size = MediaQuery.of(context).size;
    DateTime now = DateTime.now();
    String formattedDate = intl.DateFormat(ref.read(settingsRiverpod).dateFormat).format(now);
    var readCurrency = ref.read(currencyRiverpod);
    Future<List<currencyInfo>> historyCurrency = firestoreHelper.getHistoryCurrency();

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

    var dateText = currency?.lastApiUpdateDate?.split(" ")[0].replaceAll("-", ".") ?? readCurrency.lastApiUpdateDate!.split(" ")[0].replaceAll("-", ".");
    print(dateText);
    DateTime dateTextForFormat =  DateTime(int.parse(dateText.split(".")[0]),int.parse(dateText.split(".")[1]),int.parse(dateText.split(".")[2]));
    print(dateTextForFormat);
    var readSettings = ref.watch(settingsRiverpod);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top:  15, bottom: 20, left : 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
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
                  height: 40,
                  child: Icon(
                    Icons.currency_exchange_rounded,
                    color: renkler.sariRenk,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height / 50,
            ),
            SizedBox(
              height: size.height * .16,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    flex : 3,
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
                                    padding: const EdgeInsets.only(top: 2),
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
                                calculateCurrencyConvert(readCurrency, _controllerFirst.text);
                              },
                              //barrierColor: renkler.koyuAraRenk.withOpacity(0.8),
                              buttonStyleData: ButtonStyleData(
                                overlayColor: MaterialStatePropertyAll(renkler
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
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(5))),
                              ),
                              menuItemStyleData: MenuItemStyleData(
                                overlayColor: MaterialStatePropertyAll(
                                    renkler.koyuAraRenk), // MENÜ BASILMA RENGİ
                                height: 34,
                              ),
                              iconStyleData: IconStyleData(
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                ),
                                iconSize: 24,
                                iconEnabledColor:
                                renkler.koyuAraRenk,
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
                              width: 1 ,
                            )
                          ),
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: Row(
                              children: [
                                SizedBox(
                                  width : 36,
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
                                            fontFamily:
                                            "TL",
                                            fontSize: 24,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 2),
                                SizedBox(
                                  width: size.width*0.33-39,
                                  child: TextField(
                                    onChanged: (value) async {
                                      calculateCurrencyConvert(readCurrency, value);
                                    },
                                    textAlign: TextAlign.center,
                                    controller: _controllerFirst,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Theme.of(context).scaffoldBackgroundColor,
                                      fontSize: 15,
                                      height: 1,
                                    ),
                                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp(r'^\d{0,8}(\.\d{0,2})?'),)
                                    ],
                                    decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: const EdgeInsets.only(top: 3,left: 2,right: 2),
                                        hintText: translation(context).amount,
                                        hintStyle: TextStyle(
                                            color: Theme.of(context).scaffoldBackgroundColor,
                                            fontSize: 15,
                                        ),
                                        border: InputBorder.none
                                    ),
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
                                    fontFamily:
                                    "Nexa3",
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
                            readSettings.localChanger() != const Locale("ar") ? Icons.double_arrow_rounded : Icons.keyboard_double_arrow_left_rounded,
                            color: renkler.arkaRenk,
                            size: 28,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                var a = first;
                                first = second;
                                second = a ;
                              });
                              calculateCurrencyConvert(readCurrency, _controllerFirst.text);
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
                                  translation(context).select,
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
                                    padding: const EdgeInsets.only(top: 2),
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
                                calculateCurrencyConvert(readCurrency, _controllerFirst.text);
                              },
                              //barrierColor: renkler.koyuAraRenk.withOpacity(0.8),
                              buttonStyleData: ButtonStyleData(
                                overlayColor: MaterialStatePropertyAll(renkler
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
                                      borderRadius:
                                      const BorderRadius.all(Radius.circular(5))),
                                  ),
                              menuItemStyleData: MenuItemStyleData(
                                overlayColor: MaterialStatePropertyAll(
                                    renkler.koyuAraRenk), // MENÜ BASILMA RENGİ
                                height: 34,
                              ),
                              iconStyleData: IconStyleData(
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                ),
                                iconSize: 24,
                                iconEnabledColor:
                                renkler.koyuAraRenk,
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
                                width: 1 ,
                              )
                          ),
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: Row(
                              children: [
                                SizedBox(
                                  width : size.width*0.33-39,
                                  child: TextField(
                                    readOnly: true,
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    controller: _controllerSecond,
                                    style: TextStyle(
                                      color: Theme.of(context).scaffoldBackgroundColor,
                                      fontSize: 15,
                                      height: 1
                                    ),
                                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp(r'^\d{0,8}(\.\d{0,2})?'),)
                                    ],
                                    decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(top: 3,left: 2,right: 2),
                                      isDense: true,
                                        hintText: translation(context).result,
                                        hintStyle: TextStyle(
                                          color: Theme.of(context).scaffoldBackgroundColor,
                                          fontSize: 15,
                                          height: 1
                                        ),
                                        border: InputBorder.none
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 2),
                                SizedBox(
                                  width : 36,
                                  //height: 30,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: FittedBox(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 3,right: 2),
                                        child: Text(
                                          readSettings.convertPrefix(second),
                                          style: TextStyle(
                                            height: 1,
                                            color: Theme.of(context).cardColor,
                                            fontFamily:
                                            "TL",
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
                              Clipboard.setData(ClipboardData(
                                  text: _controllerSecond.text
                              ));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: const Color(0xff0D1C26),
                                  duration: const Duration(seconds: 1),
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
                                      fontFamily:
                                      "Nexa3",
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
            SizedBox(
              height: size.height / 50,
            ),
            SizedBox(
              height: size.height * .12,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: fezaiCheckBox(
                            value: currentRates ,
                            clickedColor: Theme.of(context).disabledColor,
                            onChanged: (value) {
                              if(historyRates){
                                setState(() {
                                  date = null;
                                  currency = null;
                                  currentRates = value;
                                  historyRates = false ;
                                });
                                calculateCurrencyConvert(readCurrency, _controllerFirst.text);
                              }
                            },
                          ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          translation(context).calculateFromCurrentExchangeRate,
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "Nexa3",
                              fontSize: 14
                          ),
                        ),
                      ),
                      Text(
                        formattedDate,
                        style: TextStyle(
                            color: Theme.of(context).disabledColor,
                            fontFamily: "Nexa4",
                            fontSize: 13
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: fezaiCheckBox(
                          value: historyRates ,
                          clickedColor: Theme.of(context).disabledColor,
                          onChanged: (value) {
                            if(currentRates){
                              setState(() {
                                currentRates = false;
                                historyRates = value;
                              });
                              calculateCurrencyConvert(readCurrency, _controllerFirst.text);
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          translation(context).calculateFromOldExchangeRate,
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "Nexa3",
                              fontSize: 14
                          ),
                        ),
                      ),
                      !historyRates
                      ?Text(
                        "...",
                        style: TextStyle(
                            color: Theme.of(context).disabledColor,
                            fontFamily: "Nexa4",
                            fontSize: 13
                        ),
                      )
                      :FutureBuilder(
                        future: historyCurrency,
                        builder: (context, snapshot) {
                          if(snapshot.hasData){
                            List<String> Lista = [];
                            for (var element in snapshot.data!) {
                              var date = element.lastApiUpdateDate!.split(" ")[0].replaceAll("-", ".");
                              DateTime dateForFormat = DateTime(int.parse(date.split(".")[0]),int.parse(date.split(".")[1]),int.parse(date.split(".")[2]));
                              Lista.add(intl.DateFormat(ref.read(settingsRiverpod).dateFormat).format(dateForFormat));
                            }
                            return Container(
                              height: 28,
                              //width: 106,
                              decoration: BoxDecoration(
                                color: Theme.of(context).disabledColor,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child : DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  hint: Center(
                                    child: Text(
                                      translation(context).select,
                                      style: TextStyle(
                                        fontSize: 12,
                                        height: 1,
                                        fontFamily: 'Nexa3',
                                        color: renkler.koyuuRenk,
                                      ),
                                    ),
                                  ),
                                  items: Lista
                                      .map((item) => DropdownMenuItem(
                                    value: item,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 2),
                                        child: Text(
                                          item,
                                          style: TextStyle(
                                              fontSize: 12,
                                              height: 1,
                                              fontFamily: 'Nexa3',
                                              color: renkler.koyuuRenk),
                                        ),
                                      ),
                                    ),
                                  ))
                                      .toList(),
                                  value: date,
                                  onChanged: (newValue) {
                                    setState(() {
                                      date = newValue!;
                                      currency = snapshot.data![Lista.indexOf(newValue)];
                                    });
                                    calculateCurrencyConvert(readCurrency, _controllerFirst.text);
                                  },
                                  //barrierColor: renkler.koyuAraRenk.withOpacity(0.8),
                                  buttonStyleData: ButtonStyleData(
                                    overlayColor: MaterialStatePropertyAll(renkler
                                        .koyuAraRenk), // BAŞLANGIÇ BASILMA RENGİ
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                    height: 28,
                                    width: 110,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    maxHeight: 200,
                                    width: 110,
                                    decoration: BoxDecoration(
                                        color: renkler.sariRenk,
                                        borderRadius:
                                        const BorderRadius.all(Radius.circular(5))),
                                  ),
                                  menuItemStyleData: MenuItemStyleData(
                                    overlayColor: MaterialStatePropertyAll(
                                        renkler.koyuAraRenk), // MENÜ BASILMA RENGİ
                                    height: 32,
                                  ),
                                  iconStyleData: IconStyleData(
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                    ),
                                    iconSize: 24,
                                    iconEnabledColor:
                                    renkler.koyuAraRenk,
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
                            );
                          }else{
                            return Text(
                              translation(context).loading,
                              style: TextStyle(
                                  color: Theme.of(context).disabledColor,
                                  fontFamily: "Nexa2",
                                  fontSize: 13
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height / 140,
            ),
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          currency != null ? "${translation(context).exchangeRate} ": "${translation(context).currentExchangeRate} ",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: "Nexa4",
                            fontWeight: FontWeight.w900
                          ),
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
                  SizedBox(height: 6,),
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
                              fontWeight: FontWeight.w900
                          ),
                          maxLines: 2,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          "${intl.DateFormat(ref.read(settingsRiverpod).dateFormat).format(dateTextForFormat)} / ${currency != null  ? convertHourAndMinute(currency!.lastApiUpdateDate) : convertHourAndMinute(readCurrency.lastApiUpdateDate)} ",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: "Nexa3"
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * .015,
            )
          ],
        ),
      ),
    );
  } ///page1

  String convertHourAndMinute(String? date){
    DateTime? dateFormat = DateTime.tryParse(date.toString())?.subtract(const Duration(hours: 3));
    return "${dateFormat?.hour}:${dateFormat?.minute}";
  }

  Widget equalsBtnCreat(Size size) {
    return SizedBox(
      height: size.width * 00.135,
      width: size.width * 00.135,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        child: TextButton(
          onPressed: () => onTabbtn("="),
          child: const Center(
            child: Text(
              "=",
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buttonCreate(String symbol, Size size) {
    return SizedBox(
      height: size.width * 00.135,
      width: size.width * 00.135,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(13)),
        ),
        child: TextButton(
          onPressed: () => onTabbtn(symbol),
          child: Center(
            child: Text(
              symbol,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
