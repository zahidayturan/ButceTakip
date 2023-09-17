import 'package:butcekontrol/classes/language.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../riverpod_management.dart';

class changePrefixAlert extends ConsumerStatefulWidget {
  final String newValue;
  const changePrefixAlert(this.newValue, {Key? key}) : super(key: key);

  @override
  ConsumerState<changePrefixAlert> createState() => _changePrefixAlert(newValue);
}

class _changePrefixAlert extends ConsumerState<changePrefixAlert> {
  bool loading = false;
  String BugFixText = "";
  String newValue = "";
  String oldVAlue = "";
  _changePrefixAlert(this.newValue);
  @override
  Widget build(BuildContext context) {
    var readSetting = ref.read(settingsRiverpod);
    var currencyRiv = ref.read(currencyRiverpod);
    var adEventCounter = readSetting.adEventCounter;
    var size = MediaQuery.of(context).size;
    var renkler = CustomColors();
    return WillPopScope(
      onWillPop: ()async  => loading ? false : true,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: GestureDetector(
            onTap: () {
              if(loading){

              }else{
                Navigator.of(context).pop();
              }
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
                    height: size.width * .58,
                    width: size.width * .70,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: loading
                     ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Text(
                               "$oldVAlue -> $newValue",
                               style: TextStyle(
                                   color: Theme.of(context).secondaryHeaderColor,
                                   fontFamily: "Nexa2",
                                   fontSize: 19
                               ),
                             ),
                           ],
                         ),
                         Center(
                           child: SizedBox(
                             height: size.width * .17,
                             width: size.width * .17,
                             child: CircularProgressIndicator(
                              color: Theme.of(context).disabledColor,
                              backgroundColor: renkler.koyuuRenk,
                              ),
                           )
                          ),
                         Text(
                             translation(context).convertMessage,
                           style: TextStyle(
                             fontFamily: "Nexa3",
                             fontSize: 18,
                             color: Theme.of(context).secondaryHeaderColor,
                           ),
                           textAlign: TextAlign.center,
                         ),
                       ],
                     )
                    :Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text(
                             translation(context).warning,
                             style: TextStyle(
                                 color: Theme.of(context).secondaryHeaderColor,
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
                       Center(
                           child: Text(
                               translation(context).changeCurrencyWarning,
                             textAlign: TextAlign.center,
                           )
                       ),
                       Text(
                           newValue,
                         style: const TextStyle(
                           fontSize: 17,
                           fontFamily: "Nexa4",
                         ),
                       ),
                       GestureDetector(
                         onTap: () async {
                           adEventCounter != 0 ? readSetting.useAdEventCounter() : null;
                           oldVAlue = readSetting.Prefix!;
                           setState(() {
                             loading = true;
                           });
                           if (readSetting.Prefix != newValue) {
                             readSetting.setPrefix(newValue);
                             await currencyRiv.calculateAllSQLHistoryTime();
                             readSetting.setisuseinsert();
                           }
                           Navigator.of(context).pop();
                         },
                         child: Container(
                           height: 32,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(12),
                             color: Theme.of(context).disabledColor,
                           ),
                           child: Center(
                               child: Text(translation(context).convert)
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
      ),
    );
  }
}
