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
  TextEditingController _controller = TextEditingController();
  List<String> moneyTypes = ["TRY", "USD", "EUR", "GBP", "KWD", "JOD", "IQD", "SAR"];
  var moneyType ;
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
                  height: size.width * .6,
                  width: size.width * .6,
                  padding: EdgeInsets.all(15),
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: size.width * .2010,
                            height: size.height * .032,
                            decoration: BoxDecoration(
                              color: Color(0xff1C2B35),
                              borderRadius: BorderRadius.circular(12),
                            ),
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
                              decoration: InputDecoration(
                                hintText: "Tutar.",
                                hintStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                                contentPadding: EdgeInsets.symmetric(horizontal: size.width * .016,vertical: size.width * .028),
                                border: InputBorder.none
                              ),
                            ),
                          ),
                          Container(
                            height: 30,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
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
                                value: moneyType,
                                elevation: 16,
                                style: TextStyle(color: renkler.sariRenk),
                                underline: Container(
                                  height: 2,
                                  color: renkler.koyuuRenk,
                                ),
                                onChanged: (newValue) {
                                  setState(() {
                                    moneyType = newValue!;
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
                                ref.read(currencyRiverpod).calculateRealAmount(double.tryParse(_controller.text)!, moneyType, readSettings.Prefix!),
                                "",
                                "",
                            );
                            await SQLHelper.createItem(newinfo).then((value) => readSettings.setisuseinsert());
                            Navigator.of(context).pop();
                          }else{//geri mesaj ver.

                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                          decoration: BoxDecoration(
                            color: renkler.sariRenk,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                              "Ekle",
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
          labels: const ['GELİR', 'GİDER'],
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