import 'package:butcekontrol/constans/TextPref.dart';
import 'package:butcekontrol/modals/Spendinfo.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:butcekontrol/classes/appBarStatistics.dart';
import 'package:butcekontrol/classes/navBar.dart';
import 'package:butcekontrol/constans/MaterialColor.dart';
import 'package:butcekontrol/utils/dbHelper.dart';
import 'package:d_chart/d_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';

class Statistics extends ConsumerWidget{
  var renkler = CustomColors();
  var incomExpenseState = ExpenseIncomSection().createState();

  Statistics({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size ;
    return Scaffold(
      appBar: AppBarStatistics(),
      body: Column(
        children: [
          const SizedBox(height: 20,),
          Row(    // burasi üç sütundan oluşmaktadır ilk sütün gelir gider tuşları, ikinci sütun pasta şeması, üçüncü sütun tarih ve buton var
            children: [
              Expanded(
                flex: 1,// gelir gider butonlari, expanded kullanma nedeni satırı üç ayrı kolona ayırabilmek için.
                child: Align( // butonları sola yasladım
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      RotatedBox( //butonları çevirmek için
                          quarterTurns: 3,
                          child: CustomButton(),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded( // burasi pasta modelinin olduğu kısımç
                flex: 5,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      PieModel(),
                    ],
                  ),
                ),
              ),
              Expanded( // (ay, hafta, yıl) butonları
                flex: 1,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    children: [
                      RotatedBox(
                        quarterTurns: 3,
                        //child: CustomBotton2(),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              ExpenseIncomSection(),
            ],
          ),
          Text("")
        ],
      ),
      bottomNavigationBar: const navBar(),
    );
  }
}


class CustomBotton2 extends StatefulWidget{ // sağ taraftaki (ay, hafta, yıl) butonları
  @override
    _CustomButtonState2 createState() => _CustomButtonState2();
}
class _CustomButtonState2 extends State<CustomBotton2>{
  var listMonths = ["OCAK", "SUBAT", "MART", "NISAN", "MAYIS", "HAZIRAN", "TEMMUZ", "AGUSTOS", "EYLUL", "EKIM", "KASIM", "ARALIK"];
  var renkler = CustomColors();
  var zaman = DateTime.now();
  var monthYearWeekButton = "AY"; // popup menüsünün buton yazısıdır
  late var monthYearWeekButtonResult = "${listMonths[zaman.month - 1]} ${zaman.year}";
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 40,
                width: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                  color: renkler.koyuuRenk,
                ),
                child: Padding( // row içindeki yazıları sağ yasladığımız için onlara sağdan padding verdik
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end, // yazıları sağ yasladık
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Text( // popup menüden seçilene göre tarih bilgisi veriyor
                        monthYearWeekButtonResult,
                        style: TextStyle(
                          color: renkler.YaziRenk,
                          fontSize: 20,
                          fontFamily: 'Nexa4',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: -38,
                width:85,
                height: 50,
                child: Container( // bunu ayrı bir dart dosyasında yazmaya çalış
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: renkler.sariRenk,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                    // buraya ay yıl hafta açılabilir menu gelecek, veya stack i kullanarak position ile üstüne yazarız
                  ),
                  child: PopupMenuButton(
                    shadowColor: null,
                      onSelected: (value){
                        setState(() {
                          monthYearWeekSelect(value);
                        });
                      },
                      color: renkler.sariRenk,
                      child: Text(
                        "< ${monthYearWeekButton}",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Nexa4',
                          color: renkler.koyuuRenk,
                        ),
                      ),
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem(child: Text('AY'), value: "AY",),
                        PopupMenuItem(child: Text('HAFTA'), value: "HAFTA",),
                        PopupMenuItem(child: Text('YIL'), value: "YIL",),
                      ]),
                ),
              ),
            ]
        ),
      ],
    );
  }
  monthYearWeekSelect(var value){ // bu metod (ay,yıl,hafta) seçeneklerden birisini seçince butonun yanındaki yazılar seçilene göre değişecektir.
    if(value == "AY") {
      monthYearWeekButton = value;
      monthYearWeekButtonResult = "${listMonths[zaman.month - 1]} ${zaman.year}";
    }
    else if(value == "HAFTA"){
      monthYearWeekButton = value;
      if(zaman.day >= 1 && zaman.day <= 7){
        monthYearWeekButtonResult = "1.${zaman.month}~7.${zaman.month}";
      }
      else if(zaman.day >= 8 && zaman.day <= 14){
        monthYearWeekButtonResult = "8.${zaman.month}~14.${zaman.month}";
      }
      else if(zaman.day >= 15 && zaman.day <= 21){
        monthYearWeekButtonResult = "15.${zaman.month}~21.${zaman.month}";
      }
      else if(zaman.day >= 22){
        if(zaman.month == 12) // aralık ayında isek başa döneceği için bu şekilde koşul koyduk
          monthYearWeekButtonResult = "22.${zaman.month}  ~  1.1";
        else
          monthYearWeekButtonResult = "22.${zaman.month}  ~  1.${zaman.month + 1}";
      }
    }
    else if(value == "YIL"){
      monthYearWeekButton = value;
      monthYearWeekButtonResult = "${zaman.year}~${zaman.year + 1}";
    }
  }
}


