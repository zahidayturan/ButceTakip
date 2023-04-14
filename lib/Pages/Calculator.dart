import 'dart:math';

import 'package:butcekontrol/constans/MaterialColor.dart';
import 'package:butcekontrol/constans/TextPref.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../classes/appBarForPage.dart';


class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final PageController _pagecont = PageController(initialPage: 0);
  int _currentPageindex = 0 ;
  void changePage(int pageindex){
    setState(() {
      _currentPageindex = pageindex ;
    });
    _pagecont.jumpToPage(pageindex);
  }
  String result = "0";
  String num1 = "";
  String num2 = "";
  String operand = "";

  void onTabbtn(String btnValue){
    if(btnValue == "C"){
      result = "0";
      num1 = "";
      num2 = "";
      operand = "";
    }else if(btnValue == "?"){
      result = "ibrahim ethem";
    }else if(btnValue == "½"){
      result = (double.parse(result) / 2).toString() ;
    }else if(btnValue == "<="){
      if(result.length != 1) {
        result = result.substring(0, result.length - 1);
      }else{
        result = "0";
      }
    }else if(btnValue == "/" || btnValue == "x" || btnValue == "-" || btnValue == "+"){
      num1 = result ;
      operand = btnValue ;
      result = "0" ;
    }else if(btnValue == ","){
      if(result.contains(".")){
        return;
      }else{
        result = result + ".";
      }
    }else if(btnValue == "="){
      num2 = result ;
      if(operand == "+"){
        result = (double.parse(num1) + double.parse(num2)).toString();
      }
      if (operand == "-"){
        result = (double.parse(num1) - double.parse(num2)).toString();
      }
      if(operand == "/"){
        if (num2 != "0"){
          result = (double.parse(num1) / double.parse(num2)).toString() ;
        }else{
          result = "TANIMSIZ";
        }
      }
      if(operand == "x"){
        result = (double.parse(num1) * double.parse(num2)).toString();
      }
      num1 = "";
      num2 = "";
      operand = "";
    }else{
      if(result == "0"){
        result =  btnValue ;
      }else {
        result = result + btnValue;
      }
    }
    setState(() {
      if(result.length > 15){
        result =  "overFlow";
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    CustomColors renkler = CustomColors();
    var size = MediaQuery.of(context).size ;
    return Container(
      color: renkler.koyuuRenk,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xffF2F2F2),
          appBar: AppBarForPage(title: 'HESAP MAKİNESİ'),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15.0,
                    bottom: 7.0,
                    right: 20.0,
                    left: 20.0,
                  ),
                  child: SizedBox(
                    height: size.height*00.584 ,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                        bottomLeft:  Radius.circular(40),
                      ),
                      child: Container(
                        color: renkler.koyuuRenk,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: PageView(
                            controller: _pagecont,
                            onPageChanged: (value) => setState(() => _currentPageindex = value),
                            children: [
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15.0),
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
                                  Divider(color: Colors.white, thickness: 2),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Buttoncreate("C",size,),
                                            Buttoncreate("<=",size),
                                            Buttoncreate("½",size),
                                            Buttoncreate("/",size)
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Buttoncreate("7",size),
                                            Buttoncreate("8",size),
                                            Buttoncreate("9",size),
                                            Buttoncreate("x",size)
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Buttoncreate("4",size),
                                            Buttoncreate("5",size),
                                            Buttoncreate("6",size),
                                            Buttoncreate("-",size)
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Buttoncreate("1",size),
                                            Buttoncreate("2",size),
                                            Buttoncreate("3",size),
                                            Buttoncreate("+",size)
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Buttoncreate("?",size),
                                            Buttoncreate("0",size),
                                            Buttoncreate(",",size),
                                            equalsBtnCreat(size),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ), //Tus takımı bulunacaktır.
                                ],
                              ),
                              YuzdePAge(),
                              KrediPage(),
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
                        width: size.width /3,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 2.0 ,
                                color : renkler.koyuuRenk,
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
                        width: size.width /3,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 2.0 ,
                                color : renkler.koyuuRenk,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),///orta cizgi gelicek
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        changePage(1);
                        print("Yüzde Hesaplama");
                      },
                      child: SizedBox(
                        height: size.width/5,
                        width: size.width/5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: renkler.koyuuRenk,
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
                    ),
                    InkWell(
                      onTap: () {
                        changePage(2);
                        print("Faiz-Kredi Hesaplama");
                      },
                      child: SizedBox(
                        height: size.width/5,
                        width: size.width/5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: renkler.koyuuRenk,
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
                    ),
                    InkWell(
                      onTap: () {
                        print("Yüzde Hesapla");
                      },
                      child: SizedBox(
                        height: size.width/5,
                        width: size.width/5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: renkler.koyuuRenk,
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
                    ),
                  ],
                ),/// Sayfa butonları gelecek.
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget YuzdePAge(){
    TextEditingController Sayi1controller = TextEditingController();
    CustomColors renkler = CustomColors();
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 40,
                  width: 40 ,
                  child: DecoratedBox(
                    decoration:  BoxDecoration(
                      color: renkler.ArkaRenk,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IconButton(
                      icon: Icon(
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
            Column(
              children: [
                Row(
                  children: [
                    Text("SAYI 1"),
                    SizedBox(
                      height: 20,
                      width: 60,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: renkler.ArkaRenk,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextField(
                          controller: Sayi1controller,

                        ),
                      ),
                    ),
                  ],
                ),
                Row(),
                const Divider(
                  thickness: 4,
                  color: Colors.white,
                ),
                Column(
                  children: [
                    Row(),
                    Row(),
                    Row(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget KrediPage(){
    TextEditingController anaPara = TextEditingController();
    TextEditingController faizYuzde = TextEditingController();
    GlobalKey dropDownKey = GlobalKey();
    GlobalKey heseplamalarSonucu = GlobalKey();
    var size = MediaQuery.of(context).size ;
    var renkler = CustomColors();
    final List<String> monthList = ["3", "6", "9", "12", "18", "24", "30", "36", "44", "48"];
    String? selectedValue = monthList[0]; /// vade kismindaki
    double toplamAnaPara = 0;
    double faizTutari = 0;
    double toplamOdenecekTutar = 0;
    double aylikTaksit = 0;
    List<String> tutarList = ["$aylikTaksit", "$toplamAnaPara", "$faizTutari", "$toplamOdenecekTutar"];


    void faizHesapla(TextEditingController anaPara, TextEditingController faizYuzde, int vadeSuresi){
      if(faizYuzde.text.isEmpty || anaPara.text.isEmpty){
        showModalBottomSheet(context: context, builder: (BuildContext context){
          return Container(
            height: 40,
            color: renkler.koyuuRenk,
              child: Center(
                child: Text(
                  'gerekli alanları doldurun',
                  style: TextStyle(
                    fontFamily: 'Nexa4',
                    fontSize: 20,
                    color: renkler.sariRenk,
                  ),
                ),
              ),
          );
        });
      }
      else{
        faizTutari = double.parse(anaPara.text) / 100 * double.parse(faizYuzde.text);
        toplamAnaPara = double.parse(anaPara.text);
        toplamOdenecekTutar = faizTutari + toplamAnaPara;
        aylikTaksit = toplamOdenecekTutar / vadeSuresi;

        tutarList[0] = aylikTaksit.toString();
        tutarList[1] = toplamAnaPara.toString();
        tutarList[2] = faizTutari.toString();
        tutarList[3] = toplamOdenecekTutar.toString();
      }
    }

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                    "KREDİ HESAPLAMA",
                  style: TextStyle(
                    fontSize: 28,
                    fontFamily: 'Nexa4',
                    color: renkler.YaziRenk,
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: 40 ,
                  child: DecoratedBox(
                    decoration:  BoxDecoration(
                      color: renkler.ArkaRenk,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IconButton(
                      icon: Icon(
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
            ), /// çıkış butonu
            SizedBox(height: size.height / 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Ana Para",
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Nexa4',
                    color: renkler.YaziRenk,
                  ),
                ),
                Container( // ana paranin para kisminin arka pilan rengi
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20)
                    ),
                    color: renkler.YaziRenk,
                ),
                  child: Row(
                    children: [
                      Container(
                        width: 112,
                        height: size.height / 20,
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
                            fontSize: 22,
                          ),
                          decoration: InputDecoration(
                            counterText: '', /// kalan karakteri gösteren yazıyı kaldırıyor.
                            enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  style: BorderStyle.none
                                ),
                              ),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  style: BorderStyle.none
                                ),
                              ),
                            hintText: "0.0",
                            isDense: true,
                            hintStyle: TextStyle(
                              color: renkler.koyuuRenk,
                              fontSize: 22,
                              fontFamily: 'Nexa4',
                            ),
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Text(
                        ' ₺',
                        style: TextStyle(
                          fontFamily: 'TL',
                          fontSize: 22,
                          color: renkler.koyuuRenk,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ), /// ana para
            SizedBox(height: size.height / 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Faiz (yüzde)",
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Nexa4',
                    color: renkler.YaziRenk,
                  ),
                ),
                Container(
                  width: 130,
                  height: size.height / 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20)
                    ),
                    color: renkler.YaziRenk,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 80,
                        height: size.height / 20,
                        child: TextFormField(
                          maxLength: 2,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          controller: faizYuzde,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            color: renkler.koyuuRenk,
                            fontSize: 22,
                            fontFamily: 'Nexa4',
                          ),
                          decoration: InputDecoration(
                            counterText: '',
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
                              fontSize: 22,
                              fontFamily: 'Nexa4',
                            ),
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Text(
                        " %",
                        style: TextStyle(
                            fontFamily: 'Nexa4',
                            fontSize: 22,
                            color: renkler.koyuuRenk
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ), /// faiz yuzde
            SizedBox(height: size.height / 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Vade",
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Nexa4',
                    color: renkler.YaziRenk,
                  ),
                ),
                Container(
                  width: 130,
                  alignment: Alignment.centerRight,
                  height: size.height / 19,
                  decoration: BoxDecoration(
                    color: renkler.YaziRenk,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), topLeft: Radius.circular(20))
                  ),
                  child: DropdownButtonFormField<String>(
                    key: dropDownKey, /// bunun kullanim nedeni sıfırla yapınca varsayılan vade gelmesi için
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    iconSize: 30,
                    alignment: Alignment.centerRight,
                    decoration:  const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          style: BorderStyle.none,
                        )
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          style: BorderStyle.none,
                        )
                      )
                    ),
                    iconEnabledColor: renkler.koyuuRenk,
                    value: selectedValue,
                    style: TextStyle(
                      color: renkler.koyuuRenk,
                      fontFamily: 'Nexa4',
                      fontSize: 22,
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
                )
              ],
            ), /// kredi suresi
            SizedBox(height: size.height / 45,),
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
                    });
                    print("reset");
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: size.height / 18,
                    width: size.width / 3.2,
                    decoration: BoxDecoration(
                      color: renkler.sariRenk,
                     borderRadius: BorderRadius.all(Radius.circular(25))
                    ),
                    child: Text(
                      "SIFIRLA",
                      style: TextStyle(
                        color: renkler.koyuuRenk,
                        fontSize: 20,
                        fontFamily: "Nexa4",
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                      faizHesapla(anaPara, faizYuzde, int.parse(selectedValue.toString()));
                      heseplamalarSonucu = GlobalKey();
                      print(tutarList[0]);
                      print(tutarList[1]);
                      print(tutarList[2]);
                      print(tutarList[3]);

                    print("run");
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: size.height / 18,
                    width: size.width / 3.2,
                    decoration: BoxDecoration(
                        color: renkler.sariRenk,
                        borderRadius: BorderRadius.all(Radius.circular(25))
                    ),
                    child: Text(
                      "HESAPLA",
                      style: TextStyle(
                        color: renkler.koyuuRenk,
                        fontSize: 20,
                        fontFamily: "Nexa4",
                      ),
                    ),
                  ),
                )
              ],
            ), /// sıfırla ve hesapla butonları
            SizedBox(height: size.height / 45,),
            Container(
              key: heseplamalarSonucu,
              height: size.height / 5.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Aylık Eşit Taksi:  ',
                                style: TextStyle(
                                  color: renkler.YaziRenk,
                                  fontFamily: 'Nexa4',
                                  fontSize: 18,
                                ),
                              ),
                              TextSpan(
                                text: '${tutarList[0]}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Nexa4',
                                  color: renkler.YaziRenk,
                                )
                              ),
                              TextSpan(
                                text: ' ₺',
                                style: TextStyle(
                                  fontFamily: 'TL',
                                  fontSize: 18,
                                  color: renkler.YaziRenk,
                                ),
                              ),
                            ]
                          )
                      )
                    ],
                  ), // aylık eşit taksit
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Toplam Ana Para:  ',
                                  style: TextStyle(
                                    color: renkler.YaziRenk,
                                    fontFamily: 'Nexa4',
                                    fontSize: 18,
                                  ),
                                ),
                                TextSpan(
                                    text: '${toplamAnaPara}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Nexa4',
                                      color: renkler.YaziRenk,
                                    )
                                ),
                                TextSpan(
                                  text: ' ₺',
                                  style: TextStyle(
                                    fontFamily: 'TL',
                                    fontSize: 18,
                                    color: renkler.YaziRenk,
                                  ),
                                ),
                              ]
                          )
                      )
                    ],
                  ), // toplam ana para
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Toplam Faiz:  ',
                                  style: TextStyle(
                                    color: renkler.YaziRenk,
                                    fontFamily: 'Nexa4',
                                    fontSize: 18,
                                  ),
                                ),
                                TextSpan(
                                    text: '$faizTutari',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Nexa4',
                                      color: renkler.YaziRenk,
                                    )
                                ),
                                TextSpan(
                                  text: ' ₺',
                                  style: TextStyle(
                                    fontFamily: 'TL',
                                    fontSize: 18,
                                    color: renkler.YaziRenk,
                                  ),
                                ),
                              ]
                          )
                      )
                    ],
                  ), // toplam faiz
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Toplam Ödeme:  ',
                                  style: TextStyle(
                                    color: renkler.sariRenk,
                                    fontFamily: 'Nexa4',
                                    fontSize: 22,
                                  ),
                                ),
                                TextSpan(
                                    text: '$toplamOdenecekTutar',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontFamily: 'Nexa4',
                                      color: renkler.sariRenk,
                                    )
                                ),
                                TextSpan(
                                  text: ' ₺',
                                  style: TextStyle(
                                    fontFamily: 'TL',
                                    fontSize: 22,
                                    color: renkler.sariRenk,
                                  ),
                                ),
                              ]
                          )
                      )
                    ],
                  ), // toplam ödeme
                ],
              ),
            ), /// Sıfırla ve hesapla butonları altındaki bileşenlerin bulunduğu kısım.

          ],
        ),
      ),

    );

  }
  Widget equalsBtnCreat(Size size){
    return SizedBox(
      height: size.width * 00.135 ,
      width: size.width * 00.135 ,
      child:DecoratedBox(
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
      height: size.width* 00.135 ,
      width: size.width* 00.135 ,
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
                  color:  Colors.black,
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