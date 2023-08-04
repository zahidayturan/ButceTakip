import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:butcekontrol/classes/language.dart';


class CalenderBka{

  List<String> years = [
    "2020",
    "2021",
    "2022",
    "2023",
    "2024",
    "2025",
    "2026",
    "2027",
    "2028",
    "2029",
    "2030"
  ];
}

class Generalinfo extends ConsumerWidget {
  //statelesswidget
  const Generalinfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> mounths = [
      translation(context).january,
      translation(context).february,
      translation(context).march,
      translation(context).april,
      translation(context).may,
      translation(context).june,
      translation(context).july,
      translation(context).august,
      translation(context).september,
      translation(context).october,
      translation(context).november,
      translation(context).december,
    ];

    var readhome = ref.read(homeRiverpod);
    var watchhome = ref.watch(homeRiverpod);
    var readdb = ref.read(databaseRiverpod);
    var size = MediaQuery.of(context).size;
    CustomColors renkler = CustomColors();
    watchhome.refrestst;
    int indexyear = watchhome.indexyear;
    int indexmounth = watchhome.indexmounth;
    CalenderBka calender = CalenderBka(); // aşağıdaki classı tanımladık.
    return StreamBuilder<Map<String, dynamic>>(
        stream: readdb.myMethod(),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          //var dailyTotals = snapshot.data!['dailyTotals'];
          var items = snapshot.data!['items'];
         return Directionality(
           textDirection: TextDirection.ltr, /// yönü sabit kılmak için kullanılmıştır soldan sağa
           child: Padding(
             padding: const EdgeInsets.only(top: 5),
             child: Container(
               constraints: const BoxConstraints(
                 maxHeight: double
                     .infinity, //container in boyutunu içindekiler belirliyor.
               ),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.end,
                 children: [
                   Container(
                     decoration: BoxDecoration(
                       borderRadius: const BorderRadius.only(
                           bottomRight: Radius.circular(10),
                           topRight: Radius.circular(10)),
                       color: renkler.yesilRenk,
                     ),
                     height: 62,
                     width: 7,
                   ),
                   SizedBox(width: 8),
                   Expanded(
                     child: Column(
                       children: [
                         SizedBox(
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             crossAxisAlignment: CrossAxisAlignment.end,
                             children: [
                               RichText(text: TextSpan(
                                 text: translation(context).monthlyIncome,
                                 style: TextStyle(
                                   height: 1,
                                     fontSize: 16,
                                     fontFamily: 'Nexa3',
                                     color: renkler.koyuuRenk),
                               ),
                                 textAlign: TextAlign.left,
                               ),
                               Stack(
                                 children: [
                                   Padding(
                                     padding: const EdgeInsets.only(top: 11,left: 18),
                                     child: Container(
                                       decoration: BoxDecoration(
                                           borderRadius: const BorderRadius.all(Radius.circular(20)),
                                           color: renkler.sariRenk
                                       ),
                                       width: 220,
                                       height: 26,
                                     ),
                                   ),
                                   Row(
                                     //Tarih bilgisini değiştirebilme
                                     children: [
                                       RotatedBox(
                                         quarterTurns: 1,
                                         child: IconButton(
                                           icon: Icon(
                                             Icons.expand_more_rounded,
                                             color: renkler.koyuuRenk,
                                             size: 34,
                                           ),
                                           alignment: Alignment.topCenter,
                                           padding: EdgeInsets.zero,
                                           onPressed: () {
                                             if (indexmounth > 0) {
                                               indexmounth -= 1;
                                             } else {
                                               if (indexyear != 0) {
                                                 indexyear -= 1;
                                                 indexmounth = 11;
                                               }
                                             }
                                             readhome.changeindex(indexmounth, indexyear);
                                             readdb.setMonthandYear(
                                                 (indexmounth + 1).toString(),
                                                 calender.years[indexyear]);
                                           },
                                         ),
                                       ),
                                       ClipRRect(
                                         // yuvarlıyorum ay değişimi barını
                                         borderRadius:
                                         const BorderRadius.all(Radius.circular(50)),
                                         child: Container(
                                           height: 32,
                                           width: 160,
                                           color: renkler.koyuuRenk,
                                           child: Padding(
                                             padding: const EdgeInsets.only(top: 5),
                                             child: Row(
                                               mainAxisAlignment: MainAxisAlignment.center,
                                               children: [
                                                 Text(
                                                   mounths[readhome.indexmounth],
                                                   style: const TextStyle(
                                                     color: Colors.white,
                                                     fontSize: 18,
                                                     fontFamily: 'Nexa3',
                                                   ),
                                                 ),
                                                 // Ay gösterge
                                                 const SizedBox(width: 6),
                                                 Text(
                                                   calender.years[readhome.indexyear],
                                                   style: const TextStyle(
                                                     color: Colors.white,
                                                     fontSize: 18,
                                                     fontFamily: 'Nexa4',
                                                   ),
                                                 ),
                                                 // Yıl gösterge
                                               ],
                                             ),
                                           ),
                                         ),
                                       ),
                                       RotatedBox(
                                         quarterTurns: 3,
                                         child: IconButton(
                                           icon: Icon(
                                             Icons.expand_more_rounded,
                                             color: renkler.koyuuRenk,
                                             size: 34,
                                           ),
                                           padding: EdgeInsets.zero,
                                           alignment: Alignment.topCenter,
                                           onPressed: () {
                                             if (indexmounth < mounths.length - 1) {
                                               indexmounth += 1;
                                             } else if (indexyear <
                                                 calender.years.length - 1) {
                                               indexmounth = 0;
                                               indexyear += 1;
                                             }
                                             readhome.changeindex(indexmounth, indexyear);
                                             readdb.setMonthandYear(
                                                 (indexmounth + 1).toString(),
                                                 calender.years[indexyear]);
                                           },
                                         ),
                                       ),
                                     ],
                                   ),

                                 ],
                               ),
                               RichText(text: TextSpan(
                                 text: translation(context).monthlyExpenses,
                                 style: TextStyle(
                                   height: 1,
                                     fontSize: 16,
                                     fontFamily: 'Nexa3',
                                     color: renkler.koyuuRenk),
                               ),
                                 textAlign: TextAlign.right,
                               ),
                             ],
                           ),
                         ),
                         SizedBox(
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               RichText(
                                   text: TextSpan(children: [
                                     TextSpan(
                                       text: readdb.getTotalAmountPositive(items),
                                       style: TextStyle(
                                         fontSize: 16,
                                         fontFamily: 'Nexa3',
                                         color: renkler.yesilRenk,
                                       ),
                                     ),
                                     TextSpan(
                                       text: ' ₺',
                                       style: TextStyle(
                                         fontFamily: 'TL',
                                         fontSize: 16,
                                         fontWeight: FontWeight.w600,
                                         color: renkler.yesilRenk,
                                       ),
                                     ),
                                   ])),
                               RichText(
                                   text: TextSpan(children: [
                                     TextSpan(
                                       text: readdb.getTotalAmount(items),
                                       style: TextStyle(
                                         fontSize: 18,
                                         fontFamily: 'Nexa3',
                                         color: renkler.koyuuRenk,
                                       ),
                                     ),
                                     TextSpan(
                                       text: ' ₺',
                                       style: TextStyle(
                                         fontFamily: 'TL',
                                         fontSize: 18,
                                         fontWeight: FontWeight.w600,
                                         color: renkler.koyuuRenk,
                                       ),
                                     ),
                                   ])),
                               RichText(
                                   text: TextSpan(children: [
                                     TextSpan(
                                       text: readdb.getTotalAmountNegative(items),
                                       style: TextStyle(
                                         fontSize: 16,
                                         fontFamily: 'Nexa3',
                                         color: renkler.kirmiziRenk,
                                       ),
                                     ),
                                     TextSpan(
                                       text: ' ₺',
                                       style: TextStyle(
                                         fontFamily: 'TL',
                                         fontSize: 16,
                                         fontWeight: FontWeight.w600,
                                         color: renkler.kirmiziRenk,
                                       ),
                                     ),
                                   ])), // gider bilgisi
                             ],
                           ),
                         ),
                       ],
                     ),
                   ),
                   SizedBox(width: 8),
                   Container(
                     decoration: BoxDecoration(
                       borderRadius: const BorderRadius.only(
                           bottomLeft: Radius.circular(10),
                           topLeft: Radius.circular(10)),
                       color: renkler.kirmiziRenk,
                     ),
                     height: 62,
                     width: 7,
                   ),
                 ],
               ),
             ),
           ),
         );
        });
  }

  InlineSpan textChange(String text, String value, amount) {
    return amount <= 99999 ? TextSpan(text: '$text ') : TextSpan(text: '$value ');
  }
}

