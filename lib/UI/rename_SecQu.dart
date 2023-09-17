import 'package:butcekontrol/constans/material_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../classes/language.dart';
import '../models/spend_info.dart';
import '../riverpod_management.dart';
import '../utils/db_helper.dart';

class renameSecQu extends ConsumerStatefulWidget {
  const renameSecQu({Key? key}) : super(key: key);

  @override
  ConsumerState<renameSecQu> createState() => _renameSecQu();
}

class _renameSecQu extends ConsumerState<renameSecQu> {

  TextEditingController setanimalController = TextEditingController();

  @override
  void dispose() {
    setanimalController.dispose();
    super.dispose();
  }
  var errormessage = "";
  @override
  Widget build(BuildContext context) {
    var readSettings = ref.read(settingsRiverpod);
    var size = MediaQuery
        .of(context)
        .size;
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
                  width: size.width * .6,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: size.width * .05),
                          Text(
                            translation(context).securityQuestion,
                            style: TextStyle(
                                color: Theme.of(context).dialogBackgroundColor,
                                fontFamily: "Nexa2",
                                fontSize: 16,
                              height: 1
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
                                icon: Image.asset(
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: size.height * .02),
                          Text(
                            translation(context).whatIsYourFavoriteAnimal,
                            style: TextStyle(
                                color: Theme.of(context).canvasColor,
                                fontSize: 13,
                                fontFamily: "Nexa4",
                              height: .7
                            ),
                          ),
                          SizedBox(height: size.height * .02),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 30,
                              width: 130,
                              color: Color(0xFF1C2B35),
                              padding: EdgeInsets.only(bottom: 7),
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
                                    border: InputBorder.none
                                ),
                                controller: setanimalController,
                                keyboardType: TextInputType.text,
                                inputFormatters:  [FilteringTextInputFormatter.allow(RegExp("[a-zA-ZğĞıİöÖüÜşŞçÇ ]"))],
                                style: const TextStyle(fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * .015),
                          InkWell(
                            onTap: () {
                              if (setanimalController.text != "" ) {
                                setState(() {
                                  readSettings.setSecurityQu(setanimalController.text);
                                });
                                readSettings.setisuseinsert();
                                Navigator.of(context).pop();
                              }else if(setanimalController.text == ""){
                                setState(() {
                                  errormessage = translation(context).pleaseEnteraName ;
                                });
                              }
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 40,
                                width: 40,
                                color: Theme.of(context).disabledColor,
                                child: const Center(
                                  child: Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * .006),
                          Text(
                            errormessage,
                            style: TextStyle(
                              color: renkler.kirmiziRenk,
                              fontSize: 12,
                              height: 1.1
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