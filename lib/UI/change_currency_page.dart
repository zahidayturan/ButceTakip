import 'package:butcekontrol/UI/spend_detail.dart';
import 'package:butcekontrol/classes/language.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/constans/text_pref.dart';
import 'package:butcekontrol/models/spend_info.dart';
import 'package:butcekontrol/utils/interstitial_ads.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final InterstitialAdManager _interstitialAdManager = InterstitialAdManager();
  final TextEditingController setPartOfAmountController = TextEditingController(text : "0.0");
  List<String> moneyTypes = ["TRY", "USD", "EUR", "GBP", "KWD", "JOD", "IQD", "SAR"];
  String ?desiredUnit ;
  double amount = 0.0 ;
  double rate = 0.0;
  double partOfAmount = 0.0 ;
  String errormessage = "";

  void initState(){
    super.initState();
    _interstitialAdManager.loadInterstitialAd();
  }

  void _showInterstitialAd(BuildContext context) {
    _interstitialAdManager.showInterstitialAd(context);
  }
  @override
  Widget build(BuildContext context) {
    var readSettings = ref.read(settingsRiverpod);
    var readDb = ref.read(databaseRiverpod);
    var size = MediaQuery.of(context).size;
    var renkler = CustomColors();
    var adCounter = readSettings.adCounter;
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
                  height: size.height * .35,
                  width: size.width * .80,
                  padding: const EdgeInsets.all(15),
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
                          Text(
                            translation(context).currencyExchange,
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: "Nexa2",
                                fontSize: 18,
                              height: 1
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
                          TextMod(translation(context).amount, renkler.arkaPlanRenk, 15 ),
                          TextMod("${widget.data.amount?.toStringAsFixed(2)} ${widget.data.moneyType.toString().substring(0,3)}", renkler.arkaPlanRenk, 15 ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                              child: TextMod(translation(context).note, renkler.arkaPlanRenk, 15 )
                          ),
                          Expanded(
                            flex: 8,
                            child: Text(
                              widget.data.note == "" ? translation(context).noNoteAdded : "${widget.data.note}",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: renkler.arkaPlanRenk,
                                fontSize: 15,
                                fontFamily: "Nexa3",
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
                          Expanded(
                            child: Slider(
                              inactiveColor: Color(0xFF1C2B35),
                              activeColor: Colors.amber,
                              thumbColor: Colors.white,
                              secondaryActiveColor: Colors.transparent,
                              value: partOfAmount,
                              min: 0.0,
                              max: widget.data.amount!,
                              onChanged: (value) {
                                setState(() {
                                  partOfAmount = value ;
                                  setPartOfAmountController.text = value.toStringAsFixed(2);
                                });
                                if(desiredUnit != null){
                                  setState(() {
                                    amount = ref.read(currencyRiverpod).calculateRealAmount(partOfAmount, widget.data.moneyType!.substring(0,3)!, desiredUnit!);
                                  });
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Container(
                              width: size.width * .2,
                              height: size.height * .032,
                              decoration: BoxDecoration(
                                color: Color(0xFF1C2B35),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                      hintText: translation(context).enter,
                                      hintStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          height: 1
                                      ),
                                      contentPadding: EdgeInsets.symmetric(horizontal: size.width * .016,vertical: size.width * .02),
                                      border: InputBorder.none,
                                    isDense: true,
                                  ),
                                  controller: setPartOfAmountController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'^\d{0,7}(\.\d{0,2})?')),
                                  ],
                                  maxLines: 1,
                                  onTap: () {
                                    setPartOfAmountController.text = "";
                                  },
                                  onChanged: (value) {
                                    if(widget.data.amount! >= double.parse(value)){
                                      setState(() {
                                        partOfAmount = double.parse(value) ;
                                      });
                                      if(desiredUnit != null){
                                        setState(() {
                                          amount = ref.read(currencyRiverpod).calculateRealAmount(partOfAmount, widget.data.moneyType!.substring(0,3)!, desiredUnit!);
                                        });
                                      }
                                    }else{
                                      setPartOfAmountController.text = widget.data.amount!.toString();
                                      partOfAmount = widget.data.amount!;
                                    }
                                  },
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: TextMod(widget.data.moneyType.toString().substring(0,3), renkler.arkaPlanRenk, 15 ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextMod(translation(context).convertTo, renkler.arkaPlanRenk, 15 ),
                          Container(
                            height: 30,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9),
                              color: const Color(0xff1C2B35),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                hint: Text(
                                  translation(context).select,
                                  style: TextStyle(
                                    color: Theme.of(context).disabledColor,
                                    height: 1
                                  ),
                                ),

                                dropdownColor: renkler.koyuuRenk,
                                borderRadius: BorderRadius.circular(20),
                                value: desiredUnit,
                                elevation: 16,
                                style: TextStyle(color: Theme.of(context).disabledColor),
                                underline: Container(
                                  height: 2,
                                  color: renkler.arkaRenk,
                                ),
                                onChanged: (newValue) {
                                  setState(() {
                                    desiredUnit = newValue!;
                                    amount = ref.read(currencyRiverpod).calculateRealAmount(partOfAmount, widget.data.moneyType!.substring(0,3)!, desiredUnit!);
                                    rate = ref.read(currencyRiverpod).calculateRate(widget.data.moneyType!.substring(0,3)!, desiredUnit!);
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
                      ?TextMod("", renkler.arkaPlanRenk, 15 )
                      :Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextMod(
                            "${translation(context).currentRate} (${desiredUnit})",
                              renkler.arkaPlanRenk,
                              14
                          ),
                          TextMod("${rate}", renkler.arkaPlanRenk, 15 ),
                        ],
                      ),
                      desiredUnit == null
                      ?TextMod(errormessage, Colors.white, 15 )
                      :Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextMod(translation(context).receivedAmount,
                              renkler.arkaPlanRenk,
                              14
                          ),
                          TextMod("${amount} ${desiredUnit}", renkler.arkaPlanRenk, 14 ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment :widget.data.operationDay == "null" ? MainAxisAlignment.center : MainAxisAlignment.spaceEvenly,
                        children: [
                          widget.data.operationDay == "null"
                          ?const SizedBox(height: 0)
                          :GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                              ref.read(dailyInfoRiverpod).setSpendDetail([widget.data], 0);
                              showModalBottomSheet(
                                isScrollControlled:true,
                                context: context,
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
                                backgroundColor:
                                renkler.koyuuRenk,
                                builder: (context) {
                                  //ref.watch(databaseRiverpod).updatest;
                                  // genel bilgi sekmesi açılıyor.
                                  return const SpendDetail();
                                },
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                              decoration: BoxDecoration(
                                color: Theme.of(context).disabledColor,
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Text(
                                translation(context).detailsForCurrencyExchange,
                                style: TextStyle(
                                    fontFamily: "Nexa2",
                                    height: 1,
                                    color: renkler.koyuuRenk
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              if(desiredUnit != null){
                                //double amount =  ref.read(currencyRiverpod).calculateRealAmount(widget.data.amount!, widget.data.moneyType!.substring(0,3)!, desiredUnit!);
                                String moneyType = "${desiredUnit!}1";
                                Map<String, dynamic> changes = {
                                  "amount" : amount ,
                                  "moneyType" : moneyType,
                                  "realAmount" : ref.read(currencyRiverpod).calculateRealAmount(partOfAmount, widget.data.moneyType!, ref.read(settingsRiverpod).Prefix!,)
                                  //"realAmount" : ref.read(currencyRiverpod).calculateRealAmount((widget.data.amount! - partOfAmount), widget.data.moneyType!, ref.read(settingsRiverpod).Prefix!,)
                                };
                                if(partOfAmount != widget.data.amount!){
                                  double newRealAmount = ref.read(currencyRiverpod).calculateRealAmount(
                                    (widget.data.amount! - partOfAmount),
                                    widget.data.moneyType!,
                                    ref.read(settingsRiverpod).Prefix!,
                                  );
                                  if(widget.data.category == "null" && widget.data.operationDay == "null"){//varlık kaydı.
                                    final newinfo = SpendInfo(
                                      widget.data.operationType,
                                      widget.data.category,
                                      widget.data.operationTool,
                                      widget.data.registration,
                                      (widget.data.amount! - partOfAmount),
                                      widget.data.note,
                                      widget.data.operationDay,
                                      widget.data.operationMonth,
                                      widget.data.operationYear,
                                      widget.data.operationTime,
                                      widget.data.operationDate,
                                      widget.data.moneyType!,
                                      widget.data.processOnce,
                                      newRealAmount,
                                      widget.data.userCategory,
                                      widget.data.systemMessage,
                                    );
                                    await SQLHelper.createItem(newinfo).then((value) {
                                      readSettings.setisuseinsert();
                                    });
                                  }else{//normal kayıt
                                    readDb.insertDataBase(
                                        widget.data.operationType,
                                        widget.data.category,
                                        widget.data.operationTool,
                                        widget.data.registration!,
                                        (widget.data.amount! - partOfAmount),
                                        widget.data.note,
                                        widget.data.operationDate!,
                                        widget.data.moneyType!,
                                        newRealAmount,
                                        widget.data.processOnce!,
                                        widget.data.userCategory!,
                                        widget.data.systemMessage!
                                    );
                                  }
                                  await SQLHelper.updateDB(widget.data.id, "spendinfo", changes).then((value) => readSettings.setisuseinsert());
                                }else{
                                  amount = ref.read(currencyRiverpod).calculateRealAmount(
                                    widget.data.amount!,
                                    widget.data.moneyType!,
                                    ref.read(settingsRiverpod).Prefix!,
                                  );
                                  await SQLHelper.updateDB(widget.data.id, "spendinfo", changes).then((value) => readSettings.setisuseinsert());
                                }
                                if (adCounter == 0) {
                                  _showInterstitialAd(context);
                                  readSettings.resetAdCounter();
                                } else {
                                  readSettings.useAdCounter();
                                }
                                Navigator.of(context).pop();
                              }else{//geri mesaj ver.
                                setState(() {
                                  errormessage = "Birim seçiniz.";
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
                                translation(context).doneExchange,
                                style: TextStyle(
                                    fontFamily: "Nexa2",
                                    height: 1,
                                    color: renkler.koyuuRenk
                                ),
                              ),
                            ),
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
}