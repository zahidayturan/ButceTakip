import 'package:butcekontrol/UI/spend_detail.dart';
import 'package:butcekontrol/classes/language.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/utils/textConverter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../riverpod_management.dart';
class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var readSettings = ref.read(settingsRiverpod);
    var dbRiv = ref.watch(databaseRiverpod);
    var readDailyRiv = ref.read(dailyInfoRiverpod);
    var size = MediaQuery.of(context).size ;
    var renkler = CustomColors();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          onTap: () {
            dbRiv.resetSearchListTile();
            Navigator.of(context).pop();
          },
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black.withOpacity(0.5),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height : 60,
                    color: renkler.koyuuRenk,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: size.height * .05,
                          width : size.width * 0.65,
                          decoration: BoxDecoration(
                            color: renkler.arkaRenk,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: TextField(
                              onChanged: (value) {
                                if(value != ""){
                                  dbRiv.searchText = value;
                                  dbRiv.searchItem(Converter().textConverterToDBForSearch(_controller.text, context, 0));
                                }else{
                                  dbRiv.resetSearchListTile();
                                }
                              },
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              controller: _controller,
                              decoration: InputDecoration(
                                hintText: translation(context).searchActivity,
                                hintStyle: const TextStyle(
                                  color: Colors.black,
                                  height: 1
                                ),
                                contentPadding: EdgeInsets.symmetric(horizontal: size.width * .01,vertical: 13),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if(_controller.text != ""){
                              dbRiv.setSearcSort();
                              dbRiv.searchItem(_controller.text);
                            }
                          },
                          child: Container(
                            width: size.width * .085,
                            height: size.width * .085,
                            decoration: BoxDecoration(
                                color: dbRiv.searchSort ? Colors.orangeAccent : Theme.of(context).disabledColor ,
                                shape: BoxShape.circle
                            ),
                            child: Transform.rotate(
                                angle: 3.14 / 2,
                                child: const Icon(
                                    Icons.swap_horiz,
                                  color: Colors.black,
                                )
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            dbRiv.resetSearchListTile();
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: size.width * .085,
                            height: size.width * .085,
                            decoration: BoxDecoration(
                                color: Theme.of(context).disabledColor,
                                shape: BoxShape.circle
                            ),
                            child: const Icon(
                              Icons.close_sharp,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * .01),
                  dbRiv.searchListTile?.length == 0 || dbRiv.searchListTile == null
                      ?Padding(
                        padding:  EdgeInsets.only(top: size.height * .01),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Theme.of(context).disabledColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            translation(context).noMatchData,
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: "Nexa3",
                                height: 1
                            ),
                          ),
                        ),
                      )
                    :Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * .04),
                    child: SizedBox(
                      height: size.height * .75,
                      child: ListView.builder(
                        itemCount: dbRiv.searchListTile!.length,
                        itemBuilder: (context, index) {
                          DateTime itemDate = DateTime(int.tryParse(dbRiv.searchListTile![index].operationYear!)!,int.tryParse(dbRiv.searchListTile![index].operationMonth!)!,int.tryParse(dbRiv.searchListTile![index].operationDay!)!);
                          String formattedDate = DateFormat(readSettings.dateFormat).format(itemDate);
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  readDailyRiv.setSpendDetail(dbRiv.searchListTile!, index);
                                  showModalBottomSheet(
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(25))),
                                    backgroundColor:
                                    const Color(0xff0D1C26),
                                    builder: (context) {
                                      // genel bilgi sekmesi açılıyor.
                                      return SpendDetail();
                                    },
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.only(right: size.width * .04),
                                  height: size.height * .088,
                                  decoration: BoxDecoration(
                                    color: renkler.koyuuRenk,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 6,
                                        height: size.height * .055 ,
                                        decoration: BoxDecoration(
                                            color: dbRiv.searchListTile![index].operationType == "Gelir"
                                                ?renkler.yesilRenk
                                                :renkler.kirmiziRenk,
                                            borderRadius: BorderRadius.horizontal(right: Radius.circular(12))
                                        ),
                                      ),
                                      SizedBox(
                                        width: size.width * .82,
                                        height: size.height * .072,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: size.width * .30,
                                                  child: Text(
                                                    Converter().textConverterFromDB(dbRiv.searchListTile![index].category!, context, 0),
                                                    style: TextStyle(
                                                        color: renkler.arkaRenk,
                                                        fontSize: 16
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: size.width * .28,
                                                  child: Text(
                                                    formattedDate,
                                                    style: TextStyle(
                                                        color: renkler.arkaRenk,
                                                        fontSize: 16
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: size.width * .225,
                                                  child: Align(
                                                    alignment: Alignment.centerRight,
                                                    child: RichText(
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        text: TextSpan(children: [
                                                          TextSpan(
                                                            text:  "${dbRiv.searchListTile![index].realAmount}",
                                                            style: TextStyle(
                                                              height: 1,
                                                              color: renkler.arkaRenk,
                                                              fontFamily:
                                                              "Nexa3",
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: readSettings.prefixSymbol,
                                                            style: TextStyle(
                                                              height: 1,
                                                              color: renkler.arkaRenk,
                                                              fontFamily:
                                                              "TL",
                                                              fontSize: 17,
                                                            ),
                                                          ),
                                                        ]
                                                        )
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width : size.width * .7,
                                                  child: Text(
                                                    dbRiv.searchListTile![index].note != ""
                                                        ?"${dbRiv.searchListTile![index].note}"
                                                        :"Not Eklenmemiş.",
                                                    style: TextStyle(
                                                        color: renkler.arkaRenk,
                                                        fontSize: 16
                                                    ),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Theme.of(context).disabledColor,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      /*
                                     SizedBox(
                                       width: size.width * .9,
                                         child: Text(
                                             "${dbRiv.searchListTile![index].operationDate}",
                                           style: TextStyle(
                                             color: renkler.arkaRenk,
                                             fontSize: 16
                                           ),
                                         )
                                     )
                                      */
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: size.height * .007),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  /*
                  FutureBuilder(
                    future: dbRiv.searchListTile,
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        var data = snapshot!.data;
                        return ListView.builder(
                          itemCount: data!.length,//kayıt sayısı
                          itemBuilder: (context, index) {//her kayıtın görünümü
                          },
                        );
                      }else{
                        return CircularProgressIndicator();
                      }
                    },
                  ),

                   */
                  dbRiv.searchListTile?.length == 0 || dbRiv.searchListTile == null
                      ? SizedBox(width : 1)
                      : Padding(
                      padding: EdgeInsets.symmetric(horizontal:size.width * .07, vertical: size.height * 0.02),
                      child: FittedBox(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          decoration: BoxDecoration(
                            //border: Border.all(),
                            borderRadius: BorderRadius.circular(8),
                            color: Theme.of(context).highlightColor,
                            border: Border.all(
                              color: Colors.white,
                              strokeAlign: 1,
                              width: 1
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "${translation(context).numberOfActivitiesForSearchSection} ${dbRiv.searchListTile?.length ?? 0}",
                              style: TextStyle(
                                color: Theme.of(context).disabledColor,
                                height: 1
                              ),
                            ),
                          ),
                        ),
                      )
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
