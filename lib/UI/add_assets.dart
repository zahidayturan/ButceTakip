import 'package:butcekontrol/constans/material_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../models/spend_info.dart';
import '../riverpod_management.dart';
import '../utils/db_helper.dart';

class addAssets extends ConsumerStatefulWidget {
  const addAssets({Key? key}) : super(key: key);

  @override
  ConsumerState<addAssets> createState() => _addAssetsState();
}

class _addAssetsState extends ConsumerState<addAssets> {
  final TextEditingController _controller = TextEditingController();
  var moneyType ;
  String BugFixText = "";
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
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
                onTap:() {

                },
                child: Container( //boyut
                  height: size.width * .61,
                  width: size.width * .6,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: renkler.koyuuRenk,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: size.width * .04),
                          const Text(
                              "Veri Ekle",
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
                      ),
                      SizedBox(height: size.height * .02),
                      Center(child: toolCustomButton(context)),
                      SizedBox(height: size.height * .013),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          toolCustomButtonForIncomeType(context),
                        ],
                      ),
                      SizedBox(height: size.height * .013),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding:EdgeInsets.symmetric(horizontal: size.width * .02,vertical: size.width * .007) ,
                            width: size.width * .2010,
                            height: size.height * .032,
                            decoration: BoxDecoration(
                              color: const Color(0xff1C2B35),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: TextField(
                                controller: _controller,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(

                                    RegExp(r'^\d{0,6}(\.\d{0,2})?'),)
                                ],
                                decoration: const InputDecoration(
                                  alignLabelWithHint: true,
                                  hintText: "Tutar",
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                  //contentPadding: EdgeInsets.symmetric(horizontal: size.width * .02,vertical: size.width * .028),
                                  border: InputBorder.none
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * .016),
                      GestureDetector(
                        onTap: () async {
                          double amount = double.tryParse(_controller.text) ?? 0.0;
                          if(moneyType != null && amount != 0.0){
                            final newinfo = SpendInfo(
                                operationType,
                                "null",
                                operationTool,
                                0,
                                double.tryParse(_controller.text),
                                "",
                                "null",
                                "null",
                                "null",
                                "null",
                                "null",
                                moneyType,//moneytype
                                "",
                                await ref.read(currencyRiverpod).calculateRealAmount(double.tryParse(_controller.text)!, moneyType, readSettings.Prefix!,date: "00.00.0000"),
                                "",
                                "",
                            );
                            await SQLHelper.createItem(newinfo).then((value) {
                              readSettings.setisuseinsert();
                              Navigator.of(context).pop();
                              }
                            );
                          }else{//geri mesaj ver.
                            setState(() {
                              BugFixText = moneyType ==null ? "Lütfen Bir Para birimi seçiniz." : "Lütfen Bir Değer giriniz." ;
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                          decoration: BoxDecoration(
                            color: renkler.sariRenk,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: const Text(
                              "Ekle",
                            style: TextStyle(
                              fontFamily: "Nexa2"
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * .008),
                      Center(
                        child: Text(
                            BugFixText,
                          style: TextStyle(
                            fontFamily: "Nexa3",
                            fontSize: 11,
                            color: renkler.kirmiziRenk
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

  int initialLabelIndexTool = 0;
  String operationTool = "Nakit";
  String operationType = "Gelir";

  Widget toolCustomButton(BuildContext context) {
    return SizedBox(
        height: 25,
        child: ToggleSwitch(
          initialLabelIndex: initialLabelIndexTool,
          totalSwitches: 3,
          labels: const ['NAKİT', 'KART', 'DİĞER'],
          activeBgColor: const [Color(0xffF2CB05)],
          activeFgColor: const Color(0xff0D1C26),
          inactiveFgColor: const Color(0xFFE9E9E9),
          minWidth: 50,
          cornerRadius: 20,
          radiusStyle: true,
          animate: true,
          curve: Curves.linearToEaseOut,
          customTextStyles: const [
            TextStyle(
                fontSize: 9, fontFamily: 'Nexa4', fontWeight: FontWeight.w300)
          ],
          onToggle: (index) {
            if (index == 0) {
              operationTool = "Nakit" ;
            } else if (index == 1) {
              operationTool = "Kart" ;
            } else {
              operationTool = "Diger" ;
            }
            initialLabelIndexTool = index!;
          },
        )
    );
  }
  Widget toolCustomButtonForIncomeType(BuildContext context) {
    return SizedBox(
        height: 25,
        child: ToggleSwitch(
          initialLabelIndex: initialLabelIndexTool,
          totalSwitches: 2,
          labels: const ['Arttır', 'Azalt'],
          activeBgColor: const [Color(0xffF2CB05)],
          activeFgColor: const Color(0xff0D1C26),
          inactiveFgColor: const Color(0xFFE9E9E9),
          minWidth: 50,
          cornerRadius: 20,
          radiusStyle: true,
          animate: true,
          curve: Curves.linearToEaseOut,
          customTextStyles: const [
            TextStyle(
                fontSize: 9, fontFamily: 'Nexa4', fontWeight: FontWeight.w300)
          ],
          onToggle: (index) {
            if (index == 0) {
              operationType = "Gelir";
            } else if (index == 1) {
              operationType = "Gider";
            } else {
              operationType = "Gelir";
            }
            initialLabelIndexTool = index!;
          },
        )
    );
  }
}
