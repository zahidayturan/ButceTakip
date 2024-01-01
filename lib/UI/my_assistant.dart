import 'package:butcekontrol/UI/general_info.dart';
import 'package:butcekontrol/UI/spend_detail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:butcekontrol/UI/analysis_bar.dart';
import 'package:butcekontrol/classes/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../constans/material_color.dart';
import '../models/Data.dart';
import '../models/spend_info.dart';
import '../pages/more/assets_page.dart';
import '../riverpod_management.dart';
import '../utils/db_helper.dart';

class myAssistant extends ConsumerStatefulWidget {
  const myAssistant({Key? key}) : super(key: key);

  @override
  ConsumerState<myAssistant> createState() => _myAssistant();
}

class _myAssistant extends ConsumerState<myAssistant> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var readCategoryInfo = ref.read(categoryInfoRiverpod);
    var readDb = ref.read(databaseRiverpod);
    var readSettings = ref.read(settingsRiverpod);
    Future<List<SpendInfo>> myList = readCategoryInfo.myMethod2(key: "a");
    return WillPopScope(
      onWillPop: () async {
        ref.read(settingsRiverpod).setAssistantLastShowDate();
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              ref.read(settingsRiverpod).setAssistantLastShowDate();
            },
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
              ),
              child: Center(
                child: GestureDetector(
                  onTap:() {

                  },
                  child: FittedBox(
                    child: Container( //boyut
                      width: 330,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          FutureBuilder(
                            future: myList,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<SpendInfo> item = snapshot.data!; // !
                                return SfCartesianChart(
                                  borderColor: Colors.transparent,
                                  borderWidth: 0,
                                  plotAreaBorderWidth: 0,
                                  primaryXAxis: CategoryAxis(
                                    labelRotation: 45,
                                    isVisible: false,
                                    majorGridLines: const MajorGridLines(width: 0), // Ana grid çizgilerini gizler
                                    minorGridLines: const MinorGridLines(width: 0), // Alt grid çizgilerini gizler
                                    axisLine: const AxisLine(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  primaryYAxis: NumericAxis(
                                    minorGridLines: const MinorGridLines(width: 0),
                                    isVisible: false, // Y ekseni görünmez yapılıyor
                                  ),
                                  series: <ChartSeries>[
                                    SplineAreaSeries<Data, String>(
                                      dataSource:  getDataSet(readCategoryInfo.getDataType(), item),
                                      xValueMapper:(Data data, _) => data.x,
                                      yValueMapper: (Data data, _) => data.y,
                                      /*
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [Theme.of(context).disabledColor.withOpacity(0.5) , Theme.of(context).primaryColor.withOpacity(0.2) ],
                                      ),

                                       */
                                      dataLabelSettings: const DataLabelSettings(
                                          isVisible: false,
                                          angle: 45,
                                          alignment: ChartAlignment.far,
                                          offset: Offset(0, 0),
                                          labelAlignment: ChartDataLabelAlignment.middle
                                      ),
                                    ),
                                  ],
                                );
                              }else{
                                return Center(

                                );
                              }
                            },
                          ),
                          Column (
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Text(
                                    translation(context).analysis,
                                    style: TextStyle(
                                      color: Theme.of(context).canvasColor,
                                      fontFamily: 'Nexa4',
                                      fontWeight: FontWeight.w900,
                                      height: 1,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 10, left: 10),
                                    width: 32,
                                    height: 32,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).highlightColor,
                                        borderRadius: BorderRadius.circular(36),
                                      ),
                                      child: IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          ref.read(settingsRiverpod).setAssistantLastShowDate();
                                          Navigator.of(context).pop();
                                        },
                                        icon: Image.asset(
                                          "assets/icons/remove.png",
                                          color: Color(0xffF2F2F2),
                                          height: 18,
                                          width: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/image/noInfo5.png",
                                    width: 75,
                                    height: 75,
                                  ),
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      "${translation(context).iAmYourBudgetWiseAssistant} ${translation(context).lookAtYourMonthlyExpenses}",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Theme.of(context).canvasColor,
                                          fontFamily: "Nexa4",
                                          fontSize: readSettings.Language == "العربية" ? 16 : 13,
                                          height: 1
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10,),
                              const Generalinfo(isAssistantMode: true),
                              FutureBuilder(
                                future: readDb.yourMethod(ref, DateTime.now().month, DateTime.now().year),
                                builder: (context, snapshot) {
                                  if(snapshot.hasData){
                                    var data = snapshot.data as Map<String, List<SpendInfo>>;
                                    return analysisData(ref, data);
                                  }else{
                                    return const SizedBox(
                                      height: 250,
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ]
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  int foundMaxdayinMoth (){ //ayın kaç gün olduğunu buluyor.
    DateTime now = DateTime.now();
    DateTime firstDayOfNextMonth = DateTime(now.year, now.month + 1, 1);
    DateTime lastDayOfMonth = firstDayOfNextMonth.subtract(Duration(days: 1));
    return lastDayOfMonth.day;
  }

  List<Data> getDataSet(String mod, List<SpendInfo> items){
    List<Data> dataSetList = [];
    Map<String, double> takvim  = {};
    items.forEach((item) {
      if(item.operationDay != null){
        if(takvim.containsKey(item.operationDay)){
          takvim[item.operationDay!] = takvim[item.operationDay!]! + item.realAmount! ;
        }else{
          takvim[item.operationDay!] = item.realAmount!;
        }
      }
    });
    for(int i = 0 ; i < foundMaxdayinMoth() ; i++){
      if(takvim[(i + 1).toString()] != null){
        dataSetList.add(Data((i + 1).toString(), takvim[(i+1).toString()]));
      }else{
        dataSetList.add(Data((i + 1).toString(), 0));
      }
    }
    return dataSetList;
  }

  double getAssetsApi(WidgetRef ref, List<SpendInfo> ?data)  { //Varlıklarım sayfasından Toplam verisini çekiyor.
    return (double.parse(ref.read(databaseRiverpod).getTotalAmountByDiger(data!)) +
        double.parse(ref.read(databaseRiverpod).getTotalAmountByKart(data)) +
        double.parse(ref.read(databaseRiverpod).getTotalAmountByNakit(data)));
  }

  Widget analysisData(WidgetRef ref, Map<String, List> data) {
    var readdb = ref.read(databaseRiverpod);
    var settingRead = ref.read(settingsRiverpod);

    List<SpendInfo> items = data["items"] as List<SpendInfo>;
    List<SpendInfo> allItems = data["allItems"] as List<SpendInfo>;
    DateTime dateTime = DateTime.now();
    double income = double.parse(readdb.getTotalAmountPositive(items)[0]); //Aylık Gelir
    double expensive = double.parse(readdb.getTotalAmountNegative(items)[0]); //Aylık Gider
    double total = double.parse(readdb.getTotalAmount(items)[0]); //Aylık Toplam fark
    var user = FirebaseAuth.instance.currentUser;
    String message = "Merhabalar  ${user?.displayName ?? "Efendim"} " ;

    double dailySpend = (total / (foundMaxdayinMoth() - dateTime.day)) ; //Ayın kalanında harcanması gereken günlük miktar.
    double assetTotal = getAssetsApi(ref, allItems); //Varlıklarımdan veri çekiyor.
    double montlyincome =  income / foundMaxdayinMoth(); //Aylık normal geliri ile harcaması gereken tutar.
    double percentPeriod = expensive * 100 / income ; // Aylık gelirinin yüzdesel harcamasını veriyor.
    int remainderDay = foundMaxdayinMoth() - DateTime.now().day ; // Ay bitimine kalan günü verir.

    if(total > 0){
      message += "Aylık Gelir Gider durumunuzunun + bakiyede olduğunu görebiliyorum. " ;
      if(dailySpend >= montlyincome *.5 && dailySpend < montlyincome){
        message += "Böyle Devam ";
      }else if (dailySpend > montlyincome && dailySpend <= montlyincome * 1.4){
        message += "Gayet Güzel bir oran var. ";
      }else if (dailySpend > montlyincome * 1.4){
        message += "Harika ! 🎉🥳🎉";
      }else if(dailySpend < montlyincome * .5){
        message += "Biraz bütçenizi idareli harcamanızı öneririz 🙄. ";
      }else{
        message += "error no found statement";
      }
      message += "Aylık Gelirinizin %${percentPeriod.toStringAsFixed(0)}' ini harcamışsınız. ";
      message += "Ay bitimine $remainderDay gün kaldı. ";
      message += "Ay sonuna ortalama günlük ${dailySpend.toStringAsFixed(2)} ${ref.read(settingsRiverpod).Prefix} harcayarak ulaşabilirsiniz. ";
    }else if(total == 0 ){
      message += "Aylık Gelir ve Gider durumunuz eşit. ";
      if(assetTotal > 0){
        message += "Neyse ki halihazırda Varlıklarınız da Paranız mevcut. ";
      }else{
        message += "🥹🥹🥹 ";
      }
    }else{
      message += "Aylık Gelir Gider durumunuzun maalesef - bakiyede olduğunu görüntülüyorum. ";
      if(assetTotal > 0){
        message += "neyse ki ";
      }
    }
    if(assetTotal <= 0){ ///varlık kontrolu
      message += "\nMaalesef Varlığınız bulunmuyor. Dilerseniz Varlık sayfasını düzenleyebilirsiniz. ";
    }else{
      message += "\n\nVarlıklarım Sayfasında toplam ${assetTotal.toStringAsFixed(2)} ${ref.read(settingsRiverpod).Prefix} paranız bulunmaktadır. ";
    }
    if(ref.read(settingsRiverpod).assistantLastShowDate != null){
      message += "\n\nSon Gösterilme tarihi => ${ref.read(settingsRiverpod).assistantLastShowDate.toString().split(" ")[0]}";
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 8),
          child: Text(
            message.toString(),
            style: const TextStyle(
                height: 1,
                fontSize: 12,
                fontFamily: "Nexa4"
            ),
            textAlign: TextAlign.justify,
          ),
        ),
        income == 0
            ?SizedBox(width: 1)
            :Column(
          children: [
            SizedBox(
              height: 70,
              child: Column(
                children: [
                  const Text(
                    "Bu aydaki Gelir Tipindeki işlemler",
                    style: TextStyle(
                      fontFamily: "Nexa3",
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: FutureBuilder(
                      future: SQLHelper.SQLEntry('SELECT * FROM spendinfo WHERE (operationType == "Gelir" AND operationMonth == ${DateTime.now().month})'),
                      builder: (context, snapshot) {
                        if(snapshot.hasData){
                          List<SpendInfo>? data = snapshot.data;
                          return ListView.builder(
                            itemCount: data!.length,
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  if(data[index].operationDay != "null"){
                                    ref.read(dailyInfoRiverpod).setSpendDetail([data[index]], 0);
                                    showModalBottomSheet(
                                      isScrollControlled:true,
                                      context: context,
                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
                                      backgroundColor:  CustomColors().koyuuRenk,
                                      builder: (context) {
                                        //ref.watch(databaseRiverpod).updatest;
                                        // genel bilgi sekmesi açılıyor.
                                        return const SpendDetail();
                                      },
                                    );
                                  }else{

                                  }
                                },
                                child: Container(
                                  width: 170,
                                  margin: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: settingRead.DarkMode == 1 ? [
                                      BoxShadow(
                                        color: Colors.black54.withOpacity(0.8),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(-1, 2),
                                      )
                                    ] : [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          spreadRadius: 0.5,
                                          blurRadius: 2,
                                          offset: const Offset(0, 2)
                                      )
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width : 6,
                                        height: 17,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF1A8E58),
                                          borderRadius: BorderRadius.horizontal(right: Radius.circular(11)),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Expanded(
                                              child: SizedBox(
                                                width : 160,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      data[index].operationDate.toString(),
                                                      overflow: TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontFamily: "Nexa3",
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                    RichText(
                                                        maxLines: 1,
                                                        text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                text:  data[index].realAmount.toString(),
                                                                style: TextStyle(
                                                                  overflow: TextOverflow.ellipsis,
                                                                  height: 1,
                                                                  fontSize: 13,
                                                                  color: Theme.of(context).canvasColor,
                                                                  fontFamily: "Nexa3",
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text: settingRead.prefixSymbol,
                                                                style: TextStyle(
                                                                  overflow: TextOverflow.ellipsis,
                                                                  height: 1,
                                                                  fontSize: 13,
                                                                  color: Theme.of(context).canvasColor,
                                                                  fontFamily: "TL",
                                                                ),
                                                              ),
                                                            ]
                                                        )
                                                    ),
                                                  ],
                                                ),
                                              )
                                          ),
                                          Expanded(
                                            child: SizedBox(
                                              width : 120,
                                              child: Text(
                                                data[index].note.toString(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style:const TextStyle(
                                                  fontFamily: "Nexa3",
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
                            },
                          );
                        }else{
                          return Container(
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
        assetTotal <= 0
            ?GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
            ref.read(botomNavBarRiverpod).setCurrentindex(4);
            Navigator.push(context, PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 1),
              pageBuilder: (context, animation, nextanim) => const assetsPage(),
              reverseTransitionDuration: Duration(milliseconds: 1),
              transitionsBuilder: (context, animation, nexttanim, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
            );
            settingRead.setAssistantLastShowDate;
          },
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              "Varlıklarım",
              style: TextStyle(
                  height: 1,
                  fontSize: 13,
                  color: Colors.white
              ),
            ),
          ),
        )
            :GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
            settingRead.setAssistantLastShowDate;
          },
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              "Anladım",
              style: TextStyle(
                  height: 1,
                  fontSize: 13,
                  color: Colors.white
              ),
            ),
          ),
        ),
      ],
    );
  }
}
