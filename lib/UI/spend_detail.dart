import 'package:butcekontrol/riverpod_management.dart';
import 'package:butcekontrol/utils/date_time_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Pages/update_data_page.dart';
import '../constans/material_color.dart';
import '../models/spend_info.dart';
import 'package:butcekontrol/classes/language.dart';

///örnek kullanım
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
    return spendDetail(item: item, index: index);
    },
);
 */

class SpendDetail extends ConsumerStatefulWidget {
  const SpendDetail({super.key});
  @override
  SpendDetailState createState() => SpendDetailState();
}

class SpendDetailState extends ConsumerState<SpendDetail> {
  @override
  Widget build(BuildContext context) {
    var readDB = ref.read(databaseRiverpod);
    var readHome = ref.read(homeRiverpod);
    var readUpdateData = ref.read(updateDataRiverpod);
    var readDailyInfo = ref.read(dailyInfoRiverpod);
    List<SpendInfo> item = readDailyInfo.getSpendDetailItem();
    int index = readDailyInfo.getSpendDetailIndex();
    CustomColors renkler = CustomColors();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 9),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        "${translation(context).details}  ",
                        style: TextStyle(
                          color: Theme.of(context).dialogBackgroundColor,
                          fontFamily: 'Nexa4',
                          height: 1,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.remove_red_eye,
                      color: Color(0xffF2CB05),
                      size: 34,
                    ),
                    const Spacer(),
                    Container(
                      width: 32,
                      height: 32,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Theme.of(context).dialogBackgroundColor,
                          borderRadius: BorderRadius.circular(36),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Image.asset(
                            "assets/icons/remove.png",
                            height: 18,
                            width: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom:9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(translation(context).dateDetails,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Nexa4',
                          height: 1,
                          fontSize: 18,
                        )),
                    SizedBox(
                      height: 26,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 15.0, top: 2.0),
                            child: Text(
                              "${item[index].operationDate}",
                              style: TextStyle(
                                color: renkler.koyuuRenk,
                                height: 1,
                                fontFamily: 'NEXA3',
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(translation(context).timeDetails,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Nexa4',
                          height: 1,
                          fontSize: 18,
                        )),
                    Text("${item[index].operationTime}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Nexa3',
                          height: 1,
                          fontSize: 18,
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(translation(context).categoryDetails,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Nexa4',
                          height: 1,
                          fontSize: 18,
                        )),
                    Expanded(
                      child: Text("${item[index].category} - ${item[index].userCategory}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Nexa3',
                            height: 1,
                            fontSize: 18,
                          ),
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(translation(context).paymentMethodDetails,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Nexa4',
                          height: 1,
                          fontSize: 18,
                        )),
                    Text("${item[index].operationTool}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Nexa3',
                          height: 1,
                          fontSize: 18,
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(translation(context).amountDetails,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Nexa4',
                          height: 1,
                          fontSize: 18,
                        )),
                    Expanded(
                      child: Text("${item[index].amount} ${item[index].moneyType}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Nexa3',
                            height: 1,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.end,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(translation(context).savingStatusDetails,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Nexa4',
                          height: 1,
                          fontSize: 18,
                        )),
                    item[index].registration == 0
                        ? Text(translation(context).notSaved,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Nexa3',
                              height: 1,
                              fontSize: 18,
                            ))
                        : Text(translation(context).saved,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Nexa3',
                              height: 1,
                              fontSize: 18,
                            )),
                  ],
                ),
              ),
              Visibility(
                visible: item[index].processOnce != '' && item[index].processOnce != '0',
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 9),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("TEKRAR / TAKSİT",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Nexa4',
                                  height: 1,
                                  fontSize: 18,
                                )),
                               Expanded(
                                 child: Text("${item[index].processOnce}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Nexa3',
                                        height: 1,
                                        fontSize: 18,
                                      ),
                                     textAlign: TextAlign.end,
                                     overflow: TextOverflow.ellipsis
                                 ),
                               ),
                          ],
                        ),
                    ),
                  ),
              Visibility(
                visible: item[index].systemMessage != '',
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 9),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("SİSTEM MESAJI",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Nexa4',
                                    height: 1,
                                    fontSize: 18,
                                  )),
                              SizedBox()
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, left: 5),
                            child: Text("${item[index].systemMessage}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Nexa3',
                                  height: 1,
                                  fontSize: 18,
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
              Padding(
                padding: const EdgeInsets.only(bottom: 9),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(translation(context).noteDetails,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Nexa4',
                              height: 1,
                              fontSize: 18,
                            )),
                        SizedBox()
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, left: 5),
                      child: SizedBox(
                        child: item[index].note == ''
                            ? Text(translation(context).noNoteAdded,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Nexa3',
                                  height: 1,
                                  fontSize: 18,
                                ))
                            : Text("${item[index].note}",
                                textAlign: TextAlign.justify,
                            overflow: TextOverflow.ellipsis,
                                maxLines: 6,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Nexa3',
                                  height: 1,
                                  fontSize: 18,
                                )),
                      ),
                    ),
                  ],
                ),
              ),
              ///KAYDETME BUTONU ŞU AN KAPALI
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    /*Column(
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF2CB05),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                readDailyInfo.regChange(item[index].registration);
                                readDailyInfo.updateRegistration(item[index].id);
                                //readDailyInfo.regChange(item[index].registration = item[index].registration == 0 ? 1 : 0);
                                //Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: const Color(0xff0D1C26),
                                    duration: const Duration(seconds: 1),
                                    content: item[index].registration == 1
                                        ? const Text(
                                      'İşaret Kaldırıldı',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'Nexa3',
                                        fontWeight: FontWeight.w600,
                                        height: 1.3,
                                      ),
                                    )
                                        : const Text(
                                      'İşaret Eklendi',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'Nexa3',
                                        fontWeight: FontWeight.w600,
                                        height: 1.3,
                                      ),
                                    ),
                                  ),
                                );
                              });
                            },
                            iconSize: 30,
                            icon: item[index].registration == 0
                                ? const Icon(Icons.bookmark_outline)
                                : const Icon(Icons.bookmark_outlined),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 4.0),
                          child: Text(
                            "İşaretle",
                            style: TextStyle(
                              color: Color(0xFFF2CB05),
                              fontFamily: 'Nexa3',
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),*/
                    Column(
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: Theme.of(context).dialogBackgroundColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              Icons.delete,
                              size: 32,
                              color: renkler.koyuuRenk,
                            ),
                            onPressed: () {
                              readHome.setStatus();
                              readDB.delete(item[index].id!);
                              readDB.myMethod2();
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: const Color(0xff0D1C26),
                                  duration: const Duration(seconds: 1),
                                  content: Text(
                                    translation(context).activityDeleted,
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
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: Text(
                            translation(context).deleteDetails,
                            style: TextStyle(
                              color: Theme.of(context).dialogBackgroundColor,
                              fontFamily: 'Nexa3',
                              height: 1,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 42,
                          width: 42,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF2CB05),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                Icons.refresh_rounded,
                                size: 36,
                                color: renkler.koyuuRenk,
                              ),
                              onPressed: () {
                                readUpdateData.setMenu(1);
                                String time = DateTimeManager.getCurrentDayMonthYear() ;
                                List <String> parts = time.split(".");
                                int parseDay = int.parse(parts[0]);
                                int parseMonth = int.parse(parts[1]);
                                int parseYear = int.parse(parts[2]);
                                readUpdateData.setItems(SpendInfo.withId(
                                    item[index].id!,
                                    item[index].operationType,
                                    item[index].category,
                                    item[index].operationTool,
                                    item[index].registration,
                                    item[index].amount,
                                    item[index].note,
                                    parseDay.toString(),
                                    parseMonth.toString(),
                                    parseYear.toString(),
                                    DateTimeManager.getCurrentTime(),
                                    time,
                                    item[index].moneyType,
                                    item[index].processOnce,
                                    item[index].realAmount,
                                    item[index].userCategory,
                                    item[index].systemMessage));
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const UpdateData(),
                                ));
                              },
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 6.0),
                          child: Text(
                            "Tekrar Ekle",
                            style: TextStyle(
                              color: Color(0xFFF2CB05),
                              fontFamily: 'Nexa3',
                              height: 1,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 42,
                          width: 42,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF2CB05),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                Icons.create_rounded,
                                size: 36,
                                color: renkler.koyuuRenk,
                              ),
                              onPressed: () {
                                readUpdateData.setMenu(0);
                                readUpdateData.setItems(SpendInfo.withId(
                                    item[index].id!,
                                    item[index].operationType,
                                    item[index].category,
                                    item[index].operationTool,
                                    item[index].registration,
                                    item[index].amount,
                                    item[index].note,
                                    item[index].operationDay,
                                    item[index].operationMonth,
                                    item[index].operationYear,
                                    item[index].operationTime,
                                    item[index].operationDate,
                                    item[index].moneyType,
                                    item[index].processOnce,
                                    item[index].realAmount,
                                    item[index].userCategory,
                                    item[index].systemMessage));
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const UpdateData(),
                                ));
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: Text(
                            translation(context).edit,
                            style: const TextStyle(
                              color: Color(0xFFF2CB05),
                              fontFamily: 'Nexa3',
                              height: 1,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
  }

  Widget widget01(var item, var index) {
    //not uzunluğuna karşın taşmayı önlemek için kurulmuştur.
    String longText = item[index].note;
    List<String> parts = [];

    while (longText.isNotEmpty) {
      if (longText.length > 25) {
        parts.add(longText.substring(0, 30));
        longText = longText.substring(30);
      } else {
        parts.add(longText);
        longText = '';
      }
    }

    List<Text> textWidgets = parts
        .map((line) => Text(
              line,
              style: const TextStyle(
                  color: Colors.white, fontFamily: "Nexa3",height: 1, fontSize: 18),
            ))
        .toList();

    return Column(
      children: textWidgets,
    );
  }
}
