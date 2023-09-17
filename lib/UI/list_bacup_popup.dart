import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/utils/interstitial_ads.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../classes/language.dart';
import '../riverpod_management.dart';

class listBackUpPopUp extends ConsumerStatefulWidget{
  const listBackUpPopUp({Key? key}) : super(key: key);

  @override
  ConsumerState<listBackUpPopUp> createState() => _listBackUpPopUp();
}

class _listBackUpPopUp extends ConsumerState<listBackUpPopUp> {
  final InterstitialAdManager _interstitialAdManager = InterstitialAdManager();
  bool isclicked = false ;
  var renkdeneme = Colors.white;
  List selectedIndexList = [] ;
  void initState(){
    super.initState();
    _interstitialAdManager.loadInterstitialAd();
  }

  void _showInterstitialAd(BuildContext context) {
    _interstitialAdManager.showInterstitialAd(context);
  }
  @override
  Widget build(BuildContext context) {
    var readGglAuth = ref.read(gglDriveRiverpod);
    Future<List> backUpList = readGglAuth.ListOfFolder();
    var readSettings = ref.watch(settingsRiverpod);
    readSettings.isuseinsert;
    var size = MediaQuery.of(context).size;
    var renkler = CustomColors();
    return WillPopScope(
      onWillPop: ()async  => isclicked  ? false : true,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: GestureDetector(
            onTap: () {
              if(isclicked){

              }else{
                Navigator.of(context).pop();
              }
            },
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).highlightColor.withOpacity(0.4),
              ),
              child: Center(
                child: GestureDetector(
                  onTap: () {

                  },
                  child: Container( //boyut
                    height: size.width * .7,
                    width: size.width * .73,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: renkler.koyuuRenk,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: FutureBuilder(
                      future: backUpList,
                      builder:(context, snapshot) {
                        if(snapshot.hasData){
                          var data = snapshot.data!.toList();
                          readGglAuth.controlListCount(items: data);
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: size.width * .56,
                                child: Theme (
                                  data: Theme.of(context).copyWith(
                                      colorScheme: ColorScheme.fromSwatch(
                                        accentColor: Theme.of(context).disabledColor,
                                      ),
                                      scrollbarTheme: ScrollbarThemeData(
                                        thumbColor:
                                        MaterialStateProperty.all(Theme.of(context).dialogBackgroundColor),
                                      )),
                                  child: Scrollbar(
                                    thickness: 5,
                                    thumbVisibility: true ,
                                    child: ListView.builder(
                                      itemCount: isclicked ? 1 : data.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(right: 10),
                                          child: isclicked
                                          ?SizedBox(
                                            height: size.width *.5 ,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  height: size.width * .14,
                                                  width: size.width * .14,
                                                  child: CircularProgressIndicator(
                                                    color: Theme.of(context).disabledColor,
                                                    backgroundColor: renkler.koyuuRenk,
                                                  ),
                                                ),
                                                Text(
                                                  "Verileriniz indiriliyor.\n   Lütfen bekleyiniz.",
                                                  style: TextStyle(
                                                    fontFamily: "Nexa3",
                                                    fontSize: 18,
                                                    color: Theme.of(context).disabledColor,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          )
                                          :Column(
                                            children: [
                                             InkWell(
                                               onTap:() async {
                                                 if(selectedIndexList.isNotEmpty){
                                                   if(selectedIndexList.contains(index)){
                                                     setState(() {
                                                      selectedIndexList.remove(index);
                                                     });
                                                   }else{
                                                     setState(() {
                                                       renkdeneme = Colors.orange;
                                                       selectedIndexList.add(index) ;
                                                     });
                                                   }
                                                 }else{
                                                   setState(() {
                                                     isclicked = true;
                                                   });
                                                   try {/// VERİ İNDİRİLİYOR.
                                                    await readGglAuth.downloadGoogleDriveFile("${data[index].id}", "${data[index].name}");
                                                    if(readSettings.Prefix != "TRY"){
                                                      ref.read(currencyRiverpod).calculateAllSQLHistoryTime();
                                                    }
                                                   }catch(e){
                                                     print("Veriler indirilirken hata meydana geldi $e");
                                                   }
                                                   _showInterstitialAd(context);
                                                   Navigator.of(context).pop();
                                                   ScaffoldMessenger.of(context).showSnackBar(
                                                     SnackBar(
                                                       backgroundColor:
                                                       const Color(0xff0D1C26),
                                                       duration: const Duration(seconds: 1),
                                                       content: Text(
                                                         translation(context).dataRestoredFromGoogleDrive,
                                                         style: const TextStyle(
                                                           color: Colors.white,
                                                           fontSize: 16,
                                                           fontFamily: 'Nexa3',
                                                           fontWeight: FontWeight.w600,
                                                           height: 1.3,
                                                         ),
                                                       ),
                                                     ),
                                                   );
                                                 }
                                               },
                                               onLongPress: () {
                                                 setState(() {
                                                  renkdeneme = Colors.orange;
                                                  selectedIndexList.add(index) ;
                                                 });
                                               },
                                               child: Container(
                                                 height: 30,
                                                 padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                                 decoration: BoxDecoration(
                                                   //color: Theme.of(context).indicatorColor,
                                                   color: selectedIndexList.contains(index) ? Theme.of(context).disabledColor.withOpacity(0.9) : Theme.of(context).indicatorColor,
                                                   borderRadius: BorderRadius.circular(6),
                                                 ),
                                                 child: Center(
                                                   child: Row(
                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                     children: [
                                                       Text(
                                                          "${data[index].name}",
                                                         style: const TextStyle(
                                                           fontSize: 13
                                                         ),
                                                       ),
                                                       //Icon(Icons.download_rounded),
                                                       const Icon(Icons.cloud_download_outlined),
                                                     ],
                                                   ),
                                                 ),
                                               ),
                                             ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                            ],
                                          ),
                                        ) ;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              isclicked
                              ?const SizedBox(width: 1)
                              :selectedIndexList.isNotEmpty
                                ?Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: size.height * .026,
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        color: const Color(0xFF1C2B35),
                                        border: Border.all(
                                            color: Colors.white,
                                            width: 1
                                        )
                                      ),
                                      child: InkWell(
                                        onTap: () async {
                                          Navigator.of(context).pop();
                                          for (var element in selectedIndexList) {
                                            readGglAuth.deleteFileWithId(data[element].id).then((value) => readSettings.setisuseinsert());
                                          }
                                          setState(() {
                                            selectedIndexList.clear();
                                          });
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Icon(
                                              Icons.delete_forever,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              "Sil",
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontFamily: "Nexa3",
                                                color: renkler.arkaRenk,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "${selectedIndexList.length} kayıt Seçildi",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: "Nexa3",
                                        color: renkler.arkaRenk,
                                      ),
                                    ),
                                    Container(
                                      height: size.height * .026,
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(7),
                                          color: const Color(0xFF1C2B35),
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 1
                                        )
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            selectedIndexList.clear();
                                          });
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Icon(
                                              Icons.cancel_outlined,
                                              color: Colors.white,
                                              size: 21,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              "iptal",
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontFamily: "Nexa3",
                                                color: renkler.arkaRenk,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                                :Center(
                                  child: Text(
                                    "${translation(context).numberOfRecordsShown} ${data.length}",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: "Nexa3",
                                      color: renkler.arkaRenk,
                                    ),
                                  ),
                                ),
                            ],
                          );
                        }else {
                          return Center(
                            child: Text(
                                "${translation(context).loading} ...",
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          );
                        }
                      },

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