class CustomButton extends ConsumerStatefulWidget{ // sol taraftaki gelir gider buton animasyonlari
  @override
  ConsumerState<CustomButton> createState() => _CustomButtonState();
}
class _CustomButtonState extends ConsumerState<CustomButton> {
  double buttonHeight = 34; //Basılmamış yükseklik
  double buttonHeight2 = 40; //Basılmış yükseklik
  Color containerColor2 = const Color(0xff0D1C26); //Basılmamış renk
  Color containerColor = const Color(0xffF2CB05); //Basılmış renk
  Color textColor2 = Colors.white; //Basılmamış yazı rengi
  Color textColor = const Color(0xff0D1C26); //Basılmış yazı rengi
  int index = 0; // Gider ve Gelir butonları arasında geçiş yapmak için

  void changeColor2(int index) {
    if (index == 0) { //index 0 olunca Gider için ayarlanıyor
      setState(() {
        buttonHeight2 = 40;
        buttonHeight = 34;
        containerColor = const Color(0xffF2CB05);
        containerColor2 = const Color(0xff0D1C26);
        textColor = const Color(0xff0D1C26);
        textColor2 = Colors.white;
        this.index = 1;
      });
    } else { //index 0'dan farklı olunca Gelir için ayarlanıyor
      setState(() {
        buttonHeight = 40;
        buttonHeight2 = 34;
        containerColor2 = const Color(0xffF2CB05);
        containerColor = const Color(0xff0D1C26);
        textColor = Colors.white;
        textColor2 = const Color(0xff0D1C26);
        this.index = 0;
      });
    }
  }
  var gelirGiderSonucu = "gelir";

  Widget customButtonTheme2() {
    var read = ref.read(statisticsRiverpod);

    return SizedBox(
      height: 40,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20)),
              color: Color(0xff0D1C26),
            ),
            height: 34,
            width: 180,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1200),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),
                    color: containerColor,
                  ),
                  height: buttonHeight2,
                  child: SizedBox(
                    width: 75,
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            gelirGiderSonucu = "gider";
                            print(gelirGiderSonucu);
                            changeColor2(0);

                            read.gelirGiderSet("Gider");

                          });
                        },
                        child: Text("GİDER",
                            style: TextStyle(
                                color: textColor,
                                fontSize: 17,
                                fontFamily: 'Nexa4',
                                fontWeight: FontWeight.w800))),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1200),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),
                    color: containerColor2,
                  ),
                  height: buttonHeight,
                  child: SizedBox(
                    width: 75,
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            gelirGiderSonucu = "gelir";
                            print(gelirGiderSonucu);
                            changeColor2(1);

                            read.gelirGiderSet("Gelir");

                          });
                        },
                        child: Text("GELİR",
                            style: TextStyle(
                                color: textColor2,
                                fontSize: 17,
                                fontFamily: 'Nexa4',
                                fontWeight: FontWeight.w800))),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return customButtonTheme2();
  }
}

