import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/constans/text_pref.dart';
import 'package:butcekontrol/models/spend_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../riverpod_management.dart';
import '../utils/db_helper.dart';

class changeCurrencyPage extends ConsumerStatefulWidget{
  final SpendInfo data;
  const changeCurrencyPage(this.data, {Key? key}) : super(key: key);

  @override
  ConsumerState<changeCurrencyPage> createState() => _changeCurrencyPage();
}

class _changeCurrencyPage extends ConsumerState<changeCurrencyPage> {
  List<String> moneyTypes = ["TRY", "USD", "EUR", "GBP", "KWD", "JOD", "IQD", "SAR"];
  String ?desiredUnit ;
  double amount = 0.0 ;
  double rate = 0.0;
  @override
  Widget build(BuildContext context) {
    var errormessage = "";
    var readSettings = ref.read(settingsRiverpod);
    var size = MediaQuery.of(context).size;
    var renkler = CustomColors();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
            ),
            child: Center(
              child: GestureDetector(
                onTap: () {

                },
                child: Container( //boyut
                  height: size.width * .63,
                  width: size.width * .74,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: renkler.koyuuRenk,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: size.width * .04),
                          const Text(
                            "Döviz Bürosu",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Nexa2",
                                fontSize: 18
                            ),
                          ),
                          SizedBox(
                            height: 30,
                            width: 30,
                            child: DecoratedBox(
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle
                              ),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.of(
                                      context)
                                      .pop();
                                },
                                icon:  Image.asset(
                                  "assets/icons/remove.png",
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ), ///Title
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextMod("Miktar", renkler.arkaPlanRenk, 15 ),
                          TextMod("${widget.data.amount} ${widget.data.moneyType}", renkler.arkaPlanRenk, 15 ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                              child: TextMod("Not:", renkler.arkaPlanRenk, 15 )
                          ),
                          Expanded(
                            flex: 5,
                            child: Text(
                                "${widget.data.note}",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: renkler.arkaPlanRenk,
                                fontSize: 15,
                                fontFamily: "Nexa 3",
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextMod("Çevrilecek Birim", renkler.arkaPlanRenk, 15 ),
                          Container(
                            height: 30,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9),
                              color: Color(0xff1C2B35),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                hint: Text(
                                  "Seçiniz",
                                  style: TextStyle(
                                    color: renkler.sariRenk,
                                  ),
                                ),

                                dropdownColor: renkler.koyuuRenk,
                                borderRadius: BorderRadius.circular(20),
                                value: desiredUnit,
                                elevation: 16,
                                style: TextStyle(color: renkler.sariRenk),
                                underline: Container(
                                  height: 2,
                                  color: renkler.arkaRenk,
                                ),
                                onChanged: (newValue) {
                                  setState(() {
                                    desiredUnit = newValue!;
                                    amount = ref.read(currencyRiverpod).calculateRealAmount(widget.data.amount!, widget.data.moneyType!, desiredUnit!);
                                    rate = ref.read(currencyRiverpod).calculateRate(widget.data.amount!, widget.data.moneyType!, desiredUnit!);
                                  });
                                },
                                items: moneyTypes.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      desiredUnit == null
                      ?TextMod("Birim Seçiniz.", renkler.arkaPlanRenk, 15 )
                      :Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextMod(
                            "Güncel ${desiredUnit} Kuru",
                              renkler.arkaPlanRenk,
                              15
                          ),
                          TextMod("${rate}", renkler.arkaPlanRenk, 15 ),
                        ],
                      ),
                      desiredUnit == null
                      ?Text("")
                      :Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextMod("Alacağınız Miktar",
                              renkler.arkaPlanRenk,
                              14
                          ),
                          TextMod("${amount} ${desiredUnit}", renkler.arkaPlanRenk, 14 ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () async {
                          if(desiredUnit != null){
                            double amount = ref.read(currencyRiverpod).calculateRealAmount(widget.data.amount!, widget.data.moneyType!, desiredUnit!);
                            String moneyType = desiredUnit!;
                            Map<String, dynamic> changes = {
                              "amount" : amount ,
                              "moneyType" : moneyType
                            };
                            await SQLHelper.updateDB(widget.data.id, "spendinfo", changes).then((value) => readSettings.setisuseinsert());
                            Navigator.of(context).pop();
                          }else{//geri mesaj ver.

                          }

                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                          decoration: BoxDecoration(
                            color: renkler.sariRenk,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: const Text(
                            "Onayla",
                            style: TextStyle(
                                fontFamily: "Nexa2"
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}