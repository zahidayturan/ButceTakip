import 'package:butcekontrol/UI/registerPage.dart';
import 'package:butcekontrol/constans/MaterialColor.dart';
import 'package:butcekontrol/modals/Spendinfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class appbarCustom extends ConsumerWidget  implements  PreferredSizeWidget {
  const appbarCustom({Key? key}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(60);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var e = spendinfo("Gelir", "Harclık", "Nakit", 0, 230, "anan", "5", "mayıs", "1955", "13.52", "gışş");
    List <spendinfo> depo = [e, e, e, e, e, e,e,e,e,e,e,e,e,e,];
    CustomColors renkler = CustomColors();
    return AppBar(
      backgroundColor: Color(0xFF0D1C26),
      title: RichText(
        text: const TextSpan(
          text: "Aylık Durum",

          style: TextStyle(
            fontFamily: "Nexa",
            color: Color(0xFFFFFFFF),
            fontSize: 21,
          ),
          children: [
            TextSpan(
              text: "\n+248.40 TL",
              style: TextStyle(
                color: Color(0xFFF2CB05),
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            print("Kaydedilenler");
            showDialog(
              context: context,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(0),
                  child: AlertDialog(
                    content: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: 377,
                      ),
                      child: Container(
                        padding: EdgeInsets.zero,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                    "Kaydedilen İşlemler",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Nexa3",
                                    fontSize: 18
                                  ),
                                ),
                                SizedBox(
                                  height: 40 ,
                                  width: 40,
                                  child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: renkler.ArkaRenk,
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                      ),
                                    child: IconButton(
                                      icon: Icon(Icons.clear),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height : 10.0 ,
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: const [
                                    Text(
                                        "     İşlem\nKategorisi",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Nexa4",
                                      ),
                                    ),
                                    Text(
                                      "  İşlem\nMiktarı",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Nexa4",
                                      ),
                                    ),
                                  ],
                                ), //baslıklar
                                SizedBox(
                                  height: 280,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 1),
                                    child: Theme(
                                        data: Theme.of(context).copyWith(
                                          scrollbarTheme: ScrollbarThemeData(
                                            thumbColor: MaterialStateProperty.all(renkler.sariRenk)
                                          )
                                        ),
                                        child: SizedBox(
                                          height: 300,
                                          width:500,
                                          child: Scrollbar(
                                            scrollbarOrientation: ScrollbarOrientation.right,
                                            thumbVisibility: true,
                                            interactive: true,
                                            thickness: 7,
                                            radius: Radius.circular(20),
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 1),
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    right: BorderSide(
                                                      width: 5,
                                                      color: renkler.ArkaRenk,
                                                    )
                                                  )
                                                ),
                                                child: ListView.builder(
                                                    itemCount: depo.length,
                                                    itemBuilder:  (context, index) {
                                                      return  SizedBox(
                                                        height: 35,
                                                        child: Stack(
                                                          fit: StackFit.expand,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.symmetric(vertical:7,horizontal: 15),
                                                              child: ClipRRect(
                                                                borderRadius: BorderRadius.circular(20),
                                                                child: Container(
                                                                  color: renkler.ArkaRenk,
                                                                  height: 1,
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                    children: const [
                                                                      SizedBox(width: 10),
                                                                      Text(
                                                                        "Günlük yaşam",
                                                                        style: TextStyle(
                                                                          fontFamily: "Nexa4",
                                                                          fontSize: 15,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        "174 TL",
                                                                        style: TextStyle(
                                                                          color: Colors.red,
                                                                          fontFamily: "Nexa4",
                                                                          fontSize: 15,
                                                                        ),
                                                                      ),
                                                                      SizedBox(width: 5,)
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              top: 2,
                                                              left :1,
                                                              child: SizedBox(
                                                                width:  30,
                                                                height: 30,
                                                                child: DecoratedBox(
                                                                  decoration: BoxDecoration(
                                                                    color: renkler.ArkaRenk,
                                                                    borderRadius: BorderRadius.circular(20)
                                                                  ),
                                                                  child: Icon(
                                                                    Icons.remove_red_eye,
                                                                    color: renkler.sariRenk,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${depo.length}",
                                      style: TextStyle(
                                        color: renkler.sariRenk,
                                        fontSize: 13
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    backgroundColor: renkler.koyuuRenk,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),

                    ),
                  ),
                );
              },
            );
          },
          icon: const Icon(
            Icons.bookmark_outlined,
            color: Color(0xFFFFFFFF),
            size: 30,
          ),
          constraints: BoxConstraints(maxWidth: 40),
          iconSize: 20.0,
        ),
        IconButton(
          onPressed:() => print("?"),
          icon: const Icon(
            Icons.question_mark,
            color: Color(0xFFFFFFFF),
            size: 30,
          ),
          constraints: BoxConstraints(maxWidth: 40),

        ),
        IconButton(
          onPressed:() => print("reset"),
          icon: const Icon(
            Icons.refresh,
            color: Color(0xFFFFFFFF),
            size: 30,
          ),
          constraints: BoxConstraints(maxWidth: 40),
        ),

        IconButton(
          onPressed:() => print("settings"),
          icon: const Icon(
            Icons.settings,
            color: Color(0xFFFFFFFF),
            size: 30,
          ),
          constraints: BoxConstraints(maxWidth: 40),
        ),
        const SizedBox(width: 5,),
      ],
    );
  }

}
/*
Row(   /// her bir kaydın oldugu satır
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children:  [
SizedBox(
height:  40,
width : 40 ,
child: DecoratedBox(
decoration: const BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.all(Radius.circular(40)),
),
child: Center(
child: Icon(
Icons.remove_red_eye,
color: renkler.sariRenk,
),
),
),
),
Text("İşlem kategorisi"),
const Text(
"189 TL",
style: TextStyle(
color:  Colors.green,
),
),
],
),

 */