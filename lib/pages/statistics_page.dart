import 'package:butcekontrol/classes/app_bar_for_page.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/pages/category_info_page.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:butcekontrol/utils/interstitial_ads.dart';
import 'package:butcekontrol/utils/textConverter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:d_chart/d_chart.dart';
import 'package:butcekontrol/classes/language.dart';
import 'package:intl/intl.dart' as intl;

class Statistics extends ConsumerWidget {
  const Statistics({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarForPage(title: translation(context).statisticsTitle),
        body: const StaticticsBody(),
      ),
    );
  }
}

class StaticticsBody extends ConsumerStatefulWidget {
  const StaticticsBody({Key? key}) : super(key: key);
  @override
  ConsumerState<StaticticsBody> createState() => _StaticticsBody();
}

class _StaticticsBody extends ConsumerState<StaticticsBody> {
  @override
  Widget build(BuildContext context) {
    ref.listen(databaseRiverpod, (previous, next) {
      ref.watch(databaseRiverpod).isuseinsert;
      ref.watch(databaseRiverpod).updatest;
      //myCategoryList(context);
      return ref.watch(databaseRiverpod);
    });
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const SizedBox(height: 10),
        Directionality(
          textDirection: TextDirection.ltr,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              leftInfoButton(context),
              Expanded(
                child: SizedBox(
                  height: size.height * 0.26,
                  child: pasta(context),
                ),
              ),
              rightInfoButton(context),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        filterAdd(context),
        const SizedBox(
          height: 8,
        ),
        Expanded(
          child: SizedBox(
              width: size.width * 0.98, child: myCategoryList(context)),
        ),
        /*SizedBox(
          child: Text(
              "data ${validDateMenu} tür ${giderGelirHepsi} yıl ${selectedYearIndex} ay ${selectedMonthIndex} hafta ${selectedWeekIndex} gün ${selectedDayIndex}"),
        ),*/
      ],
    );
  }
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
    super.dispose();
  }

  String operationType = 'Hepsi';
  int day = DateTime.now().day;
  int month = DateTime.now().month;
  int year = DateTime.now().year;
  int week = (DateTime.now().day / 7).ceil();
  int dateType = 1;
  int registration = 0;
  List<String> operationTool = ['Hepsi'];

  List<String> createItemListForType(BuildContext context) {
    return [
      translation(context).income,
      translation(context).expenses,
      translation(context).both,
    ];
  }

  List<String> createItemListForTool(BuildContext context) {
    return [
      translation(context).cash,
      translation(context).card,
      translation(context).otherPaye,
    translation(context).all,
    ];
  }

  List<String> dateTypeList(BuildContext context) {
    return [
      translation(context).yearly,
      translation(context).monthly,
      translation(context).weekly,
      translation(context).daily,
      translation(context).period,
    ];
  }

  String selectedValueTypes(String value, BuildContext context) {
    return translation(context).both;
  }

  String? selectedValueDate;
  String? selectedValueType;
  List<String> selectedItemsTool = [];
  List<String> selectedItemsToolToData = [];


  Widget filterAdd(BuildContext context) {
    var readStatistics = ref.read(statisticsRiverpod);
    var readSettings = ref.read(settingsRiverpod);
    var darkMode = readSettings.DarkMode;
    var adEventCounter = readSettings.adEventCounter;
    var size = MediaQuery.of(context).size;
    CustomColors renkler = CustomColors();
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: size.width * 0.92,
        height: 30,
        decoration: BoxDecoration(
          //color: Theme.of(context).highlightColor,
          color: renkler.koyuuRenk,
          border: Border.all(
              color: Theme.of(context).highlightColor, // Set border color
              width: 1,
          strokeAlign: BorderSide.strokeAlignInside),
            boxShadow: darkMode == 1 ? [
              BoxShadow(
                color: Colors.black54.withOpacity(0.8),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(-1, 2),
              )
            ] : [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 0.5,
                  blurRadius: 2,
                  offset: const Offset(0, 2)
              )],
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(
          translation(context).tapToFilter,
          style: TextStyle(
                color: renkler.arkaRenk, fontFamily: 'Nexa3', fontSize: 15, height: 1),
        ),
            )),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  contentPadding: const EdgeInsets.only(top: 10, bottom: 10),
                  insetPadding: const EdgeInsets.symmetric(horizontal: 15),
                  backgroundColor: Theme.of(context).primaryColor,
                  shadowColor: Colors.black54,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: SizedBox(
                              width: size.width * 0.95,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    translation(context).statisticsFiltering,
                                    style: TextStyle(
                                        color: Theme.of(context).canvasColor,
                                        fontFamily: "Nexa4",
                                        fontSize: 21),
                                  ),
                                  SizedBox(
                                    height: 32,
                                    width: 32,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).canvasColor,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      child: IconButton(
                                        icon: Image.asset(
                                          "assets/icons/remove.png",
                                          height: 16,
                                          width: 16,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        iconSize: 24,
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 14.0,
                          ),
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 1),
                                child: Container(
                                  height: 30,
                                  width: size.width * 0.95,
                                  color: Theme.of(context).highlightColor,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, right: 8),
                                child: SizedBox(
                                  height: 32,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Text(
                                          translation(context).activityType,
                                          style: TextStyle(
                                              color: renkler.arkaRenk,
                                              fontSize: 15,
                                              fontFamily: 'Nexa3'),
                                        ),
                                      ),
                                      Container(
                                        height: 36,
                                        //width: 100,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).disabledColor,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton2<String>(
                                            isExpanded: true,
                                            hint: Center(
                                              child: Text(
                                                translation(context).both,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily: 'Nexa4',
                                                  color: renkler.koyuuRenk,
                                                ),
                                              ),
                                            ),
                                            items: createItemListForType(
                                                    context)
                                                .map((String item) =>
                                                    DropdownMenuItem<String>(
                                                      value: item,
                                                      child: Center(
                                                        child: Text(
                                                          item,
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              height: 1,
                                                              fontFamily:
                                                                  'Nexa4',
                                                              color: renkler
                                                                  .koyuuRenk),
                                                        ),
                                                      ),
                                                    ))
                                                .toList(),
                                            value: selectedValueType,
                                            onChanged: (String? value) {
                                              setState(() {
                                                selectedValueType = value;
                                              });
                                            },
                                            iconStyleData: const IconStyleData(
                                              iconSize: 0,
                                            ),
                                            dropdownStyleData:
                                                DropdownStyleData(

                                                    ///açılmış kutu
                                                    decoration: BoxDecoration(
                                              color: renkler.arkaRenk,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                            )),
                                            buttonStyleData: ButtonStyleData(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                height: 36,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Theme.of(context).disabledColor,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(10))

                                                    ///AÇILMAMIŞ KUTU
                                                    )),
                                            menuItemStyleData:
                                                MenuItemStyleData(
                                              ///açılmış kutu
                                              height: 32,
                                              overlayColor:
                                                  MaterialStatePropertyAll(
                                                      Theme.of(context).disabledColor),
                                              padding: const EdgeInsets.all(8),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 1),
                                child: Container(
                                  height: 30,
                                  width: size.width * 0.95,
                                  color: Theme.of(context).highlightColor,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, right: 8),
                                child: SizedBox(
                                  height: 32,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Text(
                                          translation(context).dateStatistics,
                                          style: TextStyle(
                                              color: renkler.arkaRenk,
                                              fontSize: 15,
                                              fontFamily: 'Nexa3'),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            height: 36,
                                            //width: 100,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context).disabledColor,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                            ),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton2<String>(
                                                isExpanded: true,
                                                hint: Center(
                                                  child: Text(
                                                    translation(context)
                                                        .monthly,
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      fontFamily: 'Nexa4',
                                                      color: renkler.koyuuRenk,
                                                    ),
                                                  ),
                                                ),
                                                items: dateTypeList(context)
                                                    .map((String item) =>
                                                        DropdownMenuItem<
                                                            String>(
                                                          value: item,
                                                          child: Center(
                                                            child: Text(
                                                              item,
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  height: 1,
                                                                  fontFamily:
                                                                      'Nexa4',
                                                                  color: renkler
                                                                      .koyuuRenk),
                                                            ),
                                                          ),
                                                        ))
                                                    .toList(),
                                                value: selectedValueDate,
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    selectedValueDate = value;
                                                  });
                                                },
                                                iconStyleData:
                                                    const IconStyleData(
                                                  iconSize: 0,
                                                ),
                                                dropdownStyleData:
                                                    DropdownStyleData(
                                                        width: 100,

                                                        ///açılmış kutu
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              renkler.arkaRenk,
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          10)),
                                                        )),
                                                buttonStyleData:
                                                    ButtonStyleData(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 4),
                                                        height: 36,
                                                        width: 80,
                                                        decoration: BoxDecoration(
                                                            color: renkler
                                                                .sariRenk,
                                                            borderRadius:
                                                                const BorderRadius
                                                                        .all(
                                                                    Radius
                                                                        .circular(
                                                                            10))

                                                            ///AÇILMAMIŞ KUTU
                                                            )),
                                                menuItemStyleData:
                                                    MenuItemStyleData(
                                                  ///açılmış kutu
                                                  height: 32,
                                                  overlayColor:
                                                      MaterialStatePropertyAll(
                                                          Theme.of(context).disabledColor),
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          dateMenu(context, selectedValueDate)
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 1),
                                child: Container(
                                  height: 30,
                                  width: size.width * 0.95,
                                  color: Theme.of(context).highlightColor,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, right: 8),
                                child: SizedBox(
                                  height: 32,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Text(
                                          translation(context).onlySavedActivities,
                                          style: TextStyle(
                                              color: renkler.arkaRenk,
                                              fontSize: 15,
                                              fontFamily: 'Nexa3'),
                                        ),
                                      ),
                                      Container(
                                        height: 36,
                                        width: 86,
                                        decoration: BoxDecoration(
                                            color: Theme.of(context).disabledColor,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                        child: InkWell(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          onTap: () {
                                            registration == 0
                                                ? registration = 1
                                                : registration = 0;
                                            setState(() {});
                                          },
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              if (registration == 1)
                                                Icon(
                                                  Icons.check_box_rounded,
                                                  color: renkler.koyuuRenk,
                                                )
                                              else
                                                Icon(
                                                  Icons
                                                      .check_box_outline_blank_rounded,
                                                  color: renkler.koyuuRenk,
                                                ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 2),
                                                child: Text(
                                                  registration == 1
                                                      ? translation(context).yesBig
                                                      : translation(context).noBig,
                                                  style: TextStyle(
                                                      color: renkler.koyuuRenk,
                                                      fontFamily: 'Nexa4',
                                                      height: 1,
                                                      fontSize: 13),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 1),
                                child: Container(
                                  height: 30,
                                  width: size.width * 0.95,
                                  color: Theme.of(context).highlightColor,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, right: 8),
                                child: SizedBox(
                                  height: 32,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Text(
                                          translation(context).paymentMethodStatistics,
                                          style: TextStyle(
                                              color: renkler.arkaRenk,
                                              fontSize: 15,
                                              fontFamily: 'Nexa3'),
                                        ),
                                      ),
                                      Container(
                                        height: 36,
                                        //width: 100,
                                        decoration: BoxDecoration(
                                            color: Theme.of(context).disabledColor,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton2<String>(
                                            isExpanded: true,
                                            hint: Center(
                                              child: Text(
                                                translation(context).all,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  height: 1,
                                                  fontFamily: 'Nexa4',
                                                  color: renkler.koyuuRenk,
                                                ),
                                              ),
                                            ),
                                            items:
                                                createItemListForTool(context)
                                                    .map((item) {
                                              return DropdownMenuItem(
                                                value: item,
                                                //disable default onTap to avoid closing menu when selecting an item
                                                enabled: false,
                                                child: StatefulBuilder(
                                                  builder:
                                                      (context, menuSetState) {
                                                    final isSelected =
                                                        selectedItemsTool
                                                            .contains(item);
                                                    return InkWell(
                                                      onTap: () {
                                                        if (item ==
                                                            translation(context).all) {
                                                          isSelected
                                                              ? selectedItemsTool
                                                                  .remove(item)
                                                              : (selectedItemsTool
                                                                ..clear()
                                                                ..add(item));
                                                          isSelected
                                                              ? null
                                                              : Navigator.of(
                                                                      context)
                                                                  .pop();
                                                        } else {
                                                          isSelected
                                                              ? selectedItemsTool
                                                                  .remove(item)
                                                              : selectedItemsTool
                                                                      .contains(
                                                            translation(context).all)
                                                                  ? {
                                                                      (selectedItemsTool
                                                                        ..remove(
                                                                          translation(context).all)
                                                                        ..add(
                                                                            item)),
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop()
                                                                    }
                                                                  : selectedItemsTool
                                                                      .add(
                                                                          item);
                                                        }
                                                        if (selectedItemsTool.contains(translation(context).cash) &&
                                                            selectedItemsTool
                                                                .contains(
                                                                    translation(
                                                                            context)
                                                                        .card) &&
                                                            selectedItemsTool
                                                                .contains(translation(
                                                                        context)
                                                                    .otherPaye)) {
                                                          selectedItemsTool
                                                            ..clear()
                                                            ..add(translation(context).all);
                                                          Navigator.of(context)
                                                              .pop();
                                                        }

                                                        //isSelected ? selectedItemsTool.remove(item) : selectedItemsTool.add(item);

                                                        //This rebuilds the StatefulWidget to update the button's text
                                                        setState(() {});
                                                        //This rebuilds the dropdownMenu Widget to update the check mark
                                                        menuSetState(() {});
                                                      },
                                                      child: Container(
                                                        height: double.infinity,
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    16.0),
                                                        child: Row(
                                                          children: [
                                                            if (isSelected)
                                                              Icon(
                                                                Icons
                                                                    .check_box_outlined,
                                                                color: renkler
                                                                    .koyuuRenk,
                                                              )
                                                            else
                                                              Icon(
                                                                Icons
                                                                    .check_box_outline_blank,
                                                                color: renkler
                                                                    .koyuuRenk,
                                                              ),
                                                            const SizedBox(
                                                                width: 16),
                                                            Expanded(
                                                              child: Center(
                                                                child: Text(
                                                                  item,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      height: 1,
                                                                      fontFamily:
                                                                          'Nexa4',
                                                                      color: renkler
                                                                          .koyuuRenk),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            }).toList(),
                                            //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                                            value: selectedItemsTool.isEmpty
                                                ? null
                                                : selectedItemsTool.last,
                                            onChanged: (value) {},
                                            selectedItemBuilder: (context) {
                                              return createItemListForTool(
                                                      context)
                                                  .map(
                                                (item) {
                                                  return Container(
                                                    alignment:
                                                        AlignmentDirectional
                                                            .center,
                                                    child: Text(
                                                      selectedItemsTool
                                                          .join(', '),
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        fontFamily: 'Nexa4',
                                                        height: 1,
                                                        color:
                                                            renkler.koyuuRenk,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      maxLines: 1,
                                                    ),
                                                  );
                                                },
                                              ).toList();
                                            },
                                            iconStyleData: const IconStyleData(
                                              iconSize: 0,
                                            ),
                                            dropdownStyleData:
                                                DropdownStyleData(

                                                    ///açılmış kutu
                                                    width: 120,
                                                    padding: EdgeInsets.zero,
                                                    decoration: BoxDecoration(
                                                      color: renkler.arkaRenk,
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  10)),
                                                    )),
                                            buttonStyleData: ButtonStyleData(
                                                //padding: EdgeInsets.symmetric(horizontal: 16),
                                                height: 36,
                                                width: 120,
                                                decoration: BoxDecoration(
                                                    color: Theme.of(context).disabledColor,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(10))

                                                    ///AÇILMAMIŞ KUTU
                                                    )),
                                            menuItemStyleData:
                                                MenuItemStyleData(
                                              ///açılmış kutu
                                              height: 32,
                                              padding: EdgeInsets.zero,
                                              overlayColor:
                                                  MaterialStatePropertyAll(
                                                      Theme.of(context).disabledColor),
                                              //padding: EdgeInsets.all(8),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4, right: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    selectedValueType = null;
                                    operationType = 'Hepsi';
                                    registration = 0;
                                    selectedValueDate =
                                        translation(context).monthly;
                                    year = DateTime.now().year;
                                    selectedValueYear = null;
                                    day = DateTime.now().day;
                                    selectedValueDay = null;
                                    month = DateTime.now().month;
                                    selectedValueMonth = null;
                                    week = (DateTime.now().day / 7).ceil();
                                    selectedValueWeek = null;
                                    selectedItemsTool.clear();
                                    selectedItemsToolToData.clear();
                                    operationTool
                                      ..clear()
                                      ..add('Hepsi');
                                    firstDate = null;
                                    secondDate = null;
                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 26,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).shadowColor,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15)),
                                    ),
                                    child: Center(
                                        child: Text(
                                          translation(context).reset,
                                      style: TextStyle(
                                          color: Theme.of(context).canvasColor,
                                          fontSize: 15,
                                          fontFamily: 'Nexa3'),
                                    )),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (selectedValueType ==
                                        translation(context).both) {
                                      operationType = 'Hepsi';
                                    } else if (selectedValueType ==
                                        translation(context).income) {
                                      operationType = 'Gelir';
                                    } else if (selectedValueType ==
                                        translation(context).expenses) {
                                      operationType = 'Gider';
                                    } else {
                                      operationType = 'Hepsi';
                                    }
                                    print(
                                        'Tamam bastın ve type : ${operationType}');
                                    selectedItemsToolToData.clear();
                                    print(selectedItemsTool);
                                    for (int i = 0;
                                        i < selectedItemsTool.length;
                                        i++) {
                                      if (selectedItemsTool[i] ==
                                          translation(context).all) {
                                        selectedItemsToolToData.add('Hepsi');
                                        break;
                                      } else if (selectedItemsTool[i] ==
                                          translation(context).cash) {
                                        selectedItemsToolToData.add('Nakit');
                                      } else if (selectedItemsTool[i] ==
                                          translation(context).card) {
                                        selectedItemsToolToData.add('Kart');
                                      } else {
                                        selectedItemsToolToData.add('Diğer');
                                      }
                                    }
                                    if (selectedItemsTool.isEmpty) {
                                      selectedItemsToolToData.add('Hepsi');
                                    }
                                    operationTool = selectedItemsToolToData;
                                    print(
                                        'Tamam bastın ve tool : ${operationTool}');

                                    if (selectedValueDate ==
                                        translation(context).yearly) {
                                      dateType = 0;
                                    } else if (selectedValueDate ==
                                        translation(context).monthly) {
                                      dateType = 1;
                                    } else if (selectedValueDate ==
                                        translation(context).weekly) {
                                      dateType = 2;
                                    } else if (selectedValueDate ==
                                        translation(context).daily) {
                                      dateType = 3;
                                    } else if (selectedValueDate == translation(context).period) {
                                      dateType = 4;
                                    } else {
                                      dateType = 1;
                                    }
                                    print(
                                        'Tamam bastın ve dateType : ${dateType}');
                                    year = selectedValueYear != null
                                        ? int.parse(selectedValueYear!)
                                        : year;
                                    print('Tamam bastın ve yıl : ${year}');
                                    month = selectedValueMonth != null
                                        ? convertMonth(selectedValueMonth!)
                                        : month;
                                    print('Tamam bastın ve ay : ${month}');
                                    week = selectedValueWeek != null
                                        ? int.parse(selectedValueWeek!)
                                        : week;
                                    print('Tamam bastın ve hafta : ${week}');
                                    day = selectedValueDay != null
                                        ? int.parse(selectedValueDay!)
                                        : day;
                                    print('Tamam bastın ve gün : ${day}');
                                    if (adEventCounter! <= 0) {
                                      print("object");
                                      _showInterstitialAd(context);
                                      readSettings.resetAdEventCounter();
                                    } else {
                                      readSettings.useAdEventCounter();
                                    }
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).highlightColor,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                    ),
                                    child: Center(
                                        child: Text(
                                          translation(context).okStatistics,
                                      style: TextStyle(
                                          color: renkler.arkaRenk,
                                          fontSize: 15,
                                          fontFamily: 'Nexa3'),
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ).then((_) => setState(() {}));
      },
    );
  }

  Widget rightInfoButton(BuildContext context) {
    var readStatistics = ref.read(statisticsRiverpod);
    String dateInfo = selectedValueDate != null
        ? selectedValueDate.toString()
        : translation(context).monthly;
    String yearText =
        selectedValueYear != null ? selectedValueYear! : year.toString();
    int monthText =
        selectedValueMonth != null ? convertMonth(selectedValueMonth!) : month;
    String monthTextTip = selectedValueMonth != null ? selectedValueMonth! : readStatistics.getMonths(context)[month-1] ;
    String weekText =
        selectedValueWeek != null ? selectedValueWeek! : week.toString();
    String dayText =
        selectedValueDay != null ? selectedValueDay! : day.toString();
    int dateController = 1;
    if (dateInfo == translation(context).monthly) {
      dateController = 1;
    } else if (dateInfo == translation(context).yearly) {
      dateController = 0;
    } else if (dateInfo == translation(context).weekly) {
      dateController = 2;
    } else if (dateInfo == translation(context).daily) {
      dateController = 3;
    } else if (dateInfo == translation(context).period) {
      dateController = 4;
    } else {
      dateController = 1;
    }
    DateTime initialStartDate = intl.DateFormat("dd.MM.yyyy").parse(
        '15.${DateTime.now().day > 15 ? DateTime.now().month : DateTime.now().month - 1}.${DateTime.now().year}');
    DateTime initialEndDate = intl.DateFormat("dd.MM.yyyy").parse(
        '15.${DateTime.now().day > 15 ? DateTime.now().month + 1 : DateTime.now().month}.${DateTime.now().year}');
    String date1 = firstDate != null
        ? '${firstDate!.day}.${firstDate!.month}.${firstDate!.year}'
        : '${initialStartDate.day}.${initialStartDate.month}.${initialStartDate.year}';
    String date2 = secondDate != null
        ? '${secondDate!.day}.${secondDate!.month}.${secondDate!.year}'
        : '${initialEndDate.day}.${initialEndDate.month}.${initialEndDate.year}';
    CustomColors renkler = CustomColors();
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 170),
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: Offset(0, 4))
            ]),
            child: ClipPath(
              clipper: MyCustomClipperForRight(),
              child: Tooltip(
                message: '$date1 / $date2',
                triggerMode: TooltipTriggerMode.tap,
                showDuration: dateController == 4 ? const Duration(seconds: 1) : const Duration(seconds: 0),
                textStyle: TextStyle(
                    fontSize: 13,
                    color: renkler.arkaRenk,
                    height: 1),
                textAlign: TextAlign.center,
                decoration: BoxDecoration(
                    borderRadius:
                    const BorderRadius.all(Radius.circular(5)),
                    color: Theme.of(context).highlightColor),
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    color: dateController == 4
                        ? Theme.of(context).disabledColor
                        : Theme.of(context).focusColor,
                  ),
                  child: Icon(Icons.linear_scale_sharp,
                      color: dateController == 4
                          ? renkler.koyuuRenk
                          : Theme.of(context).primaryColor),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 136),
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: Offset(0, 4))
            ]),
            child: ClipPath(
              clipper: MyCustomClipperForRight(),
              child: Tooltip(
                message: '$dayText. Gün'.toUpperCase(),
                triggerMode: TooltipTriggerMode.tap,
                showDuration: dateController == 3 ? const Duration(seconds: 1) : const Duration(seconds: 0),
                textStyle: TextStyle(
                    fontSize: 13,
                    color: renkler.arkaRenk,
                    height: 1),
                textAlign: TextAlign.center,
                decoration: BoxDecoration(
                    borderRadius:
                    const BorderRadius.all(Radius.circular(5)),
                    color: Theme.of(context).highlightColor),
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    color: dateController == 3
                        ? Theme.of(context).disabledColor
                        : Theme.of(context).focusColor,
                  ),
                  child: Center(
                    child: Text(
                      dayText,
                      style: TextStyle(
                          color: dateController == 3
                              ? renkler.koyuuRenk
                              : Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 102),
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: Offset(0, 4))
            ]),
            child: ClipPath(
              clipper: MyCustomClipperForRight(),
              child: Tooltip(
                message: '$weekText. Hafta'.toUpperCase(),
                triggerMode: TooltipTriggerMode.tap,
                showDuration: dateController == 2 ? const Duration(seconds: 1) : const Duration(seconds: 0),
                textStyle: TextStyle(
                    fontSize: 13,
                    color: renkler.arkaRenk,
                    height: 1),
                textAlign: TextAlign.center,
                decoration: BoxDecoration(
                    borderRadius:
                    const BorderRadius.all(Radius.circular(5)),
                    color: Theme.of(context).highlightColor),
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    color: dateController == 2
                        ? Theme.of(context).disabledColor
                        : Theme.of(context).focusColor,
                  ),
                  child: Center(
                    child: Text(
                      weekText,
                      style: TextStyle(
                        color: dateController == 2
                            ? renkler.koyuuRenk
                            : Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 68),
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: Offset(0, 4))
            ]),
            child: ClipPath(
              clipper: MyCustomClipperForRight(),
              child: Tooltip(
                message: monthTextTip.toUpperCase(),
                triggerMode: TooltipTriggerMode.tap,
                showDuration: dateController == 1 ? const Duration(seconds: 1) : const Duration(seconds: 0),
                textStyle: TextStyle(
                    fontSize: 13,
                    color: renkler.arkaRenk,
                    height: 1),
                textAlign: TextAlign.center,
                decoration: BoxDecoration(
                    borderRadius:
                    const BorderRadius.all(Radius.circular(5)),
                    color: Theme.of(context).highlightColor),
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    color: dateController == 1
                        ? Theme.of(context).disabledColor
                        : Theme.of(context).focusColor,
                  ),
                  child: Center(
                    child: Text(
                      monthText.toString(),
                      style: TextStyle(
                        color: dateController == 1
                            ? renkler.koyuuRenk
                            : Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 34),
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: Offset(0, 4))
            ]),
            child: ClipPath(
              clipper: MyCustomClipperForRight(),
              child: Tooltip(
                message: yearText,
                triggerMode: TooltipTriggerMode.tap,
                showDuration: dateController != 4 ? const Duration(seconds: 1) : const Duration(seconds: 0),
                textStyle: TextStyle(
                    fontSize: 13,
                    color: renkler.arkaRenk,
                    height: 1),
                textAlign: TextAlign.center,
                decoration: BoxDecoration(
                    borderRadius:
                    const BorderRadius.all(Radius.circular(5)),
                    color: Theme.of(context).highlightColor),
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    color: dateController != 4
                        ? Theme.of(context).disabledColor
                        : Theme.of(context).focusColor,
                  ),
                  child: Center(
                    child: Text(
                      yearText.substring(yearText.length - 2),
                      style: TextStyle(
                        color: dateController != 4
                            ? renkler.koyuuRenk
                            : Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 8,
                offset: Offset(0, 4))
          ]),
          child: ClipPath(
            clipper: MyCustomClipperForRight(),
            child: Tooltip(
              message: dateInfo,
              triggerMode: TooltipTriggerMode.tap,
              showDuration: const Duration(seconds: 1),
              textStyle: TextStyle(
                  fontSize: 13,
                  color: renkler.arkaRenk,
                  height: 1),
              textAlign: TextAlign.center,
              decoration: BoxDecoration(
                  borderRadius:
                  const BorderRadius.all(Radius.circular(5)),
                  color: Theme.of(context).highlightColor),
              child: Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  color: Theme.of(context).secondaryHeaderColor,
                ),
                child: Icon(Icons.date_range_rounded,
                    color: Theme.of(context).primaryColor),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget leftInfoButton(BuildContext context) {
    String typeInfo = selectedValueType != null
        ? selectedValueType!
        : translation(context).both;
    List<String> toolInfo = selectedItemsTool.isNotEmpty
        ? selectedItemsTool!
        : [translation(context).both];
    String regInfo =
        registration == 0 ? 'Kayıtlı Olmayanlar' : 'Kayıtlı Olanlar';

    int typeInfoController = 0;
    if (toolInfo.length == 1 && toolInfo[0] == translation(context).both) {
      typeInfoController = 0;
    } else if (toolInfo.length == 1 &&
        toolInfo[0] == translation(context).cash) {
      typeInfoController = 1;
    } else if (toolInfo.length == 1 &&
        toolInfo[0] == translation(context).card) {
      typeInfoController = 2;
    } else if (toolInfo.length == 1 &&
        toolInfo[0] == translation(context).otherPaye) {
      typeInfoController = 3;
    } else if (toolInfo.length == 2 &&
        toolInfo.contains(translation(context).otherPaye) == false) {
      typeInfoController = 4;
    } else if (toolInfo.length == 2 &&
        toolInfo.contains(translation(context).card) == false) {
      typeInfoController = 5;
    } else if (toolInfo.length == 2 &&
        toolInfo.contains(translation(context).cash) == false) {
      typeInfoController = 6;
    } else {
      typeInfoController = 0;
    }

    CustomColors renkler = CustomColors();
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 170),
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: Offset(0, 4))
            ]),
            child: ClipPath(
              clipper: MyCustomClipper(),
              child: Tooltip(
                message: 'Sadece Kayıtlı İşlemler'.toUpperCase(),
                triggerMode: TooltipTriggerMode.tap,
                showDuration: registration == 1 ? const Duration(seconds: 1) : const Duration(seconds: 0),
                textStyle: TextStyle(
                    fontSize: 13,
                    color: renkler.arkaRenk,
                    height: 1),
                textAlign: TextAlign.center,
                decoration: BoxDecoration(
                    borderRadius:
                    const BorderRadius.all(Radius.circular(5)),
                    color: Theme.of(context).highlightColor),
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    color: registration == 1
                        ? Theme.of(context).disabledColor
                        : Theme.of(context).focusColor,
                  ),
                  child: Icon(
                    registration == 0
                        ? Icons.bookmark_outline_rounded
                        : Icons.bookmark_added_rounded,
                    color: registration == 1
                        ? renkler.koyuuRenk
                        : Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 136),
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: Offset(0, 4))
            ]),
            child: ClipPath(
              clipper: MyCustomClipper(),
              child: Tooltip(
                message: translation(context).otherPaye,
                triggerMode: TooltipTriggerMode.tap,
                showDuration: typeInfoController == 0 ||
                    typeInfoController == 3 ||
                    typeInfoController == 5 ||
                    typeInfoController == 6 ? const Duration(seconds: 1) : const Duration(seconds: 0),
                textStyle: TextStyle(
                    fontSize: 13,
                    color: renkler.arkaRenk,
                    height: 1),
                textAlign: TextAlign.center,
                decoration: BoxDecoration(
                    borderRadius:
                    const BorderRadius.all(Radius.circular(5)),
                    color: Theme.of(context).highlightColor),
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    color: typeInfoController == 0 ||
                            typeInfoController == 3 ||
                            typeInfoController == 5 ||
                            typeInfoController == 6
                        ? Theme.of(context).disabledColor
                        : Theme.of(context).focusColor,
                  ),
                  child: Icon(
                    Icons.more_horiz_rounded,
                    color: typeInfoController == 0 ||
                            typeInfoController == 3 ||
                            typeInfoController == 5 ||
                            typeInfoController == 6
                        ? renkler.koyuuRenk
                        : Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 102),
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: Offset(0, 4))
            ]),
            child: ClipPath(
              clipper: MyCustomClipper(),
              child: Tooltip(
                message: translation(context).card,
                triggerMode: TooltipTriggerMode.tap,
                showDuration: typeInfoController == 0 ||
                    typeInfoController == 2 ||
                    typeInfoController == 4 ||
                    typeInfoController == 6 ? const Duration(seconds: 1) : const Duration(seconds: 0),
                textStyle: TextStyle(
                    fontSize: 13,
                    color: renkler.arkaRenk,
                    height: 1),
                textAlign: TextAlign.center,
                decoration: BoxDecoration(
                    borderRadius:
                    const BorderRadius.all(Radius.circular(5)),
                    color: Theme.of(context).highlightColor),
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    color: typeInfoController == 0 ||
                            typeInfoController == 2 ||
                            typeInfoController == 4 ||
                            typeInfoController == 6
                        ? Theme.of(context).disabledColor
                        : Theme.of(context).focusColor,
                  ),
                  child: Icon(
                    Icons.credit_card_rounded,
                    color: typeInfoController == 0 ||
                            typeInfoController == 2 ||
                            typeInfoController == 4 ||
                            typeInfoController == 6
                        ? renkler.koyuuRenk
                        : Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 68),
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: Offset(0, 4))
            ]),
            child: ClipPath(
              clipper: MyCustomClipper(),
              child: Tooltip(
                message: translation(context).cash,
                triggerMode: TooltipTriggerMode.tap,
                showDuration: typeInfoController == 0 ||
    typeInfoController == 1 ||
    typeInfoController == 4 ||
    typeInfoController == 5 ? const Duration(seconds: 1) : const Duration(seconds: 0),
                textStyle: TextStyle(
                    fontSize: 13,
                    color: renkler.arkaRenk,
                    height: 1),
                textAlign: TextAlign.center,
                decoration: BoxDecoration(
                    borderRadius:
                    const BorderRadius.all(Radius.circular(5)),
                    color: Theme.of(context).highlightColor),
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    color: typeInfoController == 0 ||
                            typeInfoController == 1 ||
                            typeInfoController == 4 ||
                            typeInfoController == 5
                        ? Theme.of(context).disabledColor
                        : Theme.of(context).focusColor,
                  ),
                  child: Icon(
                    Icons.money_rounded,
                    color: typeInfoController == 0 ||
                            typeInfoController == 1 ||
                            typeInfoController == 4 ||
                            typeInfoController == 5
                        ? renkler.koyuuRenk
                        : Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 34),
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: Offset(0, 4))
            ]),
            child: ClipPath(
              clipper: MyCustomClipper(),
              child: Tooltip(
                message: translation(context).expenses,
                triggerMode: TooltipTriggerMode.tap,
                showDuration: typeInfo == translation(context).income ? const Duration(seconds: 0) : const Duration(seconds: 1),
                textStyle: TextStyle(
                    fontSize: 13,
                    color: renkler.arkaRenk,
                    height: 1),
                textAlign: TextAlign.center,
                decoration: BoxDecoration(
                    borderRadius:
                    const BorderRadius.all(Radius.circular(5)),
                    color: Theme.of(context).highlightColor),
                child: Container(
                  height: 36,
                  width: 36,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: typeInfo == translation(context).both ||
                            typeInfo == translation(context).expenses
                        ? Theme.of(context).disabledColor
                        : Theme.of(context).focusColor,
                  ),
                  child: Image.asset(
                    "assets/icons/expense.png",
                      filterQuality: FilterQuality.medium,
                      color: typeInfo == translation(context).both ||
                          typeInfo == translation(context).expenses
                          ? null
                          : Theme.of(context).primaryColor
                  ),
                  /*child: Icon(
                    Icons.south_west_rounded,
                    color: typeInfo == translation(context).both ||
                            typeInfo == translation(context).expenses
                        ? renkler.koyuuRenk
                        : Theme.of(context).primaryColor,
                  ),*/
                ),
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 8,
                offset: Offset(0, 4))
          ]),
          child: ClipPath(
            clipper: MyCustomClipper(),
            child: Tooltip(
              message: translation(context).income,
              triggerMode: TooltipTriggerMode.tap,
              showDuration: typeInfo == translation(context).expenses ? const Duration(seconds: 0) : const Duration(seconds: 1),
              textStyle: TextStyle(
                  fontSize: 13,
                  color: renkler.arkaRenk,
                  height: 1),
              textAlign: TextAlign.center,
              decoration: BoxDecoration(
                  borderRadius:
                  const BorderRadius.all(Radius.circular(5)),
                  color: Theme.of(context).highlightColor),
              child: Container(
                height: 36,
                width: 36,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: typeInfo == translation(context).both ||
                          typeInfo == translation(context).income
                      ? Theme.of(context).disabledColor
                      : Theme.of(context).focusColor,
                ),
                child: Image.asset(
                    "assets/icons/income.png",
                    filterQuality: FilterQuality.medium,
                    color: typeInfo == translation(context).both ||
                        typeInfo == translation(context).income
                        ? null
                        : Theme.of(context).primaryColor
                ),
               /* child: Icon(
                  Icons.north_east_rounded,
                  color: typeInfo == translation(context).both ||
                          typeInfo == translation(context).income
                      ? renkler.koyuuRenk
                      : Theme.of(context).primaryColor,
                ),*/
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget myCategoryList(BuildContext context) {
    var read = ref.read(statisticsRiverpod);
    var readSettings = ref.read(settingsRiverpod);
    var readCategoryInfo = ref.read(categoryInfoRiverpod);
    var size = MediaQuery.of(context).size;
    final ScrollController scrolbarcontroller1 = ScrollController();
    Future<List<Map<String, dynamic>>> myList = read.getCategoryList(
        operationType,
        registration,
        operationTool,
        dateType,
        year,
        month,
        week,
        day,
        firstDate,
        secondDate);
    return FutureBuilder(
        future: myList,
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var item = snapshot.data!;
          double totalAmount = 0;
          for (var item in item) {
            totalAmount += item['realAmount']!;
          }
          if (snapshot.data!.isEmpty) {
            return Column(
              children: [
                SizedBox(
                  width: size.width * 0.95,
                  height: size.height * 0.32,
                  child: Center(
                    child: Container(
                      height: 45,
                      width: 160,
                      decoration: BoxDecoration(
                          color: const Color(0xFF0D1C26),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: Text(
                        translation(context).dataNotFound,
                        style: const TextStyle(
                            height: 1, color: Colors.white, fontSize: 16),
                      )),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  height: size.height * 0.04,
                )
              ],
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 1.5),
                            child: SizedBox(
                              width: 4,
                              //height: size.height * 0.35,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 1.5, left: 1.5),
                            child: Container(
                              width: 4,
                              //height: size.height * 0.35,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(30)),
                                  color: snapshot.data!.length <= 7
                                      ? Theme.of(context).indicatorColor
                                      : Theme.of(context).canvasColor),
                            ),
                          ),
                        ],
                      ),
                      Theme(
                        data: Theme.of(context).copyWith(
                            scrollbarTheme: ScrollbarThemeData(
                                thumbColor: MaterialStateProperty.all(
                          Theme.of(context).dialogBackgroundColor,
                        ))),
                        child: Scrollbar(
                          thumbVisibility: true,
                          controller: scrolbarcontroller1,
                          scrollbarOrientation:
                              readSettings.localChanger() == const Locale("ar")
                                  ? ScrollbarOrientation.left
                                  : ScrollbarOrientation.right,
                          interactive: true,
                          thickness: 7,
                          radius: const Radius.circular(15.0),
                          child: ListView.builder(
                            controller: scrolbarcontroller1,
                            itemCount: snapshot.data!.length > 30
                                ? 30
                                : snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 8, right: 16, left: 16),
                                child: InkWell(
                                  highlightColor:
                                      Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () {
                                    year = selectedValueYear != null
                                        ? int.parse(selectedValueYear!)
                                        : year;
                                    month = selectedValueMonth != null
                                        ? convertMonth(selectedValueMonth!)
                                        : month;
                                    week = selectedValueWeek != null
                                        ? int.parse(selectedValueWeek!)
                                        : week;
                                    day = selectedValueDay != null
                                        ? int.parse(selectedValueDay!)
                                        : day;
                                    registration = registration ?? 0;
                                    readCategoryInfo.setDateAndCategory(
                                        day,
                                        month,
                                        year,
                                        week,
                                        item[index]['category'],
                                        registration,
                                        operationTool,
                                        dateType,
                                        firstDate,
                                        secondDate);
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          const CategoryInfo(),
                                    ));
                                  },
                                  child: SizedBox(
                                    height: 42,
                                    width: size.width * 0.95,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Theme.of(context).focusColor,
                                      ),
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 5),
                                          Container(
                                            width: 70,
                                            height: 25,
                                            decoration: BoxDecoration(
                                              color: colorsList[index],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                                child: Text(
                                              "% ${item[index]['percentages']}",
                                              style: const TextStyle(
                                                height: 1,
                                                fontFamily: 'NEXA3',
                                                color: Colors.white,
                                              ),
                                            )),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              Converter().textConverterFromDB(item[index]["category"]!, context, 0),
                                              style: TextStyle(
                                                height: 1,
                                                fontFamily: 'NEXA3',
                                                fontSize: 18,
                                                color:
                                                    Theme.of(context).canvasColor,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: item[index]
                                                          ['realAmount']
                                                      .toStringAsFixed(2),
                                                  style: TextStyle(
                                                    height: 1,
                                                    fontFamily: 'NEXA3',
                                                    fontSize: 16,
                                                    color: Theme.of(context)
                                                        .dialogBackgroundColor,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      readSettings.prefixSymbol,
                                                  style: TextStyle(
                                                    height: 1,
                                                    fontFamily: 'TL',
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                    color: Theme.of(context)
                                                        .dialogBackgroundColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  width: size.width * 0.9,
                  height: size.height * 0.04,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FittedBox(
                        child: Text(
                          translation(context).totalAmountStatistics,
                          style: TextStyle(
                            height: 1,
                            fontFamily: 'NEXA3',
                            fontSize: 17,
                            color: Theme.of(context).canvasColor,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: Theme.of(context).focusColor,
                        ),
                        height: 26,
                        child: Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(right: 10, left: 10),
                            child: FittedBox(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: totalAmount.toStringAsFixed(1),
                                      style: TextStyle(
                                        height: 1,
                                        fontFamily: 'Nexa3',
                                        fontSize: 17,
                                        color: Theme.of(context).canvasColor,
                                      ),
                                    ),
                                    TextSpan(
                                      text: readSettings.prefixSymbol,
                                      style: TextStyle(
                                        height: 1,
                                        fontFamily: 'TL',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17,
                                        color: Theme.of(context).canvasColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }
        });
  }

  String? selectedValueMonth;
  String? selectedValueYear;
  String? selectedValueWeek;
  String? selectedValueDay;
  DateTime? _selectedDate;
  DateTime? firstDate;
  DateTime? secondDate;
  Widget dateMenu(BuildContext context, String? dateType) {
    int typer = 1;
    if (dateType == translation(context).yearly) {
      typer = 0;
    } else if (dateType == translation(context).monthly) {
      typer = 1;
    } else if (dateType == translation(context).weekly) {
      typer = 2;
    } else if (dateType == translation(context).daily) {
      typer = 3;
    } else if (dateType == translation(context).period) {
      typer = 4;
    } else {
      typer = 1;
    }
    var read = ref.read(statisticsRiverpod);
    int yearCount =
        selectedValueYear != null ? int.parse(selectedValueYear!) : year;
    int monthCount =
        selectedValueMonth != null ? convertMonth(selectedValueMonth!) : month;
    List<String> dayName = read.getDays(monthCount!, yearCount!);
    List<String> weekName = read.getWeeks(monthCount!, yearCount!);
    List<String> monthName = read.getMonths(context);
    List<String> yearName = read.getYears();
    DateTime dateForDate2 = DateTime.now().add(Duration(days: 15));

    CustomColors renkler = CustomColors();
    DateTime initialStartDate = intl.DateFormat("dd.MM.yyyy").parse(
        '15.${DateTime.now().day > 15 ? DateTime.now().month : DateTime.now().month - 1}.${DateTime.now().year}');
    DateTime initialEndDate = intl.DateFormat("dd.MM.yyyy").parse(
        '15.${DateTime.now().day > 15 ? DateTime.now().month + 1 : DateTime.now().month}.${DateTime.now().year}');
    String date1 = firstDate != null
        ? '${firstDate!.day}.${firstDate!.month}.${firstDate!.year}'
        : '${initialStartDate.day}.${initialStartDate.month}.${initialStartDate.year}';
    String date2 = secondDate != null
        ? '${secondDate!.day}.${secondDate!.month}.${secondDate!.year}'
        : '${initialEndDate.day}.${initialEndDate.month}.${initialEndDate.year}';
    Future<void> selectDate(BuildContext context, setState) async {
      DateTimeRange? picked = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030),
        initialDateRange: DateTimeRange(
          end: secondDate != null ? secondDate! : initialEndDate,
          start: firstDate != null ? firstDate! : initialStartDate,
        ),
        builder: (BuildContext context, child) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Theme(
                data: Theme.of(context).copyWith(
                  dialogTheme: DialogTheme(
                      shadowColor: Colors.black54,
                      //backgroundColor: Theme.of(context).indicatorColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder( borderRadius: BorderRadius.all(Radius.circular(10))),
                        //foregroundColor: Theme.of(context).canvasColor,
                        textStyle: TextStyle(fontFamily: "Nexa3",height: 1,fontSize: 15)// button text color
                    ),
                  ),
                  dividerTheme: DividerThemeData(
                      color: Theme.of(context).canvasColor,
                      thickness: 1.5
                  ),
                  datePickerTheme: DatePickerThemeData(
                    dayStyle: TextStyle(fontFamily: "Nexa3",height: 1,fontSize: 15,color: renkler.koyuuRenk),
                    dayOverlayColor: MaterialStatePropertyAll(Theme.of(context).disabledColor),
                    headerForegroundColor: renkler.yaziRenk,
                    rangePickerBackgroundColor: Theme.of(context).primaryColor,
                    rangeSelectionBackgroundColor: Theme.of(context).disabledColor,
                    rangePickerHeaderBackgroundColor: Theme.of(context).disabledColor,
                    rangePickerHeaderForegroundColor: renkler.arkaRenk,
                    headerHeadlineStyle: const TextStyle(
                        fontSize: 22,
                        fontFamily: "Nexa4",
                        height: 1
                    ),
                    headerHelpStyle: const TextStyle(
                        fontSize: 16,
                        fontFamily: "Nexa4",
                        height: 1
                    ),
                    headerBackgroundColor: renkler.koyuuRenk,
                    backgroundColor: Theme.of(context).disabledColor,
                    rangePickerHeaderHelpStyle: const TextStyle(
                      fontSize: 16,
                      fontFamily: "Nexa4",
                      height: 1
                    ),
                    rangePickerHeaderHeadlineStyle: TextStyle(
                        fontSize: 22,
                        fontFamily: "Nexa4",
                        height: 1
                    ),
                    dayForegroundColor: MaterialStatePropertyAll(Theme.of(context).disabledColor),
                    rangePickerShape:  RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)))
                  ),
                  textTheme: TextTheme(
                    bodyMedium: TextStyle(
                      color: Theme.of(context).canvasColor,
                      fontSize: 16,
                      height: 1,
                      fontFamily: "Nexa3"
                    )

                  ),
                  colorScheme: ColorScheme(
                    brightness: Brightness.light,
                    primary: renkler.koyuuRenk, // üst taraf arkaplan rengi
                    onPrimary: renkler.arkaRenk, //üst taraf yazı rengi
                    secondary: renkler.kirmiziRenk,
                    onSecondary: renkler.koyuuRenk,
                    primaryContainer: renkler.kirmiziRenk,
                    error: const Color(0xFFD91A2A),
                    onError: const Color(0xFFD91A2A),
                    background: renkler.kirmiziRenk,
                    onBackground: renkler.koyuuRenk,
                    surface: Theme.of(context).disabledColor, //ÜST TARAF RENK
                    onPrimaryContainer: renkler.koyuuRenk,
                    onSurface: Theme.of(context).canvasColor, //alt günlerin rengi
                  ),
                ),
                child: child!,
              );
            },
          );
        },
      );
      if (picked != null) {
        setState(() {
          firstDate = picked.start;
          secondDate = picked.end;
          date1 = '${firstDate!.day}.${firstDate!.month}.${firstDate!.year}';
          date2 = '${secondDate!.day}.${secondDate!.month}.${secondDate!.year}';
        });
      }
    }

    var readSettings = ref.read(settingsRiverpod);

    String getFormattedDate(String date){
      List <String> parts = date.split(".");
      int parseDay = int.parse(parts[0]);
      int parseMonth = int.parse(parts[1]);
      int parseYear = int.parse(parts[2]);
      String formattedDate = readSettings.dateFormat == "yyyy.MM.dd" ? "$parseYear.$parseMonth.$parseDay" : readSettings.dateFormat == "MM.dd.yyyy" ? "$parseMonth.$parseDay.$parseYear" : "$parseDay.$parseMonth.$parseYear";
    return formattedDate;
    }


    return StatefulBuilder(
      builder: (context, setState) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Visibility(
              visible: typer == 3,
              child: Stack(
                children: [
                  SizedBox(
                    height: 34,
                    width: 38,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Center(
                          child: Text(
                            day.toString(),
                            style: TextStyle(
                                fontSize: 13,
                                height: 1,
                                color: renkler.arkaRenk),
                          ),
                        ),
                        items: dayName!
                            .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Center(
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                          fontSize: 13,
                                          height: 1,
                                          color: renkler.arkaRenk),
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: selectedValueDay,
                        onChanged: (String? value) {
                          setState(() {
                            selectedValueDay = value;
                          });
                        },
                        iconStyleData: const IconStyleData(
                          iconSize: 0,
                        ),
                        //alignment: Alignment.center,
                        dropdownStyleData: DropdownStyleData(
                            maxHeight: 160,

                            ///açılmış kutu
                            decoration: BoxDecoration(
                              color: renkler.koyuuRenk,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            )),
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          height: 36,
                          width: 96,
                        ),
                        menuItemStyleData: MenuItemStyleData(
                          ///açılmış kutu
                          height: 32,
                          overlayColor:
                              MaterialStatePropertyAll(Theme.of(context).disabledColor),
                          padding: const EdgeInsets.all(8),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: 5,
                      width: 38,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15)),
                        color: Theme.of(context).disabledColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
                visible: typer == 3,
                child: SizedBox(
                  width: 5,
                )),
            Visibility(
              visible: typer == 2,
              child: Stack(
                children: [
                  SizedBox(
                    height: 34,
                    width: 34,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Center(
                          child: Text(
                            "${week.toString()}.",
                            style: TextStyle(
                                fontSize: 13,
                                height: 1,
                                color: renkler.arkaRenk),
                          ),
                        ),
                        items: weekName
                            .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Center(
                                    child: Text(
                                      "$item.",
                                      style: TextStyle(
                                          fontSize: 13,
                                          height: 1,
                                          color: renkler.arkaRenk),
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: selectedValueWeek,
                        onChanged: (String? value) {
                          setState(() {
                            selectedValueWeek = value;
                          });
                        },
                        iconStyleData: const IconStyleData(
                          iconSize: 0,
                        ),
                        //alignment: Alignment.center,
                        dropdownStyleData: DropdownStyleData(
                            maxHeight: 160,

                            ///açılmış kutu
                            decoration: BoxDecoration(
                              color: renkler.koyuuRenk,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            )),
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          height: 36,
                          width: 96,
                        ),
                        menuItemStyleData: MenuItemStyleData(
                          ///açılmış kutu
                          height: 32,
                          overlayColor:
                              MaterialStatePropertyAll(Theme.of(context).disabledColor),
                          padding: const EdgeInsets.all(8),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: 5,
                      width: 34,
                      decoration:BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15)),
                        color: Theme.of(context).disabledColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
                visible: typer == 2,
                child: SizedBox(
                  width: 5,
                )),
            Visibility(
              visible: typer == 1 || typer == 2 || typer == 3,
              child: Stack(
                children: [
                  SizedBox(
                    height: 34,
                    width: 86,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Center(
                          child: Text(
                            monthName[month - 1],
                            style: TextStyle(
                                fontSize: 12,
                                height: 1,
                                color: renkler.arkaRenk),
                          ),
                        ),
                        items: monthName
                            .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Center(
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                          fontSize: 12,
                                          height: 1,
                                          color: renkler.arkaRenk),
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: selectedValueMonth,
                        onChanged: (String? value) {
                          setState(() {
                            selectedValueMonth = value;
                            monthCount = selectedValueMonth != null
                                ? convertMonth(selectedValueMonth!)
                                : month;
                            dayName = read.getDays(monthCount!, yearCount!);
                            weekName = read.getWeeks(monthCount!, yearCount!);
                            int.parse(selectedValueWeek != null
                                        ? selectedValueWeek!
                                        : '1') >
                                    weekName.length
                                ? selectedValueWeek = weekName.last
                                : null;
                            int.parse(selectedValueDay != null
                                        ? selectedValueDay!
                                        : '15') >
                                    dayName.length
                                ? selectedValueDay = dayName.last
                                : null;
                          });
                          setState(() {});
                        },
                        iconStyleData: const IconStyleData(
                          iconSize: 0,
                        ),
                        //alignment: Alignment.center,
                        dropdownStyleData: DropdownStyleData(
                            maxHeight: 160,
                            width: 86,

                            ///açılmış kutu
                            decoration: BoxDecoration(
                              color: renkler.koyuuRenk,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            )),
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          height: 36,
                          width: 86,
                        ),
                        menuItemStyleData: MenuItemStyleData(
                          ///açılmış kutu
                          height: 32,
                          overlayColor:
                              MaterialStatePropertyAll(Theme.of(context).disabledColor),
                          padding: const EdgeInsets.all(8),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: 5,
                      width: 84,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15)),
                        color: Theme.of(context).disabledColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
                visible: typer == 1 || typer == 2 || typer == 3,
                child: SizedBox(
                  width: 5,
                )),
            Visibility(
              visible: typer == 0 || typer == 1 || typer == 2 || typer == 3,
              child: Stack(
                children: [
                  SizedBox(
                    height: 34,
                    width: 54,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Center(
                          child: Text(
                            year.toString(),
                            style: TextStyle(
                                fontSize: 12,
                                height: 1,
                                color: renkler.arkaRenk),
                          ),
                        ),
                        items: yearName
                            .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Center(
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                          fontSize: 12,
                                          height: 1,
                                          color: renkler.arkaRenk),
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: selectedValueYear,
                        onChanged: (String? value) {
                          setState(() {
                            selectedValueYear = value;
                          });
                          yearCount = selectedValueYear != null
                              ? int.parse(selectedValueYear!)
                              : year;
                          dayName = read.getDays(monthCount!, yearCount!);
                          weekName = read.getWeeks(monthCount!, yearCount!);
                          int.parse(selectedValueWeek != null
                                      ? selectedValueWeek!
                                      : '1') >
                                  weekName.length
                              ? selectedValueWeek = weekName.last
                              : null;
                          int.parse(selectedValueDay != null
                                      ? selectedValueDay!
                                      : '15') >
                                  dayName.length
                              ? selectedValueDay = dayName.last
                              : null;
                        },
                        iconStyleData: const IconStyleData(
                          iconSize: 0,
                        ),
                        //alignment: Alignment.center,
                        dropdownStyleData: DropdownStyleData(
                            maxHeight: 160,

                            ///açılmış kutu
                            decoration: BoxDecoration(
                              color: renkler.koyuuRenk,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            )),
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          height: 36,
                          width: 96,
                        ),
                        menuItemStyleData: MenuItemStyleData(
                          ///açılmış kutu
                          height: 32,
                          overlayColor:
                              MaterialStatePropertyAll(Theme.of(context).disabledColor),
                          padding: const EdgeInsets.all(8),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: 5,
                      width: 54,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15)),
                        color: Theme.of(context).disabledColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: typer == 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                          height: 34,
                          width: 80,
                          child: InkWell(
                            onTap: () {
                              selectDate(context, setState);
                            },
                            child: Center(
                                child: Text(
                                  getFormattedDate(date1),
                              style: TextStyle(
                                  color: renkler.arkaRenk,
                                  height: 1,
                                  fontSize: 13,
                                  fontFamily: 'Nexa3'),
                            )),
                          )),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: 5,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                topLeft: Radius.circular(15)),
                            color: Theme.of(context).disabledColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Center(
                      child: Text(
                    '/',
                    style: TextStyle(color: renkler.arkaRenk),
                  )),
                  Stack(
                    children: [
                      SizedBox(
                        height: 34,
                        width: 80,
                        child: InkWell(
                          onTap: () {
                            selectDate(context, setState);
                          },
                          child: Center(
                              child: Text(
                                getFormattedDate(date2),
                            style: TextStyle(
                                color: renkler.arkaRenk,
                                height: 1,
                                fontSize: 13,
                                fontFamily: 'Nexa3'),
                          )),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: 5,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                topLeft: Radius.circular(15)),
                            color: Theme.of(context).disabledColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  int convertMonth(String monthName) {
    if (monthName == translation(context).january) {
      return 1;
    } else if (monthName == translation(context).february) {
      return 2;
    } else if (monthName == translation(context).march) {
      return 3;
    } else if (monthName == translation(context).april) {
      return 4;
    } else if (monthName == translation(context).may) {
      return 5;
    } else if (monthName == translation(context).june) {
      return 6;
    } else if (monthName == translation(context).july) {
      return 7;
    } else if (monthName == translation(context).august) {
      return 8;
    } else if (monthName == translation(context).september) {
      return 9;
    } else if (monthName == translation(context).october) {
      return 10;
    } else if (monthName == translation(context).november) {
      return 11;
    } else if (monthName == translation(context).december) {
      return 12;
    } else {
      return month;
    }
  }

  Widget pasta(BuildContext context) {
    var read = ref.read(statisticsRiverpod);
    Future<List<Map<String, dynamic>>> listeeme = read.getCategoryAndAmount(
        operationType,
        registration,
        operationTool,
        dateType,
        year,
        month,
        week,
        day,
        firstDate,
        secondDate);

    return FutureBuilder(
        future: listeeme,
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var item = snapshot.data!; // !
          if (snapshot.data!.isEmpty) {
            return Center(
              child: SizedBox(
                height: 140,
                width: 140,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).indicatorColor,
                      borderRadius: BorderRadius.circular(200)),
                ),
              ),
            );
          } else {
            return DChartPie(
              data: item,
              strokeWidth: 1,
              fillColor: (pieData, index) {
                return colorsList[index!];
              },
              pieLabel: (pieData, index) {
                return "${pieData['domain']}:\n${pieData['measure']}%";
              },
              labelPosition: PieLabelPosition.auto,
              //donutWidth: 15,
              showLabelLine: true,
              labelColor: Theme.of(context).canvasColor,
              labelFontSize: 11,
              labelLinelength: 5,
              labelLineColor: Theme.of(context).canvasColor,
            );
          }
        });
  }

  var colorsList = [
    Colors.red.shade900,
    Colors.red,
    Colors.orange.shade800,
    Colors.orange.shade500,
    Colors.amber.shade500,
    Colors.yellow.shade500,
    Colors.lime.shade700,
    Colors.lime.shade500,
    Colors.green.shade700,
    Colors.green.shade500,
    Colors.lightGreen.shade600,
    Colors.lightGreen.shade300,
    Colors.green.shade200,
    Colors.teal.shade700,
    Colors.teal.shade500,
    Colors.teal.shade200,
    Colors.cyanAccent,
    Colors.blue.shade600,
    Colors.blue.shade400,
    Colors.indigo.shade500,
    Colors.deepPurple.shade800,
    Colors.deepPurple.shade500,
    Colors.deepPurple.shade200,
  ];
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double roundnessFactor = 4.0;
    double height = 36.0;
    double width = 36.0;
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(width - roundnessFactor, 0);
    path.quadraticBezierTo(width, 0, width, roundnessFactor);

    path.lineTo(width - roundnessFactor, height - roundnessFactor);

    path.quadraticBezierTo(
        width - roundnessFactor, height, width - (roundnessFactor * 2), height);

    path.lineTo(0, height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class MyCustomClipperForRight extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double roundnessFactor = 4.0;
    double height = 36.0;
    double width = 36.0;
    Path path = Path();
    path.moveTo(36, 0);
    path.lineTo(roundnessFactor, 0);
    path.quadraticBezierTo(0, 0, 0, roundnessFactor);

    path.lineTo(roundnessFactor, height - roundnessFactor);

    path.quadraticBezierTo(
        roundnessFactor, height, roundnessFactor * 2, height);

    path.lineTo(width, height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