class PieModel extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _PieModelState();
}
class _PieModelState extends State<PieModel>{
  var listMap = [
    {"kategori": "yemek", "miktar": 123},
    {"kategori": "market", "miktar": 24},
    {"kategori": "dolmus", "miktar": 123},
    {"kategori": "yemek", "miktar": 123},
  ];
  @override
  Widget build(BuildContext context) {
    return Row(
        children: [ //buraya pasta modeli gelecek

        ],
    );
  }
}

class ExpenseIncomSection extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ExpenseIncomSectionState();
}
class _ExpenseIncomSectionState extends State<ExpenseIncomSection>{
  final ScrollController Scrollbarcontroller = ScrollController();
  var renkler = CustomColors();
  var incomList = [ // deneme amacli
    {"kategori": "maas", "miktar": 304},
    {"kategori": "maas", "miktar": 230},
    {"kategori": "burs", "miktar": 134},
    {"kategori": "fazla mesai", "miktar": 87},
    {"kategori": "maas", "miktar": 221},
    {"kategori": "maas", "miktar": 55},
    {"kategori": "burs", "miktar": 23},
    {"kategori": "harclik", "miktar": 33},
    {"kategori": "burs", "miktar": 123},
    {"kategori": "burs", "miktar": 222},
  ];
  var expenseList = [ // deneme amacli
    {"kategori": "Yemek", "miktar": 304},
    {"kategori": "Ulasim", "miktar": 230},
    {"kategori": "Eglence", "miktar": 134},
    {"kategori": "Aidat", "miktar": 87},
    {"kategori": "Seyahat", "miktar": 221},
    {"kategori": "ulasim", "miktar": 55},
    {"kategori": "harcama", "miktar": 23},
    {"kategori": "Market", "miktar": 33},
    {"kategori": "Kira", "miktar": 123},
    {"kategori": "Diger", "miktar": 222},
  ];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size ;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: SizedBox(
          height: size.height / 2.5,
          child: Theme(
            data: Theme.of(context).copyWith(
                scrollbarTheme: ScrollbarThemeData(
                  thumbColor:
                  MaterialStateProperty.all(renkler.sariRenk),
                )),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 1.75),
                    child: SizedBox(
                      width: 4,
                      height: size.height / 2.5,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(40)),
                          color: renkler.koyuuRenk,
                        ),
                      ),
                    ),
                  ),
                ),
                Scrollbar(
                  scrollbarOrientation: ScrollbarOrientation.right,
                  thumbVisibility: true,
                  interactive: true,
                  radius: Radius.circular(20),
                  controller: Scrollbarcontroller,
                  thickness: 7,
                  child: ListView.builder(
                    controller: Scrollbarcontroller,
                    itemCount: expenseList.length,
                    itemBuilder: (BuildContext context, index) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 20),
                            child: ClipRRect(  //Borderradius vermek için kullanıyoruz
                              borderRadius:
                              BorderRadius.circular(10.0),
                              child: Container(
                                height: size.height / 15.5,
                                color: renkler.ArkaRenk,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding( // yüzde ve kategorinin olduğu kısım
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: size.width / 7.8,
                                            padding: EdgeInsets.only(top: 2, bottom: 2),
                                            decoration: BoxDecoration(
                                              color: ColorsOfTheCategories().colorsList[index],
                                              borderRadius: BorderRadius.all(Radius.circular(20)),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center, // yüzdeliği ortalamak için Row kullanık
                                              children: [
                                                Textmod("%30", renkler.YaziRenk, 17),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: size.width / 30,),
                                          SizedBox(
                                            width: 100,
                                            child: Textmod("${expenseList[index]["kategori"]}", renkler.koyuuRenk, 17),
                                          ),
                                        ],
                                      ),
                                    ),

                                    SizedBox( // miktarın olduğu kısım
                                      width: 65,
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Textmod("${expenseList[index]["miktar"]} ₺", renkler.sariRenk, 17)
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height / 55,
                          ) // elemanlar arasına bşluk bırakmak için kulllandım.
                        ],
                      );
                    },
                  ), // listView.Builder kısmı
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ColorsOfTheCategories{
  var colorsList = [
    Colors.red,
    Colors.deepOrange,
    Colors.orange,
    Colors.amber,
    Colors.yellow,
    Colors.lime,
    Colors.green,
    Colors.teal,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.deepPurple,
  ];
}