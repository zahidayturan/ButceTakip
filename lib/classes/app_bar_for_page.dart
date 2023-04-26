import 'package:butcekontrol/constans/material_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constans/text_pref.dart';
import '../riverpod_management.dart';

class AppBarForPage extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  const AppBarForPage({Key? key, required this.title}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var read2 = ref.read(botomNavBarRiverpod);
    var readsetting = ref.read(settingsRiverpod);
    var size = MediaQuery.of(context).size;
    CustomColors renkler = CustomColors();
    return SizedBox(
      width: size.width,
      height: 60,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: SizedBox(
              height: 60,
              child: Container(
                width: size.width,
                decoration: const BoxDecoration(
                    color: Color(0xff0D1C26),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(100),
                    )),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: SizedBox(
              height: 60,
              child: Container(
                width: 60,
                decoration: const BoxDecoration(
                    color: Color(0xffF2CB05),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(100),
                      topRight: Radius.circular(100),
                    )),
              ),
            ),
          ),
          Positioned(
            left: 2,
            top: 5,
            child: IconButton(
              padding: const EdgeInsets.only(right: 0),
              iconSize: 48,
              icon: title == "YARDIM"
                  || title == "YARDIM<"
                  || title == "AYARLAR"
                  || title == "İLETİŞİM"
                  || title == "YEDEKLE"
                  || title == "GİRİŞ ŞİFRESİ"
              ?const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )
              :const Icon(
                Icons.home_outlined,
                color : Colors.white,
                size: 40,
              ),
              onPressed: () async {
                if(title == "YARDIM" || title == "AYARLAR" || title == "İLETİŞİM" || title == "YEDEKLE" || title == "YARDIM<"){
                  Navigator.of(context).pop();
                }else if(title == "GİRİŞ ŞİFRESİ") {
                  if(readsetting.isPassword == 1 && readsetting.Password == "null") {
                    bool confirm = await showDialog(
                      context: context,
                      builder: (context) =>
                          AlertDialog(
                            backgroundColor: renkler.koyuuRenk,
                            title: Row(
                              children: [
                                Icon(
                                  Icons.warning_amber,
                                  color: renkler.sariRenk,
                                  size: 35,
                                ),
                                const SizedBox(width: 20),
                                const TextMod("Uyarı", Colors.white, 18),
                              ],
                            ),
                            content:  const TextMod("Herhangi Bir Şifre koymadınız\nŞifre Koymaktan vaz mı geçiyorsunuz ?", Colors.white, 15),
                            actions: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20) ,
                                child: Container(
                                  height: 30,
                                  width: 80,
                                  color: renkler.sariRenk,
                                  margin: const EdgeInsets.all(5),
                                  child:  InkWell(
                                      onTap: () => Navigator.pop(context, false),
                                      child: SizedBox(
                                          child: Center(
                                              child: TextMod("Geri Dön", renkler.koyuuRenk, 16)
                                          )
                                      )
                                  ) ,
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20) ,
                                child: Container(
                                  height: 30,
                                  width: 80,
                                  color: renkler.sariRenk,
                                  margin: const EdgeInsets.all(5),
                                  child:  InkWell(
                                      onTap: () {
                                        Navigator.pop(context, true);
                                        readsetting.setPasswordMode(false);
                                        readsetting.setisuseinsert();
                                      },
                                      child: SizedBox(
                                          child: Center(
                                              child: TextMod("Vazgeç", renkler.koyuuRenk, 16)
                                          )
                                      )
                                  ) ,
                                ),
                              ),

                            ],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                    );
                    // Onaylandıysa sayfadan çık
                    if (confirm == true) {
                      Navigator.pop(context);
                    }
                  }else{
                    Navigator.pop(context, true);
                    }
                  }
                  else{
                    read2.setCurrentindex(0);
                  }
                //Navigator.of(context).pop();
              },
            ),
          ),
          Positioned(
            right: 20,
            top: 18,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'NEXA4',
                fontSize: 23,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}