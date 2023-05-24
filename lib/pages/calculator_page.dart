import 'package:butcekontrol/constans/material_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../classes/app_bar_for_page.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  bool sayi2ishere = false;
  bool firstselect = false;
  bool secondselect = false;
  final PageController _pagecont = PageController(initialPage: 0);
  int _currentPageindex = 0;
  void changePage(int pageindex) {
    setState(() {
      _currentPageindex = pageindex;
    });
    _pagecont.jumpToPage(pageindex);
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
    return Container(
      color: const Color(0xFF03111A),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xffF2F2F2),
          appBar: const AppBarForPage(title: 'HESAP MAKİNESİ'),
          body: SingleChildScrollView(
            child: Column(
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
                    height: size.height * 0.56,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                        bottomLeft: Radius.circular(40),
                      ),
                      child: Container(
                        color: renkler.koyuuRenk,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: PageView(
                            controller: _pagecont,
                            onPageChanged: (value) =>
                                setState(() => _currentPageindex = value),
                            children: [
                              //calculator(),
                              yuzdePage(), // Page 2
                              krediPage(), //Page 3
                              //currencyConverter(), //Page 4
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.005,
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
                                color: renkler.koyuuRenk,
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
                            color: renkler.koyuuRenk,
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
                                color: renkler.koyuuRenk,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.005),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        changePage(0);
                      },
                      child: SizedBox(
                        height: size.width / 4,
                        width: size.width / 4,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: renkler.koyuuRenk,
                            borderRadius: BorderRadius.circular(20),
                            border: _currentPageindex == 0
                                ? Border.all(
                                    color: renkler.sariRenk,
                                    width: 3,
                                  )
                                : null,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.percent,
                                size: 45,
                                color: renkler.arkaRenk,
                              ),
                              const Center(
                                child: Text(
                                  " Yüzde\nHesapla",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        changePage(1);
                      },
                      child: SizedBox(
                        height: size.width / 4,
                        width: size.width / 4,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: renkler.koyuuRenk,
                            borderRadius: BorderRadius.circular(20),
                            border: _currentPageindex == 1
                                ? Border.all(
                                    color: renkler.sariRenk,
                                    width: 3,
                                  )
                                : null,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.credit_card,
                                size: 45,
                                color: renkler.arkaRenk,
                              ),
                              const Center(
                                child: Text(
                                  "Faiz-Kredi\n Hesapla",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Color(0xff0D1C26),
                            duration: Duration(seconds: 1),
                            content: Text(
                              'Döviz çevirici henüz aktif değildir.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Nexa3',
                                fontWeight: FontWeight.w600,
                                height: 1.3,
                              ),
                            ),
                          ),
                        );
                      },
                      child: SizedBox(
                        height: size.width / 4,
                        width: size.width / 4,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(20),
                            border: _currentPageindex == 3
                                ? Border.all(
                                    color: renkler.sariRenk,
                                    width: 3,
                                  )
                                : null,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.currency_exchange,
                                size: 40,
                                color: renkler.arkaRenk,
                              ),
                              const Center(
                                child: Text(
                                  " Döviz\nÇevirici",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                /// Sayfa butonları gelecek.
              ],
            ),
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
                  color: renkler.sariRenk,
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

  void faizHesapla(TextEditingController anaPara,
      TextEditingController faizYuzde, int vadeSuresi) {
    if (faizYuzde.text.isEmpty || anaPara.text.isEmpty) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 40,
              color: const Color(0xFF0D1C26),
              child: const Center(
                child: Text(
                  'Lütfen gerekli alanları doldurun',
                  style: TextStyle(
                    fontFamily: 'Nexa3',
                    fontSize: 18,
                    color: Color(0xFFF2CB05),
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
    String? selectedValue = monthList[0];

    /// vade kismindaki
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "Kredi Hesaplama",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Nexa4',
                  color: renkler.sariRenk,
                ),
              ),
              const SizedBox(
                height: 40,
                width: 40,
              ),/*
              SizedBox(
                height: 40,
                width: 40,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: renkler.yaziRenk,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    icon: Image.asset(
                      "assets/icons/remove.png",
                      height: 20,
                      width: 20,
                    ),
                    onPressed: () {
                      changePage(0);
                    },
                  ),
                ),
              ),*/
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
                  "Ana Para",
                  //textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'Nexa4',
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
                      width: 90,
                      height: 30,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4),
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
                    Text(
                      ' ₺ ',
                      style: TextStyle(
                        fontFamily: 'TL',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: renkler.koyuuRenk,
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
                  "Faiz (Yüzde)",
                  //textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'Nexa4',
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
                  "Vade (Ay)",
                  //textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'Nexa4',
                    color: renkler.yaziRenk,
                  ),
                ),
              ),
              Container(
                width: 45,
                height: 30,
                decoration: BoxDecoration(
                    color: renkler.yaziRenk,
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
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
                    value: selectedValue,
                    menuMaxHeight: 300,
                    iconSize: 0,
                    style: TextStyle(
                      color: renkler.koyuuRenk,
                      fontFamily: 'Nexa4',
                      fontSize: 16,
                    ),
                    onChanged: (value) {
                      selectedValue = value;
                    },
                    items: monthList.map((value) {
                      return DropdownMenuItem(
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
            height: size.height / 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                  width: size.width / 4,
                  decoration: BoxDecoration(
                      color: renkler.sariRenk,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(25))),
                  child: Text(
                    "Sıfırla",
                    style: TextStyle(
                      color: renkler.koyuuRenk,
                      fontSize: 18,
                      fontFamily: "Nexa4",
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  faizHesapla(
                      anaPara, faizYuzde, int.parse(selectedValue.toString()));
                  heseplamalarSonucu = GlobalKey();
                },
                child: Container(
                  alignment: Alignment.center,
                  height: size.height / 25,
                  width: size.width / 4,
                  decoration: BoxDecoration(
                      color: renkler.sariRenk,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(25))),
                  child: Text(
                    "Hesapla",
                    style: TextStyle(
                      color: renkler.koyuuRenk,
                      fontSize: 18,
                      fontFamily: "Nexa4",
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: size.height / 80,
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
                        text: 'Aylık Eşit Taksi:  ',
                        style: TextStyle(
                          color: renkler.yaziRenk,
                          fontFamily: 'Nexa4',
                          fontSize: 17,
                        ),
                      ),
                      TextSpan(
                          text: tutarList[0],
                          style: TextStyle(
                            fontSize: 17,
                            fontFamily: 'Nexa4',
                            color: renkler.yaziRenk,
                          )),
                      TextSpan(
                        text: ' ₺',
                        style: TextStyle(
                          fontFamily: 'TL',
                          fontSize: 17,
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
                        text: 'Toplam Ana Para:  ',
                        style: TextStyle(
                          color: renkler.yaziRenk,
                          fontFamily: 'Nexa4',
                          fontSize: 17,
                        ),
                      ),
                      TextSpan(
                          text: tutarList[1],
                          style: TextStyle(
                            fontSize: 17,
                            fontFamily: 'Nexa4',
                            color: renkler.yaziRenk,
                          )),
                      TextSpan(
                        text: ' ₺',
                        style: TextStyle(
                          fontFamily: 'TL',
                          fontSize: 17,
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
                        text: 'Toplam Faiz:  ',
                        style: TextStyle(
                          color: renkler.yaziRenk,
                          fontFamily: 'Nexa4',
                          fontSize: 17,
                        ),
                      ),
                      TextSpan(
                          text: tutarList[2],
                          style: TextStyle(
                            fontSize: 17,
                            fontFamily: 'Nexa4',
                            color: renkler.yaziRenk,
                          )),
                      TextSpan(
                        text: ' ₺',
                        style: TextStyle(
                          fontFamily: 'TL',
                          fontSize: 17,
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
                        text: 'Toplam Ödeme: ',
                        style: TextStyle(
                          color: renkler.sariRenk,
                          fontFamily: 'Nexa4',
                          fontSize: 18,
                        ),
                      ),
                      TextSpan(
                          text: tutarList[3],
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Nexa4',
                            color: renkler.sariRenk,
                          )),
                      TextSpan(
                        text: ' ₺',
                        style: TextStyle(
                          fontFamily: 'TL',
                          fontSize: 18,
                          color: renkler.sariRenk,
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
  double kur = 16.5;
  double amount = 0.0;
  double kurdolar = 19.36;
  double kureuro = 21.49;
  void switchCurrency() {
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

  Widget yuzdePage() {
    TextEditingController sayi2Controller = TextEditingController();
    TextEditingController sayi1Controller = TextEditingController();
    TextEditingController yuzdeOranController = TextEditingController();
    TextEditingController sonucController = TextEditingController();
    double sonuc = 0;
    var size = MediaQuery.of(context).size;
    CustomColors renkler = CustomColors();
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "Yüzde Hesaplama",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Nexa4',
                  color: renkler.sariRenk,
                ),
              ),
              const SizedBox(
                height: 40,
                width: 40,
              ),
              /*
              SizedBox(
                height: 40,
                width: 40,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: renkler.yaziRenk,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    icon: Image.asset(
                      "assets/icons/remove.png",
                      height: 20,
                      width: 20,
                    ),
                    onPressed: () {
                      changePage(0);
                    },
                  ),
                ),
              ),*/
            ],
          ),

          /// çıkış butonu
          SizedBox(
            height: size.height / 50,
          ),
          Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 180,
                    child: sayi2ishere
                        ? const Text(
                            "1. Sayı",
                            style: TextStyle(
                              fontFamily: "Nexa4",
                              fontSize: 17,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            "Sayı",
                            style: TextStyle(
                              fontFamily: "Nexa4",
                              fontSize: 17,
                              color: Colors.white,
                            ),
                          ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: renkler.yaziRenk,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10)
                         ),
                    ),
                    child: SizedBox(
                      height: 30,
                      width: 110,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5,right: 5),
                        child: TextFormField(
                          maxLength: 12,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          style: TextStyle(
                              color: renkler.koyuuRenk,
                              fontSize: 16,
                              fontFamily: 'Nexa4'),
                          onChanged: (value) {
                            if (firstselect == true) {
                              if (sayi2Controller.text != "" &&
                                  sayi1Controller.text != "") {
                                sonuc = ((double.parse(sayi2Controller.text) /
                                        double.parse(sayi1Controller.text)) *
                                    100);
                                yuzdeOranController.text = sonuc.toString();
                              }
                            } else if (secondselect == true) {
                              if (sayi1Controller.text != "" &&
                                  sayi2Controller.text != "") {
                                sonuc = ((double.parse(sayi2Controller.text) -
                                            double.parse(sayi1Controller.text)) *
                                        100) /
                                    double.parse(sayi1Controller.text);
                                yuzdeOranController.text = sonuc.toString();
                              }
                            } else if (yuzdeOranController.text != "") {
                              sonuc = double.parse(sayi1Controller.text) *
                                  (double.parse(yuzdeOranController.text) / 100);
                              sonucController.text = sonuc.toString();
                            }
                          },
                          keyboardType: TextInputType.number,
                          controller: sayi1Controller,
                          decoration: const InputDecoration(
                            hintText: 'Sayıyı Giriniz',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Nexa3'
                              ),
                              counterText: '',
                            isDense: true,
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
                          children: [
                            const SizedBox(
                              width: 180,
                              child: Text(
                                "2. Sayı",
                                style: TextStyle(
                                  fontFamily: "Nexa4",
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: renkler.yaziRenk,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10)),
                              ),
                              child: SizedBox(
                                height: 30,
                                width: 110,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5,right: 5),
                                  child: TextFormField(
                                    maxLength: 12,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    style: TextStyle(
                                        color: renkler.koyuuRenk,
                                        fontSize: 16,
                                        fontFamily: 'Nexa4'),
                                    onChanged: (value) {
                                      if (firstselect == true) {
                                        if (sayi2Controller.text != "" &&
                                            sayi1Controller.text != "") {
                                          sonuc = ((double.parse(
                                                      sayi2Controller.text) /
                                                  double.parse(
                                                      sayi1Controller.text)) *
                                              100);
                                          yuzdeOranController.text =
                                              sonuc.toStringAsFixed(2);
                                        }
                                      } else if (secondselect == true) {
                                        if (sayi1Controller.text != "" &&
                                            sayi2Controller.text != "") {
                                          sonuc = ((double.parse(
                                                          sayi2Controller.text) -
                                                      double.parse(
                                                          sayi1Controller.text)) *
                                                  100) /
                                              double.parse(sayi1Controller.text);
                                          yuzdeOranController.text =
                                              sonuc.toStringAsFixed(2);
                                        }
                                      }
                                    },
                                    controller: sayi2Controller,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        counterText: '',
                                        hintText: 'Sayıyı Giriniz',
                                        hintStyle: TextStyle(
                                          fontSize: 14,
                                            fontFamily: 'Nexa3'
                                        ),
                                        isDense: true,
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                    )),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : const SizedBox(height: 1),
              SizedBox(
                height: size.height / 40,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 180,
                    child: sayi2ishere
                        ? const Text(
                            "İşlem Sonucu",
                            style: TextStyle(
                              fontFamily: "Nexa4",
                              fontSize: 17,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            "Yüzde Oranı",
                            style: TextStyle(
                              fontFamily: "Nexa4",
                              fontSize: 17,
                              color: Colors.white,
                            ),
                          ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: renkler.yaziRenk,
                      borderRadius: const BorderRadius.all(
                          Radius.circular(10)),
                    ),
                    child: SizedBox(
                      height: 30,
                      width: 110,
                      child: Padding(
                        padding:  const EdgeInsets.only(left: 5,right: 5),
                        child: TextFormField(
                          maxLength: sayi2ishere ? null : 10,
                          readOnly: sayi2ishere ? true : false,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          style: TextStyle(
                              color: renkler.koyuuRenk,
                              fontFamily: 'Nexa4',
                              fontSize: 16),
                          onChanged: (value) {
                            if (sayi1Controller.text.isNotEmpty && yuzdeOranController.text.isNotEmpty) {
                              // Virgülü noktaya dönüştür
                              final sayi1 = sayi1Controller.text.replaceAll(',', '.');
                              final yuzdeOran = yuzdeOranController.text.replaceAll(',', '.');

                              sonuc = double.parse(sayi1) * (double.parse(yuzdeOran) / 100);
                              sonucController.text = sonuc.toStringAsFixed(2);
                            }
                          },
                          controller: yuzdeOranController,
                          keyboardType: TextInputType.number,
                          decoration:  InputDecoration(
                              isDense: true,
                              counterText: '',
                              hintText: sayi2ishere ? null : 'Yüzdeyi Giriniz',
                              hintStyle: const TextStyle(
                                fontSize: 14,
                                  fontFamily: 'Nexa3'
                              ),
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
                            )
                             ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          ///2. satır
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              height: 4,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                color: renkler.sariRenk,
              ),
            ),
          ),

          ///divider koyduk
          Padding(
            padding:  const EdgeInsets.only(top: 20, bottom: 5),
            child: !sayi2ishere
                ? Row(
                    children: [
                      SizedBox(
                        width : 140,
                        child: Text(
                          "Sonuç",
                          style: TextStyle(
                              fontFamily: "Nexa4",
                              fontSize: 17,
                              color: renkler.yaziRenk),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: renkler.yaziRenk,
                            borderRadius: const BorderRadius.all(Radius.circular(10)
                                )),
                        child: SizedBox(
                          height: 30,
                          width: 150,
                          child: Padding(
                            padding:  const EdgeInsets.only(left: 5,bottom: 2,right: 5),
                            child: TextFormField(
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
                      ),
                    ],
                  )
                : const SizedBox(height: 1),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: renkler.sariRenk,
                          width: 4,
                        ),
                        borderRadius: BorderRadius.circular(4)),
                    activeColor: renkler.sariRenk,
                    value: sayi2ishere,
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
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      "2.Sayıyı İşleme Al",
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
                        Checkbox(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: renkler.sariRenk,
                                width: 4,
                              ),
                              borderRadius: BorderRadius.circular(4)),
                          activeColor: renkler.sariRenk,
                          value: firstselect,
                          onChanged: (value) {
                            if (secondselect) {
                              setState(() {
                                firstselect = value!;
                                secondselect = false;
                              });
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            "2.Sayı 1.Sayının Yüzde Kaçıdır?",
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
                        Checkbox(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: renkler.sariRenk,
                                  width: 4,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(4)),
                          activeColor: renkler.sariRenk,
                          value: secondselect,
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
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            "1.Sayıdan 2.Sayıya \nDeğişimin Oranı Kaçtır?",
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
        ],
      ),
    );
  }

  Widget currencyConverter() {
    void switchPages() {
      int currentPage1 = pageCurrency.page!.toInt();
      pageCurrency.jumpToPage(pageCurrency2.page!.toInt());
      pageCurrency2.jumpToPage(currentPage1);
    }

    List<String> listCurrency = ['TL', 'USD', 'EURO'];
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'DÖVİZ HESAPLAMA',
                style: TextStyle(
                  fontFamily: 'NEXA4',
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 40,
              width: 40,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.clear,
                    size: 25,
                  ),
                  color: const Color(0xFF0D1C26),
                  onPressed: () {
                    changePage(0);
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: PageView(
                      onPageChanged: (value) {
                        selectedCurrency = value;
                        setState(() {
                          switchCurrency();
                        });
                      },
                      controller: pageCurrency,
                      children: listCurrency
                          .map(
                            (value) => Center(
                          child: Text(
                            value,
                            style: const TextStyle(
                              color: Color(0xFFF2CB05),
                              fontSize: 28,
                              fontFamily: 'Nexa4',
                              fontWeight: FontWeight.w600,
                              height: 1.3,
                            ),
                          ),
                        ),
                      )
                          .toList(),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: 100,
                    child: TextField(
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Nexa4',
                        fontSize: 24,
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        hintText: 'Tutar',
                        hintStyle: TextStyle(
                          fontFamily: 'Nexa4',
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      onChanged: (value) {
                        switchCurrency();
                      },
                      keyboardType: TextInputType.number,
                      controller: nums,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 100,
                child: IconButton(
                  icon: const Icon(
                    Icons.loop_rounded,
                    size: 50,
                  ),
                  color: const Color(0xFFF2CB05),
                  onPressed: () {
                    switchPages();
                  },
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: PageView(
                      onPageChanged: (value) {
                        selectedCurrency2 = value;
                        switchCurrency();
                      },
                      controller: pageCurrency2,
                      children: listCurrency
                          .map(
                            (value) => Center(
                          child: Text(
                            value,
                            style: const TextStyle(
                              color: Color(0xFFF2CB05),
                              fontSize: 28,
                              fontFamily: 'Nexa4',
                              fontWeight: FontWeight.w600,
                              height: 1.3,
                            ),
                          ),
                        ),
                      )
                          .toList(),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: 100,
                    child: Center(
                        child: TextField(
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Nexa4',
                            fontSize: 24,
                            color: Colors.white,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            hintText: 'Sonuç',
                            hintStyle: TextStyle(
                              fontFamily: 'Nexa4',
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                          enabled: false,
                          controller: sonuc,
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 120,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                color: Color(0xFFF2CB05),
              ),
              child: TextButton(
                  onPressed: () {
                    nums.clear();
                    sonuc.clear();
                  },
                  child: const Text(
                    ' Sıfırla ',
                    style: TextStyle(
                      fontFamily: 'NEXA4',
                      fontSize: 20,
                      color: Color(0xFF0D1C26),
                    ),
                  )),
            ),
            Container(
              width: 120,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                color: Color(0xFFF2CB05),
              ),
              child: TextButton(
                  onPressed: () {
                    if (double.parse(sonuc.text) > 0) {
                      Clipboard.setData(ClipboardData(text: sonuc.text));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Color(0xff0D1C26),
                          duration: Duration(seconds: 1),
                          content: Text(
                            'Metin panoya kopyalandı',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w600,
                              height: 1.3,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    ' Kopyala ',
                    style: TextStyle(
                      fontFamily: 'NEXA4',
                      fontSize: 20,
                      color: Color(0xFF0D1C26),
                    ),
                  )),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "14.04.2023 Verilerine Göre",
          style: TextStyle(
            fontFamily: 'NEXA4',
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        Text(
          "Dolar Kuru : $kurdolar",
          style: const TextStyle(
            fontFamily: 'NEXA4',
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        Text(
          "Euro Kuru : $kureuro",
          style: const TextStyle(
            fontFamily: 'NEXA4',
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        const Text(
          "",
          style: TextStyle(
            fontFamily: 'NEXA4',
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
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
