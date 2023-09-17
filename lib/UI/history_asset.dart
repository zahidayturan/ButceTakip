import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/models/spend_info.dart';
import 'package:butcekontrol/utils/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../classes/language.dart';
import '../constans/text_pref.dart';
import '../riverpod_management.dart';

class HistoryAsset extends ConsumerStatefulWidget{
  const HistoryAsset({Key? key}) : super(key: key);

  @override
  ConsumerState<HistoryAsset> createState() => _HistoryAsset();
}

class _HistoryAsset extends ConsumerState<HistoryAsset> {
  final PageController _controller = PageController(initialPage: 0);
  String errormessage = "";
  bool isEdit = false ;
  @override
  Widget build(BuildContext context) {
    ref.watch(settingsRiverpod).isuseinsert;
    var size = MediaQuery.of(context).size;
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
                  height: size.height * .42,
                  width: size.width * .75,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Text(
                        translation(context).myPastAssetRecords,
                        style: TextStyle(
                            color: Theme.of(context).secondaryHeaderColor,
                            height: 1.1,
                            fontSize: 14
                          ),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 10),
                      customToogleSwitch(context),
                      const SizedBox(height: 10),
                      Expanded(
                        child: PageView(
                          controller: _controller,
                          onPageChanged: (value) {
                            setStatus(value);
                          },
                          children: [
                            FutureBuilder(
                              future: SQLHelper.getItemsAssets("Nakit"),
                              builder: (context, snapshot) {
                                if(snapshot.hasData){
                                  List<SpendInfo>? list = snapshot.data ;
                                  return list!.isEmpty
                                  ?SizedBox(
                                    height: 150,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/image/noInfo.png",
                                          width: 75,
                                          height: 75,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          height: 15,
                                          width: 80,
                                          child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                color: Theme.of(context).canvasColor,
                                              ),
                                              child: Center(child: TextMod(
                                                  translation(context).noActivity, Theme.of(context).primaryColor, 11))
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                  :ListView.builder(
                                    itemCount: list.length,
                                    itemBuilder:(context, index) {
                                      var date = list[index].operationDate ?? "00.00.0000";
                                      DateTime dateForFormat = DateTime(int.parse(date.split(".")[2]),int.parse(date.split(".")[1]),int.parse(date.split(".")[0]));
                                      return Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric( vertical: size.height * .006),
                                            height : size.height * .045,
                                            width: size.width,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              color: Theme.of(context).indicatorColor
                                            ),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: size.width * .01,
                                                  height: size.height * .024,
                                                  decoration: BoxDecoration(
                                                    color: list[index].operationType == "Gelir" ? Color(0xFF1A8E58) : Color(0xFFD91A2A),
                                                    borderRadius: BorderRadius.horizontal(right: Radius.circular(2)),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: isEdit ? size.width * .65 - 30 : size.width * .65,
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                    child: Row(
                                                      mainAxisAlignment : MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          DateFormat(ref.read(settingsRiverpod).dateFormat).format(dateForFormat),
                                                          style: TextStyle(
                                                              color: Theme.of(context).canvasColor,
                                                              height: 1.1,
                                                              fontSize: 14
                                                          ),
                                                          textAlign: TextAlign.justify,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment : MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text(
                                                              "${list[index].amount}",
                                                              style: TextStyle(
                                                                color: list[index].operationType == "Gelir" ? Theme.of(context).canvasColor : Color(0xFFD91A2A),
                                                                height: 1.1,
                                                                fontSize: 14
                                                              ),
                                                            ),
                                                            SizedBox(width: 5),
                                                            Text(
                                                              "${list[index].moneyType!.substring(0,3)}",
                                                              style: TextStyle(
                                                                  color: list[index].operationType == "Gelir" ? Theme.of(context).canvasColor : Color(0xFFD91A2A),
                                                                  height: 1.1,
                                                                  fontSize: 14
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                isEdit
                                                ?GestureDetector(
                                                  onTap: () async {
                                                    await SQLHelper.deleteItem(list[index].id!);
                                                    ref.watch(settingsRiverpod).setisuseinsert();
                                                  },
                                                  child: const Icon(
                                                    Icons.delete,
                                                    color: Color(0xFFD91A2A),
                                                    size: 18,
                                                  ),
                                                )
                                                :const SizedBox(),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 7)
                                        ],
                                      );
                                    },
                                  );
                                }else{
                                  return SizedBox();
                                }
                              },
                            ),
                            FutureBuilder(
                              future: SQLHelper.getItemsAssets("Kart"),
                              builder: (context, snapshot) {
                                if(snapshot.hasData){
                                  List<SpendInfo>? list = snapshot.data ;
                                  return list!.isEmpty
                                  ?SizedBox(
                                      height: 150,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/image/noInfo.png",
                                            width: 75,
                                            height: 75,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            height: 15,
                                            width: 80,
                                            child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  color: Theme.of(context).canvasColor,
                                                ),
                                                child: Center(child: TextMod(
                                                    translation(context).noActivity, Theme.of(context).primaryColor, 11))
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                   :ListView.builder(
                                    itemCount: list.length,
                                    itemBuilder:(context, index) {
                                      return Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric( vertical: size.height * .006),
                                            height : size.height * .045,
                                            width: size.width,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8),
                                                color: Theme.of(context).indicatorColor
                                            ),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: size.width * .01,
                                                  height: size.height * .024,
                                                  decoration: BoxDecoration(
                                                    color: list[index].operationType == "Gelir" ? Color(0xFF1A8E58) : Color(0xFFD91A2A),
                                                    borderRadius: BorderRadius.horizontal(right: Radius.circular(2)),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: isEdit ? size.width * .65 - 30 : size.width * .65,
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                    child: Row(
                                                      mainAxisAlignment : MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          "${list[index].operationDate}",
                                                          style: TextStyle(
                                                              color: Theme.of(context).canvasColor,
                                                              height: 1.1,
                                                              fontSize: 14
                                                          ),
                                                          textAlign: TextAlign.justify,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment : MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text(
                                                              "${list[index].amount}",
                                                              style: TextStyle(
                                                                  color: list[index].operationType == "Gelir" ? Theme.of(context).canvasColor : Color(0xFFD91A2A),
                                                                  height: 1.1,
                                                                  fontSize: 14
                                                              ),
                                                            ),
                                                            SizedBox(width: 5),
                                                            Text(
                                                              "${list[index].moneyType!.substring(0,3)}",
                                                              style: TextStyle(
                                                                  color: list[index].operationType == "Gelir" ? Theme.of(context).canvasColor : Color(0xFFD91A2A),
                                                                  height: 1.1,
                                                                  fontSize: 14
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                isEdit
                                                ?GestureDetector(
                                                    onTap: () async {
                                                      await SQLHelper.deleteItem(list[index].id!);
                                                      ref.watch(settingsRiverpod).setisuseinsert();
                                                    },
                                                    child: const Icon(
                                                      Icons.delete,
                                                      color: Color(0xFFD91A2A),
                                                      size: 18,
                                                    ),
                                                  )
                                                :const SizedBox(),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 7)
                                        ],
                                      );
                                    },
                                  );
                                }else{
                                  return SizedBox();
                                }
                              },
                            ),
                            FutureBuilder(
                              future: SQLHelper.getItemsAssets("Diger"),
                              builder: (context, snapshot) {
                                if(snapshot.hasData){
                                  List<SpendInfo>? list = snapshot.data ;
                                  return list!.isEmpty
                                  ?SizedBox(
                                      height: 150,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/image/noInfo.png",
                                            width: 75,
                                            height: 75,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          SizedBox(
                                            height: 15,
                                            width: 80,
                                            child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  color: Theme.of(context).canvasColor,
                                                ),
                                                child: Center(child: TextMod(
                                                    translation(context).noActivity, Theme.of(context).primaryColor, 11))
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  :ListView.builder(
                                    itemCount: list.length,
                                    itemBuilder:(context, index) {
                                      return Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric( vertical: size.height * .006),
                                            height : size.height * .045,
                                            width: size.width,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8),
                                                color: Theme.of(context).indicatorColor
                                            ),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: size.width * .01,
                                                  height: size.height * .024,
                                                  decoration: BoxDecoration(
                                                    color: list[index].operationType == "Gelir" ? Color(0xFF1A8E58) : Color(0xFFD91A2A),
                                                    borderRadius: BorderRadius.horizontal(right: Radius.circular(2)),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: isEdit ? size.width * .65 - 30 : size.width * .65,
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                    child: Row(
                                                      mainAxisAlignment : MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          "${list[index].operationDate}",
                                                          style: TextStyle(
                                                              color: Theme.of(context).canvasColor,
                                                              height: 1.1,
                                                              fontSize: 14
                                                          ),
                                                          textAlign: TextAlign.justify,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment : MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text(
                                                              "${list[index].amount}",
                                                              style: TextStyle(
                                                                  color: list[index].operationType == "Gelir" ? Theme.of(context).canvasColor : Color(0xFFD91A2A),
                                                                  height: 1.1,
                                                                  fontSize: 14
                                                              ),
                                                            ),
                                                            SizedBox(width: 5),
                                                            Text(
                                                              "${list[index].moneyType!.substring(0,3)}",
                                                              style: TextStyle(
                                                                  color: list[index].operationType == "Gelir" ? Theme.of(context).canvasColor : Color(0xFFD91A2A),
                                                                  height: 1.1,
                                                                  fontSize: 14
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                isEdit
                                                  ?GestureDetector(
                                                  onTap: () async {
                                                    await SQLHelper.deleteItem(list[index].id!);
                                                    ref.watch(settingsRiverpod).setisuseinsert();
                                                  },
                                                  child: const Icon(
                                                    Icons.delete,
                                                    color: Color(0xFFD91A2A),
                                                    size: 18,
                                                  ),
                                                )
                                                :const SizedBox(),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 7)
                                        ],
                                      );
                                    },
                                  );
                                }else{
                                  return SizedBox();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isEdit = isEdit ? false : true;
                              });
                            },
                            child: Container(
                              width: size.width * .26,
                              padding: EdgeInsets.symmetric(vertical: size.height * .007, horizontal: size.width *.02),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).highlightColor,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Theme.of(context).canvasColor.withOpacity(0.5),
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 3,
                                        spreadRadius: 1
                                    )
                                  ]
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    isEdit ? translation(context).doneBitti :translation(context).edit,
                                    style: TextStyle(
                                        color: Theme.of(context).unselectedWidgetColor,
                                        fontSize: 14,
                                        height: 1
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Icon(
                                    isEdit ? Icons.done :Icons.edit,
                                    size: 16,
                                    color: Theme.of(context).unselectedWidgetColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              width: size.width * .26,
                              padding: EdgeInsets.symmetric(vertical: size.height * .007, horizontal: size.width *.02),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).highlightColor,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Theme.of(context).canvasColor.withOpacity(0.5),
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 3,
                                        spreadRadius: 1
                                    )
                                  ]
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    translation(context).close,
                                    style: TextStyle(
                                        color: Theme.of(context).unselectedWidgetColor,
                                        fontSize: 14,
                                        height: 1
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Icon(
                                    Icons.close,
                                    size: 16,
                                    color: Theme.of(context).unselectedWidgetColor,
                                  ),
                                ],
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

