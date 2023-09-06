import 'package:butcekontrol/classes/language.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/db_helper.dart';

/*
showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
          top: Radius.circular(25))),
    backgroundColor:
      const Color(0xff0D1C26),
    builder: (context) {
    // genel bilgi sekmesi açılıyor.
    return PasswordForget();
    },
);
 */

class PasswordForget extends ConsumerStatefulWidget {
  const PasswordForget({Key? key}) : super(key: key);

  @override
  ConsumerState<PasswordForget> createState() => _PasswordForgetState();
}

class _PasswordForgetState extends ConsumerState<PasswordForget> {
  TextEditingController animalController = TextEditingController() ;
  CustomColors renkler = CustomColors();
  @override
  Widget build(BuildContext context) {
    String errorText = "" ;
    var readSetting = ref.read(settingsRiverpod) ;
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: SizedBox(
          height: 230,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    translation(context).forgotPassword,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: "Nexa2"
                    ),
                  ),
                  DecoratedBox(
                    decoration:
                    BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.clear_rounded,
                        size: 30,
                        color: renkler.koyuuRenk,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children : [
                    Text(
                      translation(context).whatIsYourFavoriteAnimal,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: "Nexa4",
                        height: 1
                      ),
                    ),
                    const SizedBox(height: 30),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 30,
                        width: 150,
                        color: Colors.white,
                        child: TextField(
                          controller: animalController,
                          keyboardType: TextInputType.text,
                          inputFormatters:  [FilteringTextInputFormatter.allow(RegExp("[a-zA-ZğĞıİöÖüÜşŞçÇ ]"))],
                          style: TextStyle(fontSize: 18,color: renkler.koyuuRenk,height: 1),
                          textAlign: TextAlign.center,

                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                          if(animalController.text == readSetting.securityQu){
                            readSetting.setPassword("null");
                            readSetting.setPasswordMode(false);
                            readSetting.setisuseinsert();
                            Navigator.popUntil(context, (route) => route.isFirst);
                          }else{
                            readSetting.useSecurityClaim(true);
                            if(readSetting.securityClaim == 0){
                              //DB silinmesi gerekiyor.
                              SQLHelper.deleteTable("spendinfo");
                              readSetting.setPassword("null");
                              readSetting.setPasswordMode(false);
                              readSetting.setisuseinsert();
                              ref.read(botomNavBarRiverpod).setCurrentindex(4);
                              Navigator.popUntil(context, (route) => route.isFirst);
                            }else {
                              Navigator.of(context).pop();
                                showModalBottomSheet(
                                  context: context,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(25))),
                                  backgroundColor:
                                  const Color(0xff0D1C26),
                                  builder: (context) {
                                    // genel bilgi sekmesi açılıyor.
                                    return const PasswordForget();
                                  },
                                );
                            }
                          }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: 40,
                          width: 40,
                          color: Colors.white,
                          child: Center(
                            child: Icon(
                              Icons.check_circle_outline,
                              size: 30,
                              color: renkler.koyuuRenk,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  Text(
                    "${translation(context).remainingTries} : ${readSetting.securityClaim}",
                    style: const TextStyle(
                      color: Colors.white,
                      height: 1
                    ),
                  ),
                  Text(
                    errorText,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
