import 'package:butcekontrol/constans/MaterialColor.dart';
import 'package:butcekontrol/modals/Spendinfo.dart';
import 'package:butcekontrol/utils/dpHelper.dart';
import 'package:flutter/material.dart';

class GunlukInfo extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _GunlukInfoState();

}

class _GunlukInfoState extends State<GunlukInfo>{
  bool _isLoading = true;
/*
  void _refreshSpendinfoList() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshSpendinfoList();
  }

 */

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomRight:Radius.circular(20), topRight:Radius.circular(20)),
                      color: CustomColors.sariRenk,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25.0, right: 10, top: 5,),
                      child: Text(
                          "Bügünün islem bilgileri",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only( right: 25, top: 5,),
                child: Text(
                    '22.11.2023',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              )

            ],
          ),

          Column(
            children: [
              SizedBox(
                height: 180,
                child: Padding(
                  padding: const EdgeInsets.only(left: 3, top: 10),
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      border: Border(left: BorderSide(width: 5, color: Color(0xFF0D1C26)))
                    ),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                          scrollbarTheme: ScrollbarThemeData(
                            thumbColor: MaterialStateProperty.all(Color(0xFFF2CB05)),
                          )
                      ),
                      child: Scrollbar(
                        scrollbarOrientation: ScrollbarOrientation.left,
                        isAlwaysShown: true,
                        interactive: true,
                        thickness: 8,
                        radius: Radius.circular(15),
                        child: Padding(  // buraya ListView.builder gelecek
                          padding: const EdgeInsets.only(left: 20,right: 20),
                          child: Column(
                            children: [
                              Text(
                                "Kategori             Odeme            Miktar            Saat",
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                              Text(
                                "Yemek                  Nakit                  200                 13.5",
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                        ), // buraya ListView.builder gelecek
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      )
    );
}

}