  double heightTool_ = 22;
  double heightTool2_ = 28;
  double heightTool3_ = 22;
  Color _containerColorTool3 = const Color(0xFF1C2B35);
  Color _containerColorTool2 = const Color(0xFF1C2B35);
  Color _containerColorTool = const Color(0xffF2CB05);
  Color _textColorTool = const Color(0xFF1C2B35);
  Color _textColorTool2 = Color(0xFFE9E9E9);
  Color _textColorTool3 = Color(0xFFE9E9E9);
  int index = 0;
  bool st = false ;
  Widget customToogleSwitch(BuildContext context) {
    var size = MediaQuery.of(context).size;
    CustomColors renkler = CustomColors();
    return SizedBox(
      height: 28,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Container(
              decoration:  BoxDecoration(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                color: renkler.koyuAraRenk,
              ),
              height: 22,
              width: size.width*0.75-30,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    setStatus(0,remote: true);
                  });
                },
                child: AnimatedContainer(
                  width: size.width*0.25-10,
                  duration: const Duration(milliseconds: 50),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                    color: _containerColorTool,
                  ),
                  height: heightTool2_,
                  child: Center(
                    child: Text(translation(context).cashAsset,
                        style: TextStyle(
                            color: _textColorTool,
                            fontSize: 13,
                            fontFamily: 'Nexa3',
                            height: 1)),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    setStatus(1,remote: true);
                  });
                },
                child: AnimatedContainer(
                  width: size.width*0.25-10,
                  duration: const Duration(milliseconds: 50),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                    color: _containerColorTool2,
                  ),
                  height: heightTool_,
                  child: Center(
                    child: Text(translation(context).cardAsset,
                        style: TextStyle(
                          color: _textColorTool2,
                          fontSize: 13,
                          height: 1,
                          fontFamily: 'Nexa3',
                        )),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    setStatus(2,remote:  true);
                  });
                },
                child: AnimatedContainer(
                  width: size.width*0.25-10,
                  duration: const Duration(milliseconds: 50),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                    color: _containerColorTool3,
                  ),
                  height: heightTool3_,
                  child: Center(
                    child: Text(translation(context).other,
                        style: TextStyle(
                            color: _textColorTool3,
                            fontSize: 13,
                            fontFamily: 'Nexa3',
                            height: 1)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void setStatus(int index, {bool? remote = false}) {
    remote == true ? _controller.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.linear).then((value) {

    }): null;
    if(!remote!){
      if (index == 0) {
        setState(() {
          heightTool2_ = 28;
          heightTool_ = 22;
          heightTool3_ = 22;
          _containerColorTool = const Color(0xffF2CB05);
          _containerColorTool2 = const Color(0xFF1C2B35);
          _containerColorTool3 = const Color(0xFF1C2B35);
          _textColorTool = const Color(0xff0D1C26);
          _textColorTool2 = Color(0xFFE9E9E9);
          _textColorTool3 = Color(0xFFE9E9E9);
        });
      } else if (index == 1) {
        setState(() {
          heightTool_ = 28;
          heightTool2_ = 22;
          heightTool3_ = 22;
          _containerColorTool2 = const Color(0xffF2CB05);
          _containerColorTool = const Color(0xFF1C2B35);
          _containerColorTool3 = const Color(0xFF1C2B35);
          _textColorTool = Color(0xFFE9E9E9);
          _textColorTool2 = const Color(0xFF1C2B35);
          _textColorTool3 = Color(0xFFE9E9E9);
        });
      } else {
        setState(() {
          heightTool_ = 22;
          heightTool2_ = 22;
          heightTool3_ = 28;
          _containerColorTool3 = const Color(0xffF2CB05);
          _containerColorTool = const Color(0xFF1C2B35);
          _containerColorTool2 = const Color(0xFF1C2B35);
          _textColorTool = Color(0xFFE9E9E9);
          _textColorTool2 = Color(0xFFE9E9E9);
          _textColorTool3 = const Color(0xFF1C2B35);
        });
      }

    }
  }
}