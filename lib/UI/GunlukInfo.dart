import 'package:butcekontrol/constans/MaterialColor.dart';
import 'package:butcekontrol/modals/Spendinfo.dart';
import 'package:butcekontrol/utils/dpHelper.dart';
import 'package:flutter/material.dart';

class GunlukInfo extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _GunlukInfoState();

}

class _GunlukInfoState extends State{
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
                padding: const EdgeInsets.only( right: 10, top: 5,),
                child: Text(
                    '22.11.2023',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              )

            ],
          ),

        ],
      )
    );
}

}