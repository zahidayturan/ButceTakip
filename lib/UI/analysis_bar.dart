import 'package:butcekontrol/classes/language.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/models/spend_info.dart';
import 'package:butcekontrol/pages/more/assets_page.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:butcekontrol/utils/db_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnalysisBar extends ConsumerStatefulWidget {
  const AnalysisBar({Key? key}) : super(key: key);
  @override
  ConsumerState<AnalysisBar> createState() => _AnalysisBar();
}

class _AnalysisBar extends ConsumerState<AnalysisBar> {

  @override
  Widget build(BuildContext context) {
    var readSettings = ref.read(settingsRiverpod);
    var readdb = ref.read(databaseRiverpod);
    var size = MediaQuery.of(context).size;
    CustomColors renkler = CustomColors();
    return FutureBuilder<Map<String, dynamic>>(
        future: readdb.myMethod(ref),
        builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var items = snapshot.data!['items'];
          return Directionality(
            textDirection: TextDirection.ltr,
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Container(
                constraints: const BoxConstraints(
                  maxHeight: double.infinity, //container in boyutunu içindekiler belirliyor.
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 3),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              color: renkler.yesilRenk,
                            ),
                            height: 62,
                            width: 6,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              SizedBox(
                                width: size.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      translation(context).monthlyIncome,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        height: 1,
                                        fontSize: 14 ,
                                        fontFamily: 'Nexa3',
                                        color: Theme.of(context).canvasColor),
                                    ),
                                    Text(
                                      "Toplam",
                                      style: TextStyle(
                                        height: 2,
                                        fontSize: 14,
                                        fontFamily: 'Nexa3',
                                        color: Theme.of(context).canvasColor
                                      ),
                                    ),
                                    Text(
                                      translation(context).monthlyExpenses,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        height: 1,
                                        fontSize: 14 ,
                                        fontFamily: 'Nexa3',
                                        color: Theme.of(context).canvasColor),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 18,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Directionality(
                                      textDirection: readSettings.localChanger() == const Locale("ar") ? TextDirection.rtl : TextDirection.ltr,
                                      child: Expanded(
                                        flex: 1,
                                        child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Tooltip(
                                            message: "${readdb.getTotalAmountPositive(items)[1]} ${readSettings.prefixSymbol}",
                                            triggerMode: TooltipTriggerMode.tap,
                                            showDuration: const Duration(seconds: 2),
                                            textStyle: TextStyle(
                                                fontSize: 16,
                                                color: renkler.arkaRenk,
                                                fontFamily: 'TL',
                                                fontWeight: FontWeight.bold,
                                                height: 1),
                                            textAlign: TextAlign.center,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                const BorderRadius.all(Radius.circular(10)),
                                                color: renkler.yesilRenk),
                                            child: FittedBox(
                                              child: RichText(
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                      text: readdb.getTotalAmountPositive(items)[0],
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'Nexa3',
                                                        color: renkler.yesilRenk,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: readSettings.prefixSymbol,
                                                      style: TextStyle(
                                                        fontFamily: 'TL',
                                                        height: 1,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w600,
                                                        color: renkler.yesilRenk,
                                                      ),
                                                    ),
                                                  ])),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ), // gelir bilgisi
                                    Directionality(
                                      textDirection: readSettings.localChanger() == const Locale("ar") ? TextDirection.rtl : TextDirection.ltr,
                                      child: Expanded(
                                        flex: 1,
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Tooltip(
                                            message: "${readdb.getTotalAmount(items)[1]} ${readSettings.prefixSymbol}",
                                            triggerMode: TooltipTriggerMode.tap,
                                            showDuration: const Duration(seconds: 2),
                                            textStyle: TextStyle(
                                                fontSize: 16,
                                                color: renkler.koyuuRenk,
                                                fontFamily: 'TL',
                                                fontWeight: FontWeight.bold,
                                                height: 1),
                                            textAlign: TextAlign.center,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                const BorderRadius.all(Radius.circular(10)),
                                                color: Theme.of(context).disabledColor),
                                            child: FittedBox(
                                              child :   Directionality(
                                                textDirection: readSettings.Language == "العربية" ? TextDirection.rtl : TextDirection.ltr,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      readdb.getTotalAmount(items)[0],
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'Nexa3',
                                                        color: Theme.of(context).canvasColor,
                                                      ),
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      textDirection: TextDirection.ltr,
                                                    ),
                                                    Text(
                                                      readSettings.prefixSymbol!,
                                                      style: TextStyle(
                                                        height: 1,
                                                        fontFamily: 'TL',
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w600,
                                                        color: Theme.of(context).canvasColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ), // toplam bilgisi
                                    Directionality(
                                      textDirection: readSettings.localChanger() == const Locale("ar") ? TextDirection.rtl : TextDirection.ltr,
                                      child: Expanded(
                                        flex: 1,
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: Tooltip(
                                            message: "${readdb.getTotalAmountNegative(items)[1]} ${readSettings.prefixSymbol}",
                                            triggerMode: TooltipTriggerMode.tap,
                                            showDuration: const Duration(seconds: 2),
                                            textStyle: TextStyle(
                                                fontSize: 16,
                                                color: renkler.arkaRenk,
                                                fontFamily: 'TL',
                                                fontWeight: FontWeight.bold,
                                                height: 1),
                                            textAlign: TextAlign.center,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                const BorderRadius.all(Radius.circular(10)),
                                                color: renkler.kirmiziRenk),
                                            child: FittedBox(
                                              child: RichText(
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                      text: readdb
                                                          .getTotalAmountNegative(items)[0],
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'Nexa3',
                                                        color: renkler.kirmiziRenk,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: readSettings.prefixSymbol,
                                                      style: TextStyle(
                                                        height: 1,
                                                        fontFamily: 'TL',
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w600,
                                                        color: renkler.kirmiziRenk,
                                                      ),
                                                    ),
                                                  ])),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ), // gider bilgisi
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 3),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  topLeft: Radius.circular(10)),
                              color: renkler.kirmiziRenk,
                            ),
                            height: 62,
                            width: 6,
                          ),
                        ),
                      ],
                    ),
                    FutureBuilder(
                      future: SQLHelper.getItems(),
                      builder: (context, snapshot) {
                        if(snapshot.hasData){
                          var data = snapshot.data;
                          return analysisData(ref, items, data);
                        }else{
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      );
  }
  double getAssetsApi(WidgetRef ref, List<SpendInfo> ?data)  { //Varlıklarım sayfasından Toplam verisini çekiyor.
    return (double.parse(ref.read(databaseRiverpod).getTotalAmountByDiger(data!)) +
        double.parse(ref.read(databaseRiverpod).getTotalAmountByKart(data)) +
        double.parse(ref.read(databaseRiverpod).getTotalAmountByNakit(data)));
  }
  int foundMaxdayinMoth (){ //ayın kaç gün olduğunu buluyor.
    DateTime now = DateTime.now();
    DateTime firstDayOfNextMonth = DateTime(now.year, now.month + 1, 1);
    DateTime lastDayOfMonth = firstDayOfNextMonth.subtract(Duration(days: 1));
    return lastDayOfMonth.day;
  }
  Widget analysisData(WidgetRef ref, var items, List<SpendInfo>? data) {
    var readdb = ref.read(databaseRiverpod);
    double income = double.parse(readdb.getTotalAmountPositive(items)[0]); //Aylık Gelir
    double expensive = double.parse(readdb.getTotalAmountNegative(items)[0]); //Aylık Gider
    double total = double.parse(readdb.getTotalAmount(items)[0]); //Aylık Toplam fark
    DateTime dateTime = DateTime.now();
    var user = FirebaseAuth.instance.currentUser;
    String message = "Merhabalar  ${user?.displayName ?? "Efendim"} " ;

    double dailySpend = (total / (foundMaxdayinMoth() - dateTime.day)) ; //Ayın kalanında harcanması gereken günlük miktar.
    double assetTotal = getAssetsApi(ref, data); //Varlıklarımdan veri çekiyor.
    double montlyincome =  income / foundMaxdayinMoth(); //Aylık normal geliri ile harcaması gereken tutar.
    //var a = SQLHelper.SQLEntry("SELECT * FROM spendinfo WHERE operationType == 'Gelir' AND (category == Burs OR category == Maaş)");
    if(total > 0){
      message += "Aylık Gelir Gider durumunuzunun + bakiyede olduğunu görebiliyorum. " ;
      if(dailySpend >= montlyincome *.5 && dailySpend < montlyincome){
        message += "";
      }else if (dailySpend > montlyincome && dailySpend <= montlyincome * 1.4){
        message += "Gayet Güzel bir oran var. ";
      }else if (dailySpend > montlyincome * 1.4){
        message += "Harika ! 🎉🥳🎉";
      }else if(dailySpend < montlyincome * .5){
        message += "Biraz bütçenizi idareli harcamanızı öneririz.🙄.";
      }else{
        message += "error no found statement";
      }
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
      message += "\n\nSon Gösterilme tarihi => ${ref.read(settingsRiverpod).assistantLastShowDate.toString().split(" "[0])}";
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
        assetTotal <= 0
        ?GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
            ref.read(botomNavBarRiverpod).setCurrentindex(4);
            Navigator.push(context, PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 1),
              pageBuilder: (context, animation, nextanim) => assetsPage(),
              reverseTransitionDuration: Duration(milliseconds: 1),
              transitionsBuilder: (context, animation, nexttanim, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
            );
            ref.read(settingsRiverpod).setAssistantLastShowDate;
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
            ref.read(settingsRiverpod).setAssistantLastShowDate;
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
