import 'package:butcekontrol/UI/spend_detail.dart';
import 'package:butcekontrol/classes/language.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/models/Data.dart';
import 'package:butcekontrol/models/spend_info.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:butcekontrol/utils/textConverter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' as intl;
import 'package:syncfusion_flutter_charts/charts.dart';



class CategoryInfo extends ConsumerWidget {
  const CategoryInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CustomColors renkler = CustomColors();
    return Container(
      color: renkler.koyuuRenk,
      child: const SafeArea(
        child: Scaffold(
          bottomNavigationBar: null,
          //backgroundColor: renkler.arkaRenk,
          appBar: AppbarCategoryInfo(),
          body: CategoryInfoBody(),
        ),
      ),
    );
  }
}

class CategoryInfoBody extends ConsumerStatefulWidget {
  const CategoryInfoBody({Key? key}) : super(key: key);
  @override
  ConsumerState<CategoryInfoBody> createState() => _CategoryInfoBody();
}

class _CategoryInfoBody extends ConsumerState<CategoryInfoBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 6,
        ),
        list(context),
        dayDetailsGuide(context),
      ],
    );
  }
  List<Data> getDataSet(String mod, List<SpendInfo> items){
    List<Data> dataSetList = [];
    Map<String, double> takvim  = {};
    if(mod == "Aylık"){
      items.forEach((item) {
        if(item.operationDay != null){
          if(takvim.containsKey(item.operationDay)){
            takvim[item.operationDay!] = takvim[item.operationDay!]! + item.realAmount! ;
          }else{
            takvim[item.operationDay!] = item.realAmount!;
          }
        }
      });
      for(int i = 0 ; i < 31 ; i++){
        if(takvim[(i + 1).toString()] != null){
          dataSetList.add(Data((i + 1).toString(), takvim[(i+1).toString()]));
        }else{
          dataSetList.add(Data((i + 1).toString(), 0));
        }
      }


      //buraya farklı modları yazmalısın.
    }else if(mod == "Haftalık" || mod == "Periyot"){
      String? month = items.first.operationMonth;
      items.forEach((item) {
        if(item.operationDay != null && item.operationMonth == month){
          if(takvim.containsKey(item.operationDay)){
            takvim[item.operationDay!] = takvim[item.operationDay!]! + item.realAmount! ;
          }else{
            takvim[item.operationDay!] = item.realAmount!;
          }
        }else if(item.operationDay != null){
          if(takvim.containsKey(("${item.operationMonth!}/${item.operationDay!}").toString())){
            takvim[("${item.operationMonth!}/${item.operationDay!}")] = takvim[(item.operationMonth! + "/" + item.operationDay!)]! + item.realAmount! ;
          }else{
            takvim[("${item.operationMonth!}/${item.operationDay!}")] = item.realAmount!;
          }
        }
      });
      print(takvim);

      List<String> a = takvim.keys.toList();
      for(int i = 0 ; i < a.length ; i++ ){
        if(takvim[a[i]] != null){
          dataSetList.add(Data(a[i], takvim[a[i]]));
        }else{
          dataSetList.add(Data(a[i], 0));
        }
      }
    }else{ ///YIllık
      items.forEach((item) {
        if(item.operationMonth != null){
          if(takvim.containsKey(item.operationMonth)){
            takvim[item.operationMonth!] = takvim[item.operationMonth!]! + item.realAmount! ;
          }else{
            takvim[item.operationMonth!] = item.realAmount!;
          }
        }
      });
      List<String> aylar = ["Ocak", 'Şubat', 'Mart', 'Nisan' , "Mayıs" ,'Haziran', 'Temmuz', 'Ağustos', "Eylül", 'Ekim', "Kasım", "Aralık"] ;
      for(int i = 0 ; i < aylar.length ; i++ ){
        if(takvim[(i + 1).toString()] != null){
          dataSetList.add(Data(aylar[i], takvim[(i+1).toString()]));
        }else{
          dataSetList.add(Data(aylar[i], 0));
        }
      }
    }
    return dataSetList;
  }
  Widget list(BuildContext context) {
    var readCategoryInfo = ref.read(categoryInfoRiverpod);
    var readDailyInfo = ref.read(dailyInfoRiverpod);
    var size = MediaQuery.of(context).size;
    Future<List<SpendInfo>> myList = readCategoryInfo.myMethod2();
    CustomColors renkler = CustomColors();
    return FutureBuilder(
        future: myList,
        builder: (context, AsyncSnapshot<List<SpendInfo>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).disabledColor,
                backgroundColor: Theme.of(context).highlightColor,
              ),
            );
          }
          List<SpendInfo> item = snapshot.data!; // !
          return Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  readCategoryInfo.getDataType() != "Günlük" && item.length != 1
                  ? SizedBox(
                    height: 250,
                   child: SfCartesianChart(
                     /*
                     title: ChartTitle(
                       text: "${readCategoryInfo.getDataType()} Grafik",
                       alignment: ChartAlignment.center,
                       textStyle: TextStyle(
                         color: Theme.of(context).canvasColor,
                         fontFamily: "Nexa3"
                       )
                     ),
                      */
                     borderColor: Colors.transparent,
                     primaryXAxis: CategoryAxis(
                       labelRotation: 45,
                       majorGridLines: const MajorGridLines(width: 0), // Ana grid çizgilerini gizler
                       minorGridLines: const MinorGridLines(width: 0), // Alt grid çizgilerini gizler
                       axisLine: const AxisLine(
                         color: Colors.transparent,
                       ),
                     ),
                     primaryYAxis: NumericAxis(
                        minorGridLines: const MinorGridLines(width: 0),
                     ),
                     tooltipBehavior: TooltipBehavior( //Grafiğe tıklanınca çıkan bilgi ekranını sağlıyor.
                       enable: true,
                       header: "Bilgi",
                       color: Theme.of(context).highlightColor,
                       borderColor: Colors.white,
                       textStyle: const TextStyle(
                         color: Colors.white
                       ),
                       duration: 1600,
                     ),

                     series: <ChartSeries>[

                       SplineAreaSeries<Data, String>(
                          dataSource:  getDataSet(readCategoryInfo.getDataType(), item),
                           xValueMapper:(Data data, _) => data.x,
                           yValueMapper: (Data data, _) => data.y,
                         gradient: LinearGradient(
                           begin: Alignment.topCenter,
                           end: Alignment.bottomCenter,
                           colors: [Theme.of(context).disabledColor , Theme.of(context).primaryColor ],
                         ),
                         dataLabelSettings: const DataLabelSettings(
                           isVisible: false,
                           angle: 45,
                           alignment: ChartAlignment.far,
                           offset: Offset(0, 0),
                           labelAlignment: ChartDataLabelAlignment.middle
                         ),
                       ),
                       /*
                       SplineSeries<Data, String>(
                         dataSource: ,
                         color: Colors.white,
                         xValueMapper:(Data data, _) => data.x,
                         yValueMapper: (Data data, _) => data.y,
                       ),
                        */
                       LineSeries<Data, String>(
                          dataSource: getDataSet(readCategoryInfo.getDataType(), item) ,

                          dataLabelSettings:  DataLabelSettings(
                              builder: (data, point, series, pointIndex, seriesIndex) {
                                return Container(
                                  padding: const EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).highlightColor, // Customize the background color as needed
                                    borderRadius: BorderRadius.circular(8.0), // Customize the border radius as needed
                                  ),
                                  child: Text(
                                    data.y.toString(),
                                    style: const TextStyle(
                                      color: Colors.white, // Customize the text color as needed
                                    ),
                                  ),
                                );
                              },
                              isVisible: false,
                              angle: 45,
                              alignment: ChartAlignment.far,
                              offset: const Offset(0, 0),
                              color: Colors.pink,
                              labelAlignment: ChartDataLabelAlignment.middle
                          ),
                          color: Theme.of(context).secondaryHeaderColor,
                          width: 2,
                          markerSettings: const MarkerSettings(
                            isVisible: true,
                            width: 5,
                            height: 5,
                          ),
                          isVisible: true,
                          xValueMapper:(Data data, _) => data.x,
                          yValueMapper: (Data data, _) => data.y,
                       )
                     ],

                   ),
                  )
                  : SizedBox(
                    height: 40,
                    child: Center(
                      child: Text(translation(context).noEnoughDataForTheChart),
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 11.5,top: 4),
                                child: Container(
                                  width: 4,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(30)),
                                      color: snapshot.data!.length <= 12
                                          ? Theme.of(context).indicatorColor
                                          : Theme.of(context).canvasColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.fromSwatch(
                                  accentColor: Theme.of(context).disabledColor,
                                ),
                                scrollbarTheme: ScrollbarThemeData(
                                    thumbColor: MaterialStateProperty.all(
                                        Theme.of(context).dialogBackgroundColor))),
                            child: Scrollbar(
                              thumbVisibility: true,
                              scrollbarOrientation: ScrollbarOrientation.right,
                              interactive: true,
                              thickness: 7,
                              radius: const Radius.circular(15),
                              child: ListView.builder(
                                itemCount: item.length,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var readSettings = ref.read(settingsRiverpod);
                                  DateTime itemDate = DateTime(int.tryParse(item[index].operationYear!)!,int.tryParse(item[index].operationMonth!)!,int.tryParse(item[index].operationDay!)!);
                                  String formattedDate = intl.DateFormat(readSettings.dateFormat).format(itemDate);
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                         right: 15, top: 5, bottom: 5),
                                    child: InkWell(
                                      highlightColor: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(20),
                                      onTap: () {
                                        {
                                          readDailyInfo.setSpendDetail(item, index);
                                          ref.watch(databaseRiverpod).delete;
                                          showModalBottomSheet(
                                            isScrollControlled:true,
                                            context: context,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.vertical(
                                                    top: Radius.circular(15))),
                                            backgroundColor:
                                                const Color(0xff0D1C26),
                                            builder: (context) {
                                              // genel bilgi sekmesi açılıyor.
                                              return const SpendDetail();
                                            },
                                          ).then((value) {
                                            item.length == 1 ? Navigator.pop(context) : null;
                                          });
                                        }
                                      },
                                      child: SizedBox(
                                        height: 52,
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Theme.of(context).indicatorColor,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 3),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom: 4,left: 6,right: 6),
                                                      child: Icon(
                                                        Icons.remove_red_eye,
                                                        color:
                                                            item[index].operationType ==
                                                                    "Gider"
                                                                ? const Color(0xFFD91A2A)
                                                                : Theme.of(context).canvasColor,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Text(
                                                      formattedDate,
                                                      style: TextStyle(
                                                        fontFamily: 'Nexa3',
                                                        fontSize: 16,
                                                        height: 1,
                                                        color: Theme.of(context).canvasColor,
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    Padding(
                                                      padding: const EdgeInsets.only(
                                                          right: 8.0,left: 8),
                                                      child: item[index].operationType ==
                                                              "Gelir"
                                                          ? RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text:item[index].realAmount.toString(),style: TextStyle(
                                                              fontFamily: 'Nexa4',
                                                              fontSize: 16,
                                                                height: 1,
                                                                color: Theme.of(context).canvasColor
                                                            ),
                                                            ),
                                                            TextSpan(
                                                              text: readSettings.prefixSymbol,
                                                              style: TextStyle(
                                                                fontFamily: 'TL',
                                                                fontSize: 16,
                                                                height: 1,
                                                                fontWeight: FontWeight.w600,
                                                                  color: Theme.of(context).canvasColor
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ) : RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text:item[index].realAmount.toString(),style: TextStyle(
                                                              fontFamily: 'NEXA3',
                                                              fontSize: 17,
                                                              height: 1,
                                                              color: renkler.kirmiziRenk,
                                                            ),
                                                            ),
                                                            TextSpan(
                                                              text: readSettings.prefixSymbol,
                                                              style: TextStyle(
                                                                fontFamily: 'TL',
                                                                fontSize: 17,
                                                                height: 1,
                                                                fontWeight: FontWeight.w600,
                                                                color: renkler.kirmiziRenk,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                item[index].note != "" ? Padding(
                                                  padding: const EdgeInsets.only(left: 8,right: 8,bottom: 2),
                                                  child: Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(
                                                      "${translation(context).note} ${item[index].note!}",overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 14,height: 1),),
                                                  ),
                                                ) : SizedBox(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: SizedBox(
                        width: size.width*0.98,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 15,
                              child: Padding(
                                padding: const EdgeInsets.only( right: 5),
                                child: Text(
                                  "${item.length}",
                                  style: TextStyle(color: Theme.of(context).dialogBackgroundColor,fontSize: 18,fontFamily: 'NEXA3'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
          );
        });
  }
  Widget dayDetailsGuide(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var readSettings = ref.read(settingsRiverpod);
    var read = ref.read(categoryInfoRiverpod);
    return FutureBuilder<double>(
      future: read.getTotalAmount(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          double data = snapshot.data!;
          return SizedBox(
            width: size.width * 0.9,
            height: size.height * 0.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FittedBox(
                  child: Text(translation(context).totalAmountStatistics,style: TextStyle(
                    height: 1,
                    fontFamily: 'NEXA3',
                    fontSize: 17,
                    color: Theme.of(context).canvasColor,
                  ),),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Theme.of(context).disabledColor,
                  ),
                  height: 26,
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10,left: 10),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: data.toStringAsFixed(2),style: const TextStyle(
                                fontFamily: 'NEXA3',
                                fontSize: 17,
                                color: Color(0xff0D1C26),
                              ),
                              ),
                              TextSpan(
                                text: readSettings.prefixSymbol,
                                style: const TextStyle(
                                  fontFamily: 'TL',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }



}

class AppbarCategoryInfo extends ConsumerWidget implements PreferredSizeWidget {
  const AppbarCategoryInfo({Key? key}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(80);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var readSettings = ref.read(settingsRiverpod);
    var read = ref.read(categoryInfoRiverpod);
    var size = MediaQuery.of(context).size;
    CustomColors renkler = CustomColors();
    List myCategory = read.getCategory(context);
    List myDate = read.getDate(context);
    print(myDate);
    String textConverter(){
      String text = '';
      for(int i =0 ; i<myDate.length ; i++){
        text = '$text ${myDate[i].toString()}';
      }
      return text;
    }
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 66,
              width: size.width - 80,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: readSettings.localChanger() == const Locale("ar") ?
                  const BorderRadius.horizontal(
                    left: Radius.circular(15),
                  ) :
                  const BorderRadius.horizontal(
                    right: Radius.circular(15),
                  ),
                  color: Theme.of(context).highlightColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                          padding: const EdgeInsets.only(left: 4,right: 4,bottom: 4),
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: myCategory[2] == "Gider" ? renkler.kirmiziRenk :renkler.yesilRenk
                            ),
                          ),
                        ),
                          Text(
                            '${Converter().textConverterFromDB(myCategory[0], context, 0)} ',
                            style: TextStyle(
                              color: renkler.yaziRenk,
                              fontFamily: "NEXA3",
                              height: 1,
                              fontSize: 19,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            ' ${myCategory[1]}',
                            style: TextStyle(
                              color: renkler.yaziRenk,
                              fontFamily: "NEXA3",
                              height: 1,
                              fontSize: 19,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      textConverter(),
                      style: TextStyle(
                        color: renkler.yaziRenk,
                        height: 1,
                        fontFamily: "NEXA3",
                        fontSize: 13,
                      ),
                    ),
                  ],
                ), /// başlıktaki yazılar
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0, left: 15,),
              child: SizedBox(
                width: 40,
                height: 40,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Theme.of(context).highlightColor,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: IconButton(
                    highlightColor: Theme.of(context).primaryColor,
                    splashColor:Theme.of(context).primaryColor,
                    icon:  Image.asset(
                      "assets/icons/remove.png",
                      height: 16,
                      width: 16,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ), /// çarpı işareti
          ],
        ),
      ),
    );
  }
}
