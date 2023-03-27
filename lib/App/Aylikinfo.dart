import 'package:butcekontrol/Pages/gunlukpage.dart';
import 'package:butcekontrol/constans/MaterialColor.dart';
import 'package:butcekontrol/modals/Spendinfo.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class Aylikinfo extends ConsumerWidget {
  const Aylikinfo({Key ? key})  : super(key : key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScrollController Scrolbarcontroller1 = ScrollController();
    var read = ref.read(databaseRiverpod);
    var watch = ref.watch(databaseRiverpod);
    read.refreshDB();
    CustomColors renkler = CustomColors();
    var ceyrekwsize = MediaQuery.of(context).size.width / 5;
    var size = MediaQuery.of(context).size;
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
                         height: size.height / 3.04,
                         child: Padding(
                           //borderin scroll ile birleşimi gözüksü diye soldan padding
                           padding: const EdgeInsets.only(left: 4.0),
                           child: dailyTotals.length == 0
                               ? Center(
                             child: SizedBox(
                               height: 45,
                               width: 180,
                               child: DecoratedBox(
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(30),
                                     border: Border.all(
                                         color: Colors.black, width: 2),
                                   ),
                                   child: Center(child: Textmod(
                                       "Kayıt Yok", Colors.red, 32))
                                   ),
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
                                     child: const DecoratedBox(
                                       decoration: BoxDecoration(
                                           borderRadius: BorderRadius.all(
                                               Radius.circular(30)),
                                           color: Color(0xff0D1C26)),
                                     ),
                                   ),
                                 ),
                                 Scrollbar(
                                   controller: Scrolbarcontroller1,
                                   scrollbarOrientation: ScrollbarOrientation
                                       .left,
                                   isAlwaysShown: true,
                                   interactive: true,
                                   thickness: 7,
                                   radius: Radius.circular(15.0),
                                   child: ListView.builder(
                                       controller: Scrolbarcontroller1,
                                       itemCount: dailyTotals.length,
                                       itemBuilder: (BuildContext context,
                                           index) {
                                         var keys = dailyTotals.keys.toList();
                                         var day = keys[index];
                                         var _month = read.month;
                                         var _year = read.year;
                                         var dayTotals = dailyTotals[day]!;
                                         var totalAmount = dayTotals['totalAmount']!;
                                         var totalAmount2 = dayTotals['totalAmount2']!;
                                         final formattedTotal =
                                         (totalAmount - totalAmount2)
                                             .toStringAsFixed(2);

                                         var dateTime = DateTime(
                                             int.parse(_year),
                                             int.parse(_month), int.parse(day));
                                         var dayOfWeekName =
                                         _getDayOfWeekName(dateTime.weekday);
                                         return Column(
                                           children: [
                                             Padding(
                                               padding: const EdgeInsets.only(
                                                   left: 15, right: 10),
                                               child: ClipRRect(
                                                 //Borderradius vermek için kullanıyoruz
                                                 borderRadius:
                                                 BorderRadius.circular(10.0),
                                                 child: InkWell(
                                                   onTap: () {
                                                     Navigator.of(context).push(
                                                         MaterialPageRoute(
                                                             builder: (
                                                                 context) =>
                                                                 gunlukpages()));
                                                   },
                                                   child: Container(
                                                     height: 27.4,
                                                     color: renkler.ArkaRenk,
                                                     child: Padding(
                                                       padding: const EdgeInsets
                                                           .only(
                                                           left: 12, right: 15),
                                                       child: Row(
                                                         mainAxisAlignment:
                                                         MainAxisAlignment
                                                             .center,
                                                         mainAxisSize: MainAxisSize
                                                             .max,
                                                         children: [
                                                           SizedBox(
                                                               width: ceyrekwsize,
                                                               child: RichText(
                                                                 text: TextSpan(
                                                                   style: const TextStyle(
                                                                     fontFamily: 'Nexa',
                                                                     fontSize: 14,
                                                                     color: Colors
                                                                         .black,
                                                                   ),
                                                                   children: [
                                                                     TextSpan(
                                                                       text: '$day ',
                                                                       style: const TextStyle(
                                                                           fontWeight: FontWeight
                                                                               .w900),
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
                                                                   color: Colors
                                                                       .green,
                                                                 ),
                                                               ),
                                                             ),
                                                           ),
                                                           SizedBox(
                                                             width: ceyrekwsize,
                                                             child: Center(
                                                               child: Text(
                                                                 '$totalAmount2',
                                                                 style: const TextStyle(
                                                                   color: Colors
                                                                       .red,
                                                                 ),
                                                               ),
                                                             ),
                                                           ),
                                                           SizedBox(
                                                             width: ceyrekwsize,
                                                             child: Center(
                                                               child: Text(
                                                                 '$formattedTotal',
                                                                 style: const TextStyle(
                                                                   color: Colors
                                                                       .red,
                                                                 ),
                                                               ),
                                                             ),
                                                           ),
                                                           IconButton(
                                                             constraints:
                                                             const BoxConstraints(
                                                               maxHeight: 30,
                                                             ),
                                                             padding:
                                                             const EdgeInsets
                                                                 .all(1),
                                                             icon: eyeColorChoice(
                                                                 12.2),
                                                             onPressed: () {
                                                               Navigator.of(
                                                                   context)
                                                                   .push(
                                                                   MaterialPageRoute(
                                                                       builder: (
                                                                           context) =>
                                                                           gunlukpages()));
                                                             },
                                                           )
                                                         ],
                                                       ),
                                                     ),
                                                   ),
                                                 ),
                                               ),
                                             ),
                                             const SizedBox(
                                                 height:
                                                 5)
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

  Widget eyeColorChoice(double toplam) {
    if (toplam < 0) {
      return const Icon(
        Icons.remove_red_eye,
        color: Colors.red,
      );
    } else {
      return const Icon(Icons.remove_red_eye, color: Colors.black);
    }
  }

  String getTotalAmount(List<spendinfo> items) {
    double totalAmount = items
        .where((element) => element.operationType == 'Gelir')
        .fold(0, (previousValue, element) => previousValue + element.amount!);
    double totalAmount2 = items
        .where((element) => element.operationType == 'Gider')
        .fold(0, (previousValue, element) => previousValue + element.amount!);
    return (totalAmount - totalAmount2).toStringAsFixed(2);
  }

  String getTotalAmountPositive(List<spendinfo> items) {
    double totalAmount = items
        .where((element) => element.operationType == 'Gelir')
        .fold(0, (previousValue, element) => previousValue + element.amount!);

    return totalAmount.toStringAsFixed(2);
  }

  String getTotalAmountNegative(List<spendinfo> items) {
    double totalAmount2 = items
        .where((element) => element.operationType == 'Gider')
        .fold(0, (previousValue, element) => previousValue + element.amount!);
    return totalAmount2.toStringAsFixed(2);
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
