import 'package:butcekontrol/classes/app_bar_for_page.dart';
import 'package:butcekontrol/constans/text_pref.dart';
import 'package:butcekontrol/models/spend_info.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:butcekontrol/utils/db_helper.dart';
import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../UI/add_assets.dart';
import '../../constans/material_color.dart';

class assetsPage extends ConsumerWidget {
  assetsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    List<double> getMeasure(double kart, double  nakit, double  diger){
      var totalorigin =  kart + nakit + diger ;
      if(kart <= 0){
        kart = 0;
      }
      if(nakit <= 0){
        nakit = 0;
      }
      if(diger <= 0){
        diger = 0 ;
      }
      var total = kart + nakit + diger ;
      if(total == 0){
        total = 1.0;
      }
      var kardMeasure = 100 * kart / total ;
      var nakitMeasure = 100 * nakit / total ;
      var digerMeasure = 100 * diger / total ;
      List<double> listem = [double.tryParse(kardMeasure.toStringAsFixed(1))!, double.tryParse(nakitMeasure.toStringAsFixed(2))!, double.tryParse(digerMeasure.toStringAsFixed(1))!, double.tryParse(totalorigin.toStringAsFixed(1))!];

      return listem;
    }
    var dbRiv = ref.watch(databaseRiverpod);
    var readSettingsRiv = ref.read(settingsRiverpod);
    var size = MediaQuery.of(context).size;
    var renkler = CustomColors();
    var time = DateTime.now().hour;
    print(time);
    Future<List<SpendInfo>> Total =  SQLHelper.getItems();
    return SafeArea(
        child: Scaffold(
          appBar: const AppBarForPage(title: "VARLIK"),
          body: SingleChildScrollView(
            child: FutureBuilder(
              future: Total,
              builder:
              (context, snapshot) {
                if(snapshot.hasData){
                  var myData = snapshot.data;
                  List<double> measureList = getMeasure(double.tryParse(dbRiv.getTotalAmountByKart(myData!))!, double.tryParse(dbRiv.getTotalAmountByNakit(myData!))!, double.tryParse(dbRiv.getTotalAmountByDiger(myData!))!);
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * .05,vertical: size.height * .02),
                    child: SizedBox(
                      height: size.height * .8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: size.height * .05,
                            width: double.infinity,
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: renkler.arkaRenk,
                              borderRadius: BorderRadius.circular(11),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  time > 5 && time < 12
                                  ? "Günaydın! Umarız iyisinizdir."
                                  : time >= 12 && time < 18
                                    ? "iyi günler! Umarız iyisinizdir."
                                    : time >= 18 && time <= 23
                                      ? "iyi akşamlar! Umarız iyisinizdir."
                                      : "iyi geceler! Umarız iyisinizdir.",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.width * .65,
                            width: size.width * .65,
                            child: measureList[3] <= 0
                              ? Padding(
                              padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: renkler.arkaRenk.withOpacity(0.7),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(child: Text("Net Varlık Bulunamadı!")),
                                ),
                              )
                              :Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: renkler.arkaRenk.withOpacity(0.7),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                  DChartPie(
                                    strokeWidth: 1,
                                    showLabelLine: false,
                                    labelPosition: PieLabelPosition.outside,
                                    data: [
                                      {'domain': 'Banka', 'measure': measureList[0]},
                                      {'domain': 'Nakit', 'measure': measureList[1]},
                                      {'domain': 'Diğer', 'measure': measureList[2]},
                                    ],
                                    fillColor: (pieData, index) {
                                      return colorsList[index!];
                                    },
                                    donutWidth: 22,
                                  ),
                                  Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        TextMod("TOPLAM",Colors.black, 17),
                                        SizedBox(height: size.width * .06),
                                        TextMod("${measureList[3]} ${readSettingsRiv.Prefix}",Colors.black, 22),
                                      ],
                                    ),
                                  ),
                                ]
                              ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: size.width * .01),
                                    height: size.width * .02,
                                    width: size.width * .02,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFF5ECB9),
                                      shape: BoxShape.circle
                                    ),
                                  ),
                                  SizedBox(width: size.width * .02),
                                  Text("Banka")
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: size.width * .01),
                                    height: size.width * .02,
                                    width: size.width * .02,
                                    decoration: const BoxDecoration(
                                        color: Color(0xFFF9D1AC),
                                        shape: BoxShape.circle
                                    ),
                                  ),
                                  SizedBox(width: size.width * .02),
                                  Text("Nakit")
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: size.width * .01),
                                    height: size.width * .02,
                                    width: size.width * .02,
                                    decoration: const BoxDecoration(
                                        color: Color(0xFFF9ACAC),
                                        shape: BoxShape.circle
                                    ),
                                  ),
                                  SizedBox(width: size.width * .02),
                                  Text("Diğer")
                                ],
                              ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: renkler.sariRenk,
                            thickness: 2,
                          ),
                          Text("VARLIKLAR"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              assetBox(context, ref, "Banka" , dbRiv.getTotalAmountByKart(myData!)),
                              assetBox(context, ref, "Nakit" , dbRiv.getTotalAmountByNakit(myData!)),
                              assetBox(context, ref, "Diğer" , dbRiv.getTotalAmountByDiger(myData!)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        opaque: false, //sayfa saydam olması için
                                        transitionDuration: const Duration(milliseconds: 1),
                                        pageBuilder: (context, animation, nextanim) => const addAssets(),
                                        reverseTransitionDuration: const Duration(milliseconds: 1),
                                        transitionsBuilder: (context, animation, nexttanim, child) {
                                        return FadeTransition(
                                          opacity: animation,
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: FittedBox(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: size.height * .01, horizontal: size.width *.03),
                                    decoration: BoxDecoration(
                                      color: renkler.koyuuRenk,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 3,
                                          spreadRadius: 1
                                        )
                                      ]
                                    ),
                                    child: Row(
                                      children: const [
                                        Text(
                                            "Varlık Ekle",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Icon(
                                            Icons.add,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }else{
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        )
    );
  }
  List<Color> colorsList = [
    Color(0xFFF5ECB9),
    Color(0xFFF9D1AC),
    Color(0xFFF9ACAC),
  ];


  Widget assetBox(BuildContext context,WidgetRef ref, String title, String amaount ) {
    var size = MediaQuery.of(context).size;
    var readSettings = ref.read(settingsRiverpod);
    var renkkler = CustomColors();
    IconData ?myIcon ;
    if(title == "Banka") {
      myIcon = Icons.credit_card;
    }else if(title == "Nakit"){
      myIcon = Icons.wallet;
    }else{
      myIcon = Icons.animation_outlined;
    }
    return Container(
      height: size.height * .13,
      width: size.width * .25,
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 1,
            spreadRadius: 2,
          )
        ],
        color: renkkler.arkaRenk,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
              myIcon,
            size: 26,
          ),
          Text(title),
          Text("${amaount} ${readSettings.Prefix}"),
        ],
      ),
    );
  }
}
/*

 */
