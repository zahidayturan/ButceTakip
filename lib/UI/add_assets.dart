import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/utils/interstitial_ads.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../classes/language.dart';
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
  List<String> moneyTypes = ["TRY", "USD", "EUR", "GBP", "KWD", "JOD", "IQD", "SAR"];
  var moneyType ;
  String BugFixText = "";
  final InterstitialAdManager _interstitialAdManager = InterstitialAdManager();

  @override
  void initState() {
    var readSettings = ref.read(settingsRiverpod);
    var adEventCounter = readSettings.adEventCounter;
    if (adEventCounter! < 6) {
      _interstitialAdManager.loadInterstitialAd();
    } else {
    }
    super.initState();
  }
  void _showInterstitialAd(BuildContext context) {
    _interstitialAdManager.showInterstitialAd(context);
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var readSettings = ref.read(settingsRiverpod);
    var adEventCounter = readSettings.adCounter;
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
                  height: 230,
                  width: 250,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: size.width * .04),
                          Text(
                            initialLabelIndexType == 0 ? translation(context).addAssetTitle : translation(context).removeAssetTitle,
                            style: TextStyle(
                              color: Theme.of(context).dialogBackgroundColor,
                              fontFamily: "Nexa2",
                              fontSize: 18
                            ),
                          ),
                          SizedBox(
                            height: 30,
                            width: 30,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).canvasColor,
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
                                  color: Theme.of(context).primaryColor,
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
                              color:Theme.of(context).indicatorColor,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).canvasColor,
                                  blurRadius: 1
                                ),
                              ]
                            ),
                            child: TextField(
                              controller: _controller,
                              style: TextStyle(
                                color: Theme.of(context).secondaryHeaderColor,
                                fontSize: 13,
                              ),
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d{0,6}(\.\d{0,2})?'),)
                              ],
                              decoration: InputDecoration(
                                hintText: translation(context).amount,
                                hintStyle: TextStyle(
                                    color: Theme.of(context).secondaryHeaderColor,
                                    fontSize: 10,
                                  height: 1.3
                                ),
                                contentPadding: EdgeInsets.symmetric(horizontal: size.width * .016,vertical: size.width * .028),
                                border: InputBorder.none
                              ),
                            ),
                          ),
                          Container(
                            height: size.height * .032,
                            width: 85,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color:  Theme.of(context).indicatorColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).canvasColor,
                                  blurRadius: 1
                                ),
                              ]
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                hint: Text(
                                  translation(context).select,
                                  style: TextStyle(
                                    color: Theme.of(context).secondaryHeaderColor,
                                  ),
                                ),
                                dropdownColor:Theme.of(context).indicatorColor,
                                borderRadius: BorderRadius.circular(20),
                                value: moneyType,
                                elevation: 16,
                                style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
                                underline: Container(
                                  height: 2,
                                  color: Theme.of(context).indicatorColor,
                                ),
                                onChanged: (newValue) {
                                  setState(() {
                                    moneyType = newValue;
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
                          String formattedDate = DateFormat('dd.MM.yyyy').format(DateTime.now());
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
                              formattedDate,
                              operationType == "Gelir" ? moneyType + "1" : moneyType,//moneytype
                              "",
                              ref.read(currencyRiverpod).calculateRealAmount(double.tryParse(_controller.text)!, moneyType, readSettings.Prefix!),
                              "",
                              "",
                            );
                            await SQLHelper.createItem(newinfo).then((value) {
                              readSettings.setisuseinsert();
                              if (adEventCounter! <= 0) {
                                _showInterstitialAd(context);
                                readSettings.resetAdEventCounter();
                              } else {
                                readSettings.useAdEventCounter();
                              }
                              Navigator.of(context).pop();
                            });
                          }else{//geri mesaj ver.
                            setState(() {
                              BugFixText = moneyType ==null ? translation(context).pleaseSelectCurrency : translation(context).enterAmount;
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                          decoration: BoxDecoration(
                            color: Theme.of(context).disabledColor,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Text(
                            translation(context).doneAsset,
                            style: const TextStyle(
                              fontFamily: "Nexa2",
                              height: 1,
                              color: Color(0xFF0D1C26),
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
  int initialLabelIndexType = 0;
  String operationTool = "Nakit";
  String operationType = "Gelir";

  Widget toolCustomButton(BuildContext context) {
    return SizedBox(
        height: 25,
        child: ToggleSwitch(
          initialLabelIndex: initialLabelIndexTool,
          totalSwitches: 3,
          labels: [translation(context).cashAsset, translation(context).cardAsset, translation(context).other],
          activeBgColor: [Theme.of(context).disabledColor],
          activeFgColor: const Color(0xff0D1C26),
          inactiveBgColor: Theme.of(context).highlightColor,
          inactiveFgColor: const Color(0xFFE9E9E9),
          minWidth: 60,
          cornerRadius: 20,
          radiusStyle: true,
          animate: true,
          curve: Curves.linearToEaseOut,
          customTextStyles: const [
            TextStyle(
                fontSize: 11, fontFamily: 'Nexa4', fontWeight: FontWeight.w300)
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
          initialLabelIndex: initialLabelIndexType,
          totalSwitches: 2,
          labels: [translation(context).addAsset, translation(context).removeAsset],
          activeBgColor: [Theme.of(context).disabledColor],
          activeFgColor: const Color(0xff0D1C26),
          inactiveBgColor: Theme.of(context).highlightColor,
          inactiveFgColor: const Color(0xFFE9E9E9),
          minWidth: 60,
          cornerRadius: 20,
          radiusStyle: true,
          animate: true,
           curve: Curves.linearToEaseOut,
          customTextStyles: const [
            TextStyle(
                fontSize: 11, fontFamily: 'Nexa4', fontWeight: FontWeight.w300)
          ],
          onToggle: (index) {
            setState(() {
              if (index == 0) {
                operationType = "Gelir";

              } else if (index == 1) {
                operationType = "Gider";

              } else {
                operationType = "Gelir";

              }
              initialLabelIndexType = index!;
            });
          },
        )
    );
  }
}
