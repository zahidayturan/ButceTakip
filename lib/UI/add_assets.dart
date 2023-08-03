import 'package:butcekontrol/constans/material_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../models/spend_info.dart';
import '../utils/db_helper.dart';

class addAssets extends ConsumerStatefulWidget {
  const addAssets({Key? key}) : super(key: key);

  @override
  ConsumerState<addAssets> createState() => _addAssetsState();
}

class _addAssetsState extends ConsumerState<addAssets> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                child: Container(
                  height: size.width * .52,
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
                      SizedBox(height: size.height * .02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          toolCustomButtonForIncomeType(context),
                          Container(
                            width: size.width * .2010,
                            height: size.height * .032,
                            decoration: BoxDecoration(
                              color: Color(0xff0B1318),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextField(
                              controller: _controller,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                              decoration: InputDecoration(
                                hintText: "Tutar.",
                                hintStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                                contentPadding: EdgeInsets.symmetric(horizontal: size.width * .016,vertical: size.width * .021),
                                border: InputBorder.none
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * .02),
                      GestureDetector(
                        onTap: () async {
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
                              "null",
                              "",
                              0,
                              "null",
                              "null",
                          );
                          await SQLHelper.createItem(newinfo);
                          Navigator.of(context).pop();
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
