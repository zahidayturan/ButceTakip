import 'package:butcekontrol/UI/analysis_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../models/Data.dart';
import '../models/spend_info.dart';
import '../riverpod_management.dart';

class myAssistant extends ConsumerStatefulWidget {
  const myAssistant({Key? key}) : super(key: key);

  @override
  ConsumerState<myAssistant> createState() => _myAssistant();
}

class _myAssistant extends ConsumerState<myAssistant> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var readCategoryInfo = ref.read(categoryInfoRiverpod);
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
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [Theme.of(context).disabledColor.withOpacity(0.5) , Theme.of(context).primaryColor.withOpacity(0.2) ],
                                      ),
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Text(
                                    "ANALİZ",
                                    style: TextStyle(
                                      color: Theme.of(context).canvasColor,
                                      fontFamily: 'Nexa4',
                                      fontWeight: FontWeight.w900,
                                      height: 1,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
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
                                      "Merhaba Ben BütçeTakip Asistanınız !"
                                      "Aylık harcamalarınıza bir bakalım.",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Theme.of(context).canvasColor,
                                          fontFamily: "Nexa4",
                                          fontSize: 11,
                                          height: 1
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10,),
                              AnalysisBar(),
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
}
