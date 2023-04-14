import 'package:butcekontrol/constans/MaterialColor.dart';
import 'package:flutter/material.dart';
import '../classes/appBarForPage.dart';

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
        result = result + ".";
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
      color: renkler.koyuuRenk,
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
                    height: size.height * 0.584,
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
                              Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(top: 7.0),
                                        child: Text(
                                          "${result}",
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
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            Buttoncreate(
                                              "C",
                                              size,
                                            ),
                                            Buttoncreate("<=", size),
                                            Buttoncreate("½", size),
                                            Buttoncreate("/", size)
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            Buttoncreate("7", size),
                                            Buttoncreate("8", size),
                                            Buttoncreate("9", size),
                                            Buttoncreate("x", size)
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            Buttoncreate("4", size),
                                            Buttoncreate("5", size),
                                            Buttoncreate("6", size),
                                            Buttoncreate("-", size)
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            Buttoncreate("1", size),
                                            Buttoncreate("2", size),
                                            Buttoncreate("3", size),
                                            Buttoncreate("+", size)
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            Buttoncreate("?", size),
                                            Buttoncreate("0", size),
                                            Buttoncreate(",", size),
                                            equalsBtnCreat(size),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ), //Tus takımı bulunacaktır.
                                ],
                              ),
                              YuzdePAge(), // Page 2
                              Container(), //Page 3
                              currencyConverter(), //Page 4
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
                                color: renkler.koyuuRenk,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                        height: 25,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: renkler.koyuuRenk,
                            borderRadius: BorderRadius.circular(20),
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

                ///orta cizgi gelicek
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        changePage(1);
                        print("Yüzde HEsaplama");
                      },
                      child: SizedBox(
                        height: size.width / 4.8,
                        width: size.width / 4.8,
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
                                Icons.percent,
                                size: 45,
                                color: renkler.ArkaRenk,
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
                        changePage(2);
                        print("Faiz-Kredi Hesaplama");
                      },
                      child: SizedBox(
                        height: size.width / 4.8,
                        width: size.width / 4.8,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: renkler.koyuuRenk,
                            borderRadius: BorderRadius.circular(20),
                            border: _currentPageindex == 2
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
                                color: renkler.ArkaRenk,
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
                        changePage(3);
                      },
                      child: SizedBox(
                        height: size.width / 4.8,
                        width: size.width / 4.8,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: renkler.koyuuRenk,
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
                                color: renkler.ArkaRenk,
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

  Widget currencyConverter() {
    var size = MediaQuery.of(context).size;
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
                  const Text('TL',style: TextStyle(
                    fontFamily: 'NEXA4',
                    fontSize: 24,
                    color: Colors.white,
                  ),),
                  const Text('18.25',style: TextStyle(
                    fontFamily: 'NEXA4',
                    fontSize: 20,
                    color: Colors.white,
                  ),),
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

                  },
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('USD',style: TextStyle(
                    fontFamily: 'NEXA4',
                    fontSize: 24,
                    color: Colors.white,
                  ),),
                  const Text('1.1',style: TextStyle(
                    fontFamily: 'NEXA4',
                    fontSize: 20,
                    color: Colors.white,
                  ),),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
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

                  }, child: const Text(
                ' Sıfırla ',style: TextStyle(
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

                  }, child: const Text(
                ' Kopyala ',style: TextStyle(
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
        const Text("14.04.2023 Verilerine Göre"),
        const Text("14.04.2023 Verilerine Göre"),
        const Text("14.04.2023 Verilerine Göre"),
        const Text("14.04.2023 Verilerine Göre"),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget YuzdePAge() {
    TextEditingController Sayi2controller = TextEditingController();
    TextEditingController Sayi1controller = TextEditingController();
    TextEditingController Yuzdeorancontroller = TextEditingController();
    TextEditingController Sonuccontroller = TextEditingController();
    double Sonuc = 0;
    var size = MediaQuery.of(context).size;
    CustomColors renkler = CustomColors();
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 40,
                  width: 40,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: renkler.ArkaRenk,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.clear,
                        size: 25,
                      ),
                      color: renkler.koyuuRenk,
                      onPressed: () {
                        changePage(0);
                      },
                    ),
                  ),
                ),
              ],
            ),

            ///kapatma butonu
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                children: [
                  SizedBox(
                    width: size.width / 2.3,
                    height: 72,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Sayı 1",
                              style: TextStyle(
                                fontFamily: "Nexa2",
                                fontSize: 17,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: renkler.ArkaRenk,
                                borderRadius: const BorderRadius.horizontal(
                                    left: Radius.circular(20)),
                              ),
                              child: SizedBox(
                                height: 26,
                                width: 90,
                                child: TextField(
                                  onChanged: (value) {
                                    if (firstselect == true) {
                                      if (Sayi2controller.text != "" &&
                                          Sayi1controller.text != "") {
                                        Sonuc = ((double.parse(
                                            Sayi2controller.text) /
                                            double.parse(
                                                Sayi1controller.text)) *
                                            100);
                                        Yuzdeorancontroller.text =
                                            Sonuc.toString();
                                      }
                                    } else if (secondselect == true) {
                                      if (Sayi1controller.text != "" &&
                                          Sayi2controller.text != "") {
                                        Sonuc = ((double.parse(
                                            Sayi2controller.text) -
                                            double.parse(
                                                Sayi1controller.text)) *
                                            100) /
                                            double.parse(Sayi1controller.text);
                                        Yuzdeorancontroller.text =
                                            Sonuc.toString();
                                      }
                                    } else if (Yuzdeorancontroller.text != "") {
                                      Sonuc = double.parse(
                                          Sayi1controller.text) *
                                          (double.parse(
                                              Yuzdeorancontroller.text) /
                                              100);
                                      Sonuccontroller.text = Sonuc.toString();
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  controller: Sayi1controller,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(20)),
                                      )),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Yüzde Oranı",
                              style: TextStyle(
                                fontFamily: "Nexa2",
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: renkler.ArkaRenk,
                                borderRadius: const BorderRadius.horizontal(
                                    left: Radius.circular(20)),
                              ),
                              child: SizedBox(
                                height: 26,
                                width: 80,
                                child: TextField(
                                  onChanged: (value) {
                                    if (Sayi1controller != "") {
                                      Sonuc = double.parse(
                                          Sayi1controller.text) *
                                          (double.parse(
                                              Yuzdeorancontroller.text) /
                                              100);
                                      Sonuccontroller.text = Sonuc.toString();
                                    }
                                  },
                                  controller: Yuzdeorancontroller,
                                  keyboardType: TextInputType.number,
                                  enabled: (firstselect || secondselect) &&
                                      sayi2ishere
                                      ? false
                                      : true,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(20))),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: size.width / 2.6,
                    height: 72,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        sayi2ishere
                            ? Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Sayı 2",
                              style: TextStyle(
                                fontFamily: "Nexa 4",
                                fontSize: 17,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: renkler.ArkaRenk,
                                borderRadius: const BorderRadius.horizontal(
                                    left: Radius.circular(20)),
                              ),
                              child: SizedBox(
                                height: 26,
                                width: 90,
                                child: TextField(
                                  onChanged: (value) {
                                    if (firstselect == true) {
                                      if (Sayi2controller.text != "" &&
                                          Sayi1controller.text != "") {
                                        Sonuc = ((double.parse(
                                            Sayi2controller
                                                .text) /
                                            double.parse(
                                                Sayi1controller
                                                    .text)) *
                                            100);
                                        Yuzdeorancontroller.text =
                                            Sonuc.toString();
                                      }
                                    } else if (secondselect == true) {
                                      if (Sayi1controller.text != "" &&
                                          Sayi2controller.text != "") {
                                        Sonuc = ((double.parse(
                                            Sayi2controller
                                                .text) -
                                            double.parse(
                                                Sayi1controller
                                                    .text)) *
                                            100) /
                                            double.parse(
                                                Sayi1controller.text);
                                        Yuzdeorancontroller.text =
                                            Sonuc.toString();
                                      }
                                    }
                                  },
                                  controller: Sayi2controller,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(20)),
                                      )),
                                ),
                              ),
                            ),
                          ],
                        )
                            : const SizedBox(height: 1),
                        const SizedBox(height: 26),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            ///2. satır
            Padding(
              padding: const EdgeInsets.only(left: 93.0, right: 20),
              child: Divider(
                height: 60,
                color: renkler.sariRenk,
                thickness: 3,
              ),
            ),

            ///divider koyduk
            Padding(
              padding: const EdgeInsets.only(right: 50, left: 10),
              child: !sayi2ishere
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Sonuç",
                    style: TextStyle(
                        fontFamily: "Nexa2",
                        fontSize: 18,
                        color: renkler.ArkaRenk),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: renkler.ArkaRenk,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SizedBox(
                      height: 26,
                      width: 200,
                      child: TextField(
                        enabled: false,
                        controller: Sonuccontroller,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20)),
                            )),
                      ),
                    ),
                  ),
                ],
              )
                  : const SizedBox(height: 26),
            ),

            /// sonuc
            Column(
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
                    Text(
                      "Sayı 2 yi ekle",
                      style: TextStyle(
                        color: renkler.ArkaRenk,
                        fontFamily: "Nexa2",
                        fontSize: 15,
                      ),
                    )
                  ],
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
                    Text(
                      "Sayı 2 Sayı 1'in Yüzde kaçı ?",
                      style: TextStyle(
                        color: renkler.ArkaRenk,
                        fontFamily: "Nexa2",
                        fontSize: 15,
                      ),
                    )
                  ],
                )
                    : const SizedBox(
                  width: 1,
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
                    Text(
                      "Sayı 1'den Sayı 2'ye Değişimin oranı kaçtır?",
                      style: TextStyle(
                        color: renkler.ArkaRenk,
                        fontFamily: "Nexa2",
                        fontSize: 13,
                      ),
                    )
                  ],
                )
                    : const SizedBox(width: 1),
              ],
            ),

            ///checkboxlar
          ],
        ),
      ),
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
            child: Padding(
              padding: EdgeInsets.only(top: 8.0),
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
      ),
    );
  }

  Widget Buttoncreate(String symbol, Size size) {
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
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
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
      ),
    );
  }
}
