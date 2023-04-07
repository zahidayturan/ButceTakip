import 'package:butcekontrol/Pages/dailyInfo.dart';
import 'package:butcekontrol/constans/MaterialColor.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constans/TextPref.dart';


class Aylikinfo extends ConsumerWidget {
  const Aylikinfo({Key ? key})  : super(key : key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScrollController scrolbarcontroller1 = ScrollController();
    var read = ref.read(databaseRiverpod);
    var readHome = ref.read(homeRiverpod);
    var readDailyInfo = ref.read(dailyInfoRiverpod);
    ref.listen(databaseRiverpod, (previous, next) { ///bune mk bakılacak ? bunun sayesinde çlaışıyor bakıcam
      ref.watch(databaseRiverpod).month;
      ref.watch(databaseRiverpod).isuseinsert ;
    }
    );
    var size = MediaQuery.of(context).size;
    print("yukseklik : ${size.height}");
    print("genıslık : ${size.width}");
    CustomColors renkler = CustomColors();
    var ceyrekwsize = MediaQuery.of(context).size.width / 5;
       return StreamBuilder<Map<String, dynamic>>(
           stream: read.myMethod(),
           builder:
               (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                 if (!snapshot.hasData) {
                   return const Center(
                     child: CircularProgressIndicator(),
                   );
                 }
                 var dailyTotals = snapshot.data!['dailyTotals'];
                 return Center(
                   child: Column(
                     children: [
                       SizedBox(
                         height:  size.height * 0.333,
                         child: Padding(
                           //borderin scroll ile birleşimi gözüksü diye soldan padding
                           padding: const EdgeInsets.only(left: 4.0),
                           child: dailyTotals.length == 0
                               ? Center(
                                   child: Column(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: [
                                       Image.asset(
                                         "assets/image/origami_noinfo.png",
                                         width: 60,
                                         height: 60,
                                       ),

                                       SizedBox(
                                         height: 30,
                                         width: 110,
                                         child: DecoratedBox(
                                             decoration: BoxDecoration(
                                               borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                                               border: Border.all(
                                                   color: Colors.black, width: 2),
                                             ),
                                             child: const Center(child: Textmod(
                                                 "Kayıt Yok", Colors.amber, 18))
                                             ),
                                         ),
                                     ],
                                   ),
                                )
                               : Theme(
                                   data: Theme.of(context).copyWith(
                                       scrollbarTheme: ScrollbarThemeData(
                                         thumbColor: MaterialStateProperty.all(renkler
                                             .sariRenk),
                                       )),
                                 child: Stack(
                                   children: [
                                     Padding(
                                       padding: const EdgeInsets.only(left: 1.75),
                                       child: SizedBox(
                                         width: 4,
                                         height: size.height / 3.04,
                                         child:  DecoratedBox(
                                           decoration: BoxDecoration(
                                               borderRadius: BorderRadius.all(
                                                   Radius.circular(30)),
                                               color: dailyTotals.length <= 6 ? renkler.ArkaRenk : Color(0xFF0D1C26)),
                                         ),
                                       ),
                                     ),
                                     Scrollbar(
                                       controller: scrolbarcontroller1,
                                       thumbVisibility: true,
                                       scrollbarOrientation: ScrollbarOrientation
                                           .left,
                                       interactive: true,
                                       thickness: 7,
                                       radius: const Radius.circular(15.0),
                                       child: ListView.builder(
                                           controller: scrolbarcontroller1,
                                           itemCount: dailyTotals.length,
                                           itemBuilder: (BuildContext context,
                                               index) {
                                             var keys = dailyTotals.keys.toList();
                                             var day = keys[index];
                                             var month = read.month;
                                             var year = read.year;
                                             var dayTotals = dailyTotals[day]!;
                                             var totalAmount = dayTotals['totalAmount']!;
                                             var totalAmount2 = dayTotals['totalAmount2']!;
                                             final formattedTotal =(totalAmount - totalAmount2).toStringAsFixed(2);
                                             var dateTime = DateTime(int.parse(year),int.parse(month), int.parse(day));
                                             var dayOfWeekName =
                                             _getDayOfWeekName(dateTime.weekday);
                                         return Column(
                                           children: [
                                             Padding(
                                               padding: EdgeInsets.only(left: size.height * 0.025, right: size.height * 0.014),
                                               child: ClipRRect(
                                                 //Borderradius vermek için kullanıyoruz
                                                 borderRadius:
                                                 BorderRadius.circular(10.0),
                                                 child: InkWell(
                                                   onTap: () {
                                                     readHome.setDailyStatus(totalAmount.toString(), totalAmount2.toString(), formattedTotal.toString()); ///
                                                     if (double.parse(formattedTotal) <= 0) { //gunlukpage tarih arkası renk ayarlıyor.
                                                       read.setStatus("-");
                                                     }else{
                                                       read.setStatus("+");

                                                     }
                                                     read.setDay(day);
                                                     read.setDate(items[index].operationDate);
                                                     readDailyInfo.setDate(int.parse(day), int.parse(month), int.parse(year));
                                                     Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  const dailyInfo()));
                                                   },
                                                   child: Container(
                                                     height: size.height * 0.0409 ,//27.9,
                                                     color: renkler.ArkaRenk,
                                                     child: Padding(
                                                       padding:  EdgeInsets.only(left: size.width * 0.029 , right: size.width * 0.03165 ), //  12   15
                                                       child: Row(
                                                         mainAxisAlignment: MainAxisAlignment.center,
                                                         mainAxisSize: MainAxisSize.max,
                                                         children: [
                                                           SizedBox(
                                                               width: ceyrekwsize,
                                                               child: RichText(
                                                                 text: TextSpan(
                                                                   style: TextStyle(
                                                                     fontFamily: 'Nexa',
                                                                     fontSize: size.height  * 0.0205,//14
                                                                     color: Colors.black,
                                                                   ),
                                                                   children: [
                                                                     TextSpan(
                                                                       text: '$day ',
                                                                       style: TextStyle(
                                                                           fontWeight: FontWeight.w900,
                                                                          fontSize:  size.height  * 0.0205,
                                                                       ),
                                                                     ),
                                                                     TextSpan(
                                                                       text: dayOfWeekName,
                                                                     ),
                                                                   ],
                                                                 ),

                                                               )),
                                                           SizedBox(
                                                             width: ceyrekwsize,
                                                             child: Center(
                                                               child: Text(
                                                                 "$totalAmount",
                                                                 style: TextStyle(
                                                                   fontSize : size.height  * 0.0205 ,
                                                                   color: Colors.green,
                                                                 ),
                                                               ),
                                                             ),
                                                           ),
                                                           SizedBox(
                                                             width: ceyrekwsize,
                                                             child: Center(
                                                               child: Text(
                                                                 '$totalAmount2',
                                                                 style:  TextStyle(
                                                                   color: Colors.red,
                                                                   fontSize: size.height  * 0.0205,
                                                                 ),
                                                               ),
                                                             ),
                                                           ),
                                                           SizedBox(
                                                             width: ceyrekwsize,
                                                             child: Center(
                                                               child: Text(
                                                                 '$formattedTotal',
                                                                 style: TextStyle(
                                                                   color: Colors.black,
                                                                   fontSize: size.height  * 0.0205,
                                                                 ),
                                                               ),
                                                             ),
                                                           ),
                                                           eyeColorChoice(formattedTotal),
                                                         ],
                                                       ),
                                                     ),
                                                   ),
                                                 ),
                                               ),
                                             ),
                                              SizedBox(height: size.height*0.007)
                                             // elemanlar arasına bşluk bırakmak için kulllandım.
                                           ],
                                         );
                                       }),
                                 ),
                               ],
                             ),
                           ),
                         ),
                       )
                     ],
                   ),
                 );
           }
       );
    }

  Widget eyeColorChoice(String toplam) {
    if (toplam.contains('-')) {
      return const Icon(
        Icons.remove_red_eye,
        color: Colors.red,
      );
    } else {
      return const Icon(Icons.remove_red_eye, color: Colors.black);
    }
  }
  String _getDayOfWeekName(int dayOfWeek) {
    switch (dayOfWeek) {
      case 1:
        return 'Pzt';
      case 2:
        return 'Sal';
      case 3:
        return 'Çar';
      case 4:
        return 'Per';
      case 5:
        return 'Cum';
      case 6:
        return 'Cts';
      case 7:
        return 'Paz';
      default:
        return '';
    }
  }
}
