import 'package:butcekontrol/constans/material_color.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class addAssets extends StatefulWidget {
  const addAssets({Key? key}) : super(key: key);

  @override
  State<addAssets> createState() => _addAssetsState();
}

class _addAssetsState extends State<addAssets> {
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
                child: Container( //pop up boyutu
                  height: size.width * .65,
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
                      SizedBox(height: size.height * .03),
                      Center(child: toolCustomButton(context)),
                      SizedBox(height: size.height * .03),
                      Row(
                        children: [
                          toolCustomButtonForIncomeType(context),
                          TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: "Tutar Giriniz.",
                              contentPadding: EdgeInsets.symmetric(horizontal: size.width * .01,vertical: 13),
                              border: InputBorder.none
                          ),
                        ],
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
              //
            } else if (index == 1) {
              //
            } else {
              //
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
              //
            } else if (index == 1) {
              //
            } else {
              //
            }
            initialLabelIndexTool = index!;
          },
        )
    );
  }
}
