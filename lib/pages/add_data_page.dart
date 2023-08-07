import 'package:butcekontrol/classes/language.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/utils/interstitial_ads.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' as intl;
import 'package:butcekontrol/utils/date_time_manager.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../riverpod_management.dart';

class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);
  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        //backgroundColor: Colors.white,
        appBar: _AddAppBar(),
        body: ButtonMenu(),
        bottomNavigationBar: null,
      ),
    );
  }
}

class _AddAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const _AddAppBar({Key? key}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(60);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var read = ref.read(botomNavBarRiverpod);
    var size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: SizedBox(
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
                  decoration: BoxDecoration(
                      color: const Color(0xff0D1C26),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                        ),
                      ],
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(100),
                      )),
                  child:  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 22),
                    child: Text(
                      translation(context).addIncomeExpensesTitle,
                      style: const TextStyle(
                        height: 1,
                        fontFamily: 'Nexa4',
                        fontSize: 20,
                        color: Color(0xFFE9E9E9),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: SizedBox(
                height: 60,
                child: Container(
                  width: 60,
                  decoration: const BoxDecoration(
                      color: Color(0xffF2CB05),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(100),
                        bottomLeft: Radius.circular(100),
                        topLeft: Radius.circular(100),
                      )),
                  child: IconButton(
                    padding: const EdgeInsets.only(right: 1.0),
                    iconSize: 60,
                    icon: Image.asset(
                      "assets/icons/remove.png",
                      height: 26,
                      width: 26,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      read.setCurrentindex(read.current!);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonMenu extends ConsumerStatefulWidget {
  const ButtonMenu({Key? key}) : super(key: key);
  @override
  ConsumerState<ButtonMenu> createState() => _ButtonMenu();
}

class _ButtonMenu extends ConsumerState<ButtonMenu>{
  final InterstitialAdManager _interstitialAdManager = InterstitialAdManager();
  @override
  void initState() {
    var readSettings = ref.read(settingsRiverpod);
    var adCounter = readSettings.adCounter;
    if (adCounter! < 1) {
      _interstitialAdManager.loadInterstitialAd();

      ///reklamyükle
      print('+');
    } else {
      print('-');
    }
    super.initState();
  }

  void _showInterstitialAd(BuildContext context) {
    //_interstitialAdManager.loadInterstitialAd();
    _interstitialAdManager.showInterstitialAd(context);
  }

  final TextEditingController _note = TextEditingController(text: "");
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _operationType = TextEditingController(text: "Gider");
  final TextEditingController _operationTool = TextEditingController(text: "Nakit");
  final TextEditingController _registration = TextEditingController(text: "0");
  final TextEditingController _operationDate = TextEditingController(text: DateTimeManager.getCurrentDayMonthYear());
  final TextEditingController _category = TextEditingController(text: "");
  final TextEditingController _customize = TextEditingController(text: "");
  final TextEditingController _moneyType =  TextEditingController(text: "");
  void dispose() {
    _category.dispose();
    _customize.dispose();
    _note.dispose();
    _amount.dispose();
    _operationType.dispose();
    _operationTool.dispose();
    _registration.dispose();
    _operationDate.dispose();
    _moneyType.dispose();
    amountFocusNode;
    dateFocusNode;
    super.dispose();
  }
  FocusNode amountFocusNode = FocusNode();
  FocusNode dateFocusNode = FocusNode();
  CustomColors renkler = CustomColors();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: SizedBox(
        height: size.height * 0.85,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: size.width*0.95,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    typeCustomButton(context),
                    dateCustomButton(context)
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              categoryBarCustom(context, ref),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: size.width*0.95,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    toolCustomButton(context),
                    regCustomButton(context),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              noteCustomButton(context),
              const SizedBox(
                height: 15,
              ),
              customizeBarCustom(context, ref),
              const SizedBox(
                height: 15,
              ),
              amountCustomButton(),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                  width: size.width * 0.95,
                  child: Text(
                      'DEBUG: ${_operationType.text} - ${_category.text} - ${_operationTool.text} - ${int.parse(_registration.text)} - ${_amount.text} - ${_note.text} - ${_operationDate.text} -${_customize.text} - ${selectedCustomizeMenu} - ${_moneyType.text}',
                      style: const TextStyle(color: Colors.red,fontFamily: 'TL'))),
              const SizedBox(
                height: 5,
              ),
              operationCustomButton(context),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  int initialLabelIndex = 0;
  Widget typeCustomButton(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
        height: 34,
        child: ToggleSwitch(
          initialLabelIndex: initialLabelIndex,
          totalSwitches: 2,
          labels: [translation(context).expenses, translation(context).income],
          activeBgColor: const [Color(0xffF2CB05)],
          activeFgColor: const Color(0xff0D1C26),
          inactiveBgColor: Theme.of(context).highlightColor,
          inactiveFgColor: const Color(0xFFE9E9E9),
          minWidth: 92,
          cornerRadius: 15,
          radiusStyle: true,
          animate: true,
          curve: Curves.linearToEaseOut,
          customTextStyles: const [
            TextStyle(
                fontSize: 13, fontFamily: 'Nexa4',height: 1, fontWeight: FontWeight.w800)
          ],
          onToggle: (index) {
            setState(() {
              if (index == 0) {
                _operationType.text = "Gider";
                selectedCategory = 0;
                _category.clear();
                selectedValue = null;
              } else {
                _operationType.text = "Gelir";
                selectedCategory = 1;
                _category.clear();
                selectedValue = null;
              }
            });
            initialLabelIndex = index!;
          },
        ));
  }

  String? selectedValue;
  int selectedAddCategoryMenu = 0;
  int initialLabelIndex2 = 0;
  Widget categoryBarCustom(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
            height: 38,
            width: size.width * 0.92,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 2,left: 2,right: 2),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Color(0xFFF2CB05),
                    ),
                    height: 34,
                    width: (size.width * 0.92),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 130,
                      height: 38,
                      decoration: BoxDecoration(
                        color: Theme.of(context).highlightColor,
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Center(
                        child: Text(
                          translation(context).categoryDetails,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Nexa4',
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      child: SizedBox(
                        width: (size.width * 0.92) - 130,
                        child: Center(
                          child: Text(
                            _category.text == ""
                                ? "Seçmek için dokunun"
                                : _category.text,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Nexa3',
                              color: renkler.koyuuRenk
                            ),
                            maxLines: 2,
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _category.clear();
                          selectedValue = null;
                        });
                        showDialog(
                          context: context,
                          builder: (context) {
                            return categoryList(context, ref);
                          },
                        ).then((_) => setState(() {}));
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
  }
  Widget categoryList(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size;
    var readUpdateDB = ref.read(updateDataRiverpod);
    return FutureBuilder<Map<String, List<String>>>(
      future: readUpdateDB.myCategoryLists(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Bir hata oluştu: ${snapshot.error}');
        } else {
          final categoryLists = snapshot.data!;
          List<String> oldCategoryListIncome = [
            'Harçlık',
            'Burs',
            'Maaş',
            'Kredi',
            'Özel+',
            'Kira/Ödenek',
            'Fazla Mesai',
            'İş Getirisi',
            'Döviz Getirisi',
            'Yatırım Getirisi',
            'Diğer+',
          ];
          final categoryListIncome =
              categoryLists['income'] ?? ['Kategori bulunamadı'];
          List<String> oldCategoryListExpense = [
            'Yemek',
            'Giyim',
            'Eğlence',
            'Eğitim',
            'Aidat/Kira',
            'Alışveriş',
            'Özel-',
            'Ulaşım',
            'Sağlık',
            'Günlük Yaşam',
            'Hobi',
            'Diğer-'
          ];
          final categoryListExpense =
              categoryLists['expense'] ?? ['Kategori bulunamadı'];

          Set<String> mergedSetIncome = {
            ...oldCategoryListIncome,
            ...categoryListIncome
          };
          List<String> mergedIncomeList = mergedSetIncome.toList();
          Set<String> mergedSetExpens = {
            ...oldCategoryListExpense,
            ...categoryListExpense
          };
          List<String> mergedExpensList = mergedSetExpens.toList();
              return StatefulBuilder(
                builder: (context, setState) {
                  return AlertDialog(
                    backgroundColor:
                    Theme.of(context).primaryColor,
                    shadowColor: Colors.black54,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(15))),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 15),
                              child: Container(
                                width: 270,
                                height: 90,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    const BorderRadius
                                        .all(
                                        Radius.circular(
                                            15)),
                                    border: Border.all(
                                      width: 1.5,
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                    )),
                              ),
                            ),
                            Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 221,
                                    height: 30,
                                    child: ToggleSwitch(
                                      initialLabelIndex:
                                      initialLabelIndex2,
                                      totalSwitches: 2,
                                      labels: const [
                                        'SEÇ',
                                        'EKLE'
                                      ],
                                      activeBgColor: const [
                                        Color(0xffF2CB05)
                                      ],
                                      activeFgColor:
                                      const Color(
                                          0xff0D1C26),
                                      inactiveBgColor:
                                      Theme.of(context)
                                          .highlightColor,
                                      inactiveFgColor:
                                      const Color(
                                          0xFFE9E9E9),
                                      minWidth: 110,
                                      cornerRadius: 20,
                                      radiusStyle: true,
                                      animate: true,
                                      curve: Curves
                                          .linearToEaseOut,
                                      customTextStyles: const [
                                        TextStyle(
                                            fontSize: 18,
                                            fontFamily:
                                            'Nexa4',
                                            fontWeight:
                                            FontWeight
                                                .w800)
                                      ],
                                      onToggle: (index) {
                                        setState(() {
                                          if (index == 0) {
                                            selectedAddCategoryMenu =
                                            0;
                                            _category.clear();
                                          } else {
                                            selectedAddCategoryMenu =
                                            1;
                                            _category.clear();
                                          }
                                          initialLabelIndex2 =
                                          index!;
                                        });
                                      },
                                    ),
                                  ),
                                  selectedAddCategoryMenu == 0
                                      ? SizedBox(
                                    width: 200,
                                    height: 60,
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        DropdownButtonHideUnderline(
                                          child:
                                          DropdownButton2<
                                              String>(
                                            isExpanded:
                                            true,
                                            hint: Text(
                                              'Seçiniz',
                                              style:
                                              TextStyle(
                                                fontSize:
                                                18,
                                                fontFamily:
                                                'Nexa3',
                                                color: Theme.of(context)
                                                    .canvasColor,
                                              ),
                                            ),
                                            items: selectedCategory ==
                                                0
                                                ? mergedExpensList
                                                .map((item) =>
                                                DropdownMenuItem(
                                                  value: item,
                                                  child: Text(
                                                    item,
                                                    style: TextStyle(fontSize: 18, fontFamily: 'Nexa3', color: Theme.of(context).canvasColor),
                                                  ),
                                                ))
                                                .toList()
                                                : mergedIncomeList
                                                .map((item) =>
                                                DropdownMenuItem(
                                                  value: item,
                                                  child: Text(
                                                    item,
                                                    style: TextStyle(fontSize: 18, fontFamily: 'Nexa3', color: Theme.of(context).canvasColor),
                                                  ),
                                                ))
                                                .toList(),
                                            value:
                                            selectedValue,
                                            onChanged:
                                                (value) {
                                              setState(
                                                      () {
                                                    selectedValue =
                                                        value;
                                                    _category.text =
                                                        value.toString();
                                                    this.setState(
                                                            () {});
                                                  });
                                            },
                                            barrierColor: renkler
                                                .koyuAraRenk
                                                .withOpacity(
                                                0.8),
                                            buttonStyleData:
                                            ButtonStyleData(
                                              overlayColor:
                                              MaterialStatePropertyAll(
                                                  renkler.koyuAraRenk), // BAŞLANGIÇ BASILMA RENGİ
                                              padding: const EdgeInsets
                                                  .symmetric(
                                                  horizontal:
                                                  16),
                                              height:
                                              40,
                                              width:
                                              200,
                                            ),
                                            dropdownStyleData: DropdownStyleData(
                                                maxHeight: 250,
                                                width: 200,
                                                decoration: BoxDecoration(
                                                  color:
                                                  Theme.of(context).primaryColor,
                                                ),
                                                scrollbarTheme: ScrollbarThemeData(radius: const Radius.circular(15), thumbColor: MaterialStatePropertyAll(renkler.sariRenk))),
                                            menuItemStyleData:
                                            MenuItemStyleData(
                                              overlayColor:
                                              MaterialStatePropertyAll(
                                                  renkler.koyuAraRenk), // MENÜ BASILMA RENGİ
                                              height:
                                              40,
                                            ),
                                            iconStyleData:
                                            IconStyleData(
                                              icon:
                                              const Icon(
                                                Icons
                                                    .arrow_drop_down,
                                              ),
                                              iconSize:
                                              30,
                                              iconEnabledColor:
                                              Theme.of(context)
                                                  .secondaryHeaderColor,
                                              iconDisabledColor:
                                              Theme.of(context)
                                                  .secondaryHeaderColor,
                                              openMenuIcon:
                                              Icon(
                                                Icons
                                                    .arrow_right,
                                                color: Theme.of(context)
                                                    .canvasColor,
                                                size:
                                                24,
                                              ),
                                            ),
                                            dropdownSearchData:
                                            DropdownSearchData(
                                              searchController:
                                              _category,
                                              searchInnerWidgetHeight:
                                              50,
                                              searchInnerWidget:
                                              Container(
                                                height:
                                                50,
                                                padding:
                                                const EdgeInsets.only(
                                                  top:
                                                  8,
                                                  bottom:
                                                  4,
                                                  right:
                                                  8,
                                                  left:
                                                  8,
                                                ),
                                                child:
                                                TextField(
                                                  textCapitalization:
                                                  TextCapitalization.words,
                                                  expands:
                                                  true,
                                                  maxLines:
                                                  null,
                                                  style:
                                                  TextStyle(
                                                    color:
                                                    Theme.of(context).canvasColor,
                                                  ),
                                                  controller:
                                                  _category,
                                                  decoration:
                                                  InputDecoration(
                                                    isDense:
                                                    true,
                                                    contentPadding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 8,
                                                    ),
                                                    hintText:
                                                    'Kategori Arayın',
                                                    hintStyle:
                                                    TextStyle(fontSize: 18, color: Theme.of(context).secondaryHeaderColor),
                                                    border:
                                                    OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              searchMatchFn:
                                                  (item,
                                                  searchValue) {
                                                return item
                                                    .value
                                                    .toString()
                                                    .contains(searchValue);
                                              },
                                            ),
                                            //This to clear the search value when you close the menu
                                            onMenuStateChange:
                                                (isOpen) {
                                              if (!isOpen) {
                                                _category
                                                    .clear();
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                      : const SizedBox(),
                                  selectedAddCategoryMenu == 1
                                      ? SizedBox(
                                    width: 220,
                                    height: 60,
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextField(
                                          maxLength: 20,
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: Theme.of(
                                                  context)
                                                  .canvasColor,
                                              fontSize:
                                              17,
                                              fontFamily:
                                              'Nexa3'),
                                          decoration: InputDecoration(
                                              hintText:
                                              'Kategoriyi yazınız',
                                              hintStyle: TextStyle(
                                                  color: Theme.of(context)
                                                      .canvasColor,
                                                  fontSize:
                                                  18,
                                                  fontFamily:
                                                  'Nexa3'),
                                              counterText:
                                              '',
                                              border: InputBorder
                                                  .none),
                                          cursorRadius:
                                          const Radius
                                              .circular(10),
                                          keyboardType:
                                          TextInputType
                                              .text,
                                          textCapitalization:
                                          TextCapitalization
                                              .words,
                                          controller:
                                          _category,
                                          onChanged:
                                              (value) {
                                            setState(
                                                    () {
                                                  this.setState(
                                                          () {});
                                                });
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                      : const SizedBox(),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceAround,
                                    children: [
                                      initialLabelIndex2 == 1
                                          ? SizedBox(
                                        width: 80,
                                        height: 30,
                                        child: Align(
                                          alignment:
                                          Alignment
                                              .centerLeft,
                                          child: Text(
                                            '${_category.text.length.toString()}/20',
                                            style:
                                            TextStyle(
                                              backgroundColor:
                                              Theme.of(context)
                                                  .primaryColor,
                                              color: const Color(
                                                  0xffF2CB05),
                                              fontSize:
                                              13,
                                              fontFamily:
                                              'Nexa4',
                                              fontWeight:
                                              FontWeight
                                                  .w800,
                                            ),
                                          ),
                                        ),
                                      )
                                          : const SizedBox(
                                        width: 80,
                                      ),
                                      SizedBox(
                                        width: 80,
                                        height: 30,
                                        child: TextButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                              MaterialStatePropertyAll(
                                                  renkler
                                                      .sariRenk),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        20),
                                                  ))),
                                          onPressed: () {
                                            Navigator.of(
                                                context)
                                                .pop();
                                          },
                                          child: Text(
                                            translation(context).ok,
                                            style: TextStyle(
                                              color: renkler
                                                  .koyuuRenk,
                                              fontSize: 16,
                                              height: 1,
                                              fontFamily:
                                              'Nexa3',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Debug:${_category.text}",
                          style: const TextStyle(
                              color: Colors.red),
                        )
                      ],
                    ),
                  );
                },
              );
        }
      },
    );
  }

  String? selectedValueCustomize;
  int initialLabelIndexCustomize = 0;
  int selectedCustomizeMenu = 0;

  Widget customizeBarCustom(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size;
    List<String> repetitiveList = [
      "Günlük",
      "Haftalık",
      "İki Haftada Bir",
      "Aylık",
      "İki Ayda Bir",
      "Üç Aylık",
      "Dört Ayda Bir",
      "Altı Ayda Bir",
      "Yıllık"
    ];

    return SizedBox(
      height: 38,
      width: size.width * 0.92,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2,left: 2,right: 2),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Color(0xFFF2CB05),
              ),
              height: 34,
              width: size.width * 0.92,
            ),
          ),
          Row(
            children: [
              Container(
                width: 130,
                height: 38,
                decoration: BoxDecoration(
                  color: Theme.of(context).highlightColor,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: const Center(
                  child: Text(
                    "ÖZELLEŞTİR",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Nexa4',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              InkWell(
                child: SizedBox(
                  width: size.width * 0.92 - 130,
                  child: Center(
                    child: Text(
                      _customize.text == ""
                          ? "Özelleştirmek için dokunun"
                          : selectedCustomizeMenu == 0
                          ? '${_customize.text} Tekrar'
                          : '${_customize.text} Ay Taksit',
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Nexa3',
                          color: renkler.koyuuRenk
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    _customize.clear();
                    selectedValueCustomize = null;
                  });
                  showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return AlertDialog(
                            backgroundColor: Theme.of(context).primaryColor,
                            shadowColor: Colors.black54,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Stack(
                                  children: [
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(top: 15),
                                      child: Container(
                                        width: 270,
                                        height: 90,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            const BorderRadius.all(
                                                Radius.circular(15)),
                                            border: Border.all(
                                              width: 1.5,
                                              color: Theme.of(context)
                                                  .secondaryHeaderColor,
                                            )),
                                      ),
                                    ),
                                    Center(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            width: 221,
                                            height: 30,
                                            child: ToggleSwitch(
                                              initialLabelIndex:
                                              initialLabelIndexCustomize,
                                              totalSwitches: 2,
                                              labels: const [
                                                'TEKRAR',
                                                'TAKSİT'
                                              ],
                                              activeBgColor: const [
                                                Color(0xffF2CB05)
                                              ],
                                              activeFgColor:
                                              const Color(0xff0D1C26),
                                              inactiveBgColor:
                                              Theme.of(context)
                                                  .highlightColor,
                                              inactiveFgColor:
                                              const Color(0xFFE9E9E9),
                                              minWidth: 110,
                                              cornerRadius: 20,
                                              radiusStyle: true,
                                              animate: true,
                                              curve: Curves.linearToEaseOut,
                                              customTextStyles: const [
                                                TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: 'Nexa4',
                                                    fontWeight:
                                                    FontWeight.w800)
                                              ],
                                              onToggle: (index) {
                                                setState(() {
                                                  if (index == 0) {
                                                    selectedCustomizeMenu =
                                                    0;
                                                    _customize.clear();
                                                  } else {
                                                    selectedCustomizeMenu =
                                                    1;
                                                    _customize.clear();
                                                  }
                                                  initialLabelIndexCustomize =
                                                  index!;
                                                });
                                              },
                                            ),
                                          ),
                                          selectedCustomizeMenu == 0
                                              ? SizedBox(
                                            width: 200,
                                            height: 60,
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                DropdownButtonHideUnderline(
                                                  child:
                                                  DropdownButton2<
                                                      String>(
                                                    isExpanded: true,
                                                    hint: Text(
                                                      'Seçiniz',
                                                      style:
                                                      TextStyle(
                                                        fontSize: 18,
                                                        fontFamily:
                                                        'Nexa3',
                                                        color: Theme.of(
                                                            context)
                                                            .canvasColor,
                                                      ),
                                                    ),
                                                    items:
                                                    repetitiveList
                                                        .map((item) =>
                                                        DropdownMenuItem(
                                                          value:
                                                          item,
                                                          child:
                                                          Text(
                                                            item,
                                                            style: TextStyle(fontSize: 18, fontFamily: 'Nexa3', color: Theme.of(context).canvasColor),
                                                          ),
                                                        ))
                                                        .toList(),
                                                    value:
                                                    selectedValueCustomize,
                                                    onChanged:
                                                        (value) {
                                                      setState(() {
                                                        selectedValueCustomize =
                                                            value;
                                                        _customize
                                                            .text =
                                                            value
                                                                .toString();
                                                        this.setState(
                                                                () {});
                                                      });
                                                    },
                                                    barrierColor: renkler
                                                        .koyuAraRenk
                                                        .withOpacity(
                                                        0.8),
                                                    buttonStyleData:
                                                    ButtonStyleData(
                                                      overlayColor:
                                                      MaterialStatePropertyAll(
                                                          renkler
                                                              .koyuAraRenk), // BAŞLANGIÇ BASILMA RENGİ
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal:
                                                          16),
                                                      height: 40,
                                                      width: 200,
                                                    ),
                                                    dropdownStyleData:
                                                    DropdownStyleData(
                                                        maxHeight:
                                                        250,
                                                        width:
                                                        200,
                                                        decoration:
                                                        BoxDecoration(
                                                          color: Theme.of(context)
                                                              .primaryColor,
                                                        ),
                                                        scrollbarTheme: ScrollbarThemeData(
                                                            radius: const Radius.circular(
                                                                15),
                                                            thumbColor:
                                                            MaterialStatePropertyAll(renkler.sariRenk))),
                                                    menuItemStyleData:
                                                    MenuItemStyleData(
                                                      overlayColor:
                                                      MaterialStatePropertyAll(
                                                          renkler
                                                              .koyuAraRenk), // MENÜ BASILMA RENGİ
                                                      height: 40,
                                                    ),
                                                    iconStyleData:
                                                    IconStyleData(
                                                      icon:
                                                      const Icon(
                                                        Icons
                                                            .arrow_drop_down,
                                                      ),
                                                      iconSize: 30,
                                                      iconEnabledColor:
                                                      Theme.of(
                                                          context)
                                                          .secondaryHeaderColor,
                                                      iconDisabledColor:
                                                      Theme.of(
                                                          context)
                                                          .secondaryHeaderColor,
                                                      openMenuIcon:
                                                      Icon(
                                                        Icons
                                                            .arrow_right,
                                                        color: Theme.of(
                                                            context)
                                                            .canvasColor,
                                                        size: 24,
                                                      ),
                                                    ),
                                                    onMenuStateChange:
                                                        (isOpen) {
                                                      if (!isOpen) {
                                                        _customize
                                                            .clear();
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                              : const SizedBox(),
                                          selectedCustomizeMenu == 1
                                              ? SizedBox(
                                            width: 220,
                                            height: 60,
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                TextField(
                                                  maxLength: 3,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      color: Theme.of(
                                                          context)
                                                          .canvasColor,
                                                      fontSize: 17,
                                                      fontFamily:
                                                      'Nexa3'),
                                                  decoration:
                                                  InputDecoration(
                                                      hintText:
                                                      'Ay sayısını yazınız (1-144)',
                                                      hintStyle: TextStyle(
                                                          color: Theme.of(context)
                                                              .canvasColor,
                                                          fontSize:
                                                          15,
                                                          fontFamily:
                                                          'Nexa3'),
                                                      suffixText:
                                                      'Ay',
                                                      suffixStyle:
                                                      TextStyle(
                                                        color: Theme.of(
                                                            context)
                                                            .canvasColor,
                                                        fontSize:
                                                        16,
                                                        fontFamily:
                                                        'Nexa3',
                                                      ),
                                                      counterText:
                                                      '',
                                                      border:
                                                      InputBorder
                                                          .none),
                                                  cursorRadius:
                                                  const Radius
                                                      .circular(10),
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(RegExp(
                                                        r'^(1[0-4][0-4]|[1-9][0-9]|[1-9])$')),
                                                  ],
                                                  keyboardType:
                                                  const TextInputType
                                                      .numberWithOptions(
                                                      signed:
                                                      false,
                                                      decimal:
                                                      false),
                                                  controller:
                                                  _customize,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      this.setState(
                                                              () {});
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          )
                                              : const SizedBox(),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceAround,
                                            children: [
                                              initialLabelIndexCustomize ==
                                                  1
                                                  ? SizedBox(
                                                width: 80,
                                                height: 30,
                                                child: Align(
                                                  alignment: Alignment
                                                      .centerLeft,
                                                  child: Text(
                                                    'Aylık Taksit',
                                                    style: TextStyle(
                                                      backgroundColor:
                                                      Theme.of(
                                                          context)
                                                          .primaryColor,
                                                      color: const Color(
                                                          0xffF2CB05),
                                                      fontSize: 13,
                                                      fontFamily:
                                                      'Nexa4',
                                                      fontWeight:
                                                      FontWeight
                                                          .w800,
                                                    ),
                                                  ),
                                                ),
                                              )
                                                  : SizedBox(
                                                width: 100,
                                                height: 26,
                                                child: TextButton(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                      MaterialStatePropertyAll(
                                                          Theme.of(context)
                                                              .highlightColor),
                                                      shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                20),
                                                          ))),
                                                  onPressed: () {
                                                    setState(() {
                                                      selectedValueCustomize =
                                                      null;
                                                      _customize
                                                          .text = "";
                                                      this.setState(
                                                              () {});
                                                    });
                                                  },
                                                  child: Text(
                                                    "Seçimi Kaldır",
                                                    style: TextStyle(
                                                      color: renkler
                                                          .arkaRenk,
                                                      fontSize: 12,
                                                      fontFamily:
                                                      'Nexa3',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 80,
                                                height: 30,
                                                child: TextButton(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                      MaterialStatePropertyAll(
                                                          renkler
                                                              .sariRenk),
                                                      shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                20),
                                                          ))),
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop();
                                                  },
                                                  child: Text(
                                                    translation(context).ok,
                                                    style: TextStyle(
                                                      color:
                                                      renkler.koyuuRenk,
                                                      fontSize: 16,
                                                      fontFamily: 'Nexa3',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Debug:${_customize.text}",
                                  style: const TextStyle(color: Colors.red),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ).then((_) => setState(() {}));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  DateTime? _selectedDate;
  Widget dateCustomButton(BuildContext context) {
    Future<void> selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate ?? DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2030),
        //helpText: 'Tarih Seçiniz',
        //cancelText: 'İptal Et',
        //confirmText: 'Tamam',
        fieldLabelText: 'Tarih Girişi Aktif Değil',
        keyboardType: TextInputType.number,
        builder: (context, child) {
          FocusScope.of(context).unfocus();
          return Theme(
            data: Theme.of(context).copyWith(
              textTheme: TextTheme(
                  labelLarge: TextStyle(

                      ///buton yazıları
                      fontFamily: 'Nexa3',
                      fontSize: 16,
                      color: renkler.koyuuRenk),
                  labelSmall: TextStyle(

                      ///tarih seçiniz
                      fontSize: 16,
                      fontFamily: 'Nexa3',
                      color: renkler.yesilRenk),
                  titleSmall: TextStyle(

                      ///ay ve yıl
                      fontSize: 16,
                      fontFamily: 'Nexa3',
                      color: renkler.koyuuRenk),
                  headlineMedium: TextStyle(

                      ///gün ay gün
                      fontSize: 26,
                      fontFamily: 'Nexa3',
                      color: renkler.koyuuRenk),
                  bodySmall: TextStyle(

                      ///ana tarihler
                      fontSize: 16,
                      fontFamily: 'Nexa3',
                      color: renkler.kirmiziRenk),
                  titleMedium: TextStyle(

                      ///tarih yazma rengi
                      fontSize: 16,
                      fontFamily: 'Nexa3',
                      color: renkler.kirmiziRenk),
                  bodyLarge: TextStyle(

                      ///alt YILLAR
                      fontSize: 16,
                      fontFamily: 'Nexa3',
                      color: renkler.koyuuRenk),
                  headlineLarge: TextStyle(
                      fontFamily: 'Nexa4',
                      fontSize: 18,
                      color: renkler.yesilRenk,
                      fontWeight: FontWeight.w900)),
              colorScheme: ColorScheme(
                brightness: Brightness.light,
                primary: renkler.arkaRenk, // üst taraf arkaplan rengi
                onPrimary: renkler.koyuuRenk, //üst taraf yazı rengi
                secondary: renkler.kirmiziRenk,
                onSecondary: renkler.arkaRenk,
                primaryContainer: renkler.kirmiziRenk,
                error: const Color(0xFFD91A2A),
                onError: const Color(0xFFD91A2A),
                background: renkler.kirmiziRenk,
                onBackground: renkler.yesilRenk,
                surface: renkler.koyuuRenk, //ÜST TARAF RENK
                onPrimaryContainer: renkler.yesilRenk,
                onSurface: renkler.koyuuRenk, //alt günlerin rengi
              ),
            ),
            child: child!,
          );
        },
      );

      if (picked != null) {
        setState(() {
          _selectedDate = picked;
          _operationDate.text = intl.DateFormat('dd.MM.yyyy').format(_selectedDate!);
        });
      }
    }

    return SizedBox(
      height: 38,
      width: 175,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                color: Theme.of(context).highlightColor,
              ),
              height: 34,
              width: 173,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 65,
                child: Center(
                  child: Text(translation(context).date,
                      style: TextStyle(
                        height: 1,
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Nexa4',
                          fontWeight: FontWeight.w800,)),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  color: Color(0xffF2CB05),
                ),
                child: SizedBox(
                  height: 38,
                  width: 110,
                  child: TextFormField(
                    focusNode: dateFocusNode,
                    onTap: () {
                      selectDate(context);
                      FocusScope.of(context).unfocus();
                    },
                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                    },
                    style: const TextStyle(
                        color: Color(0xff0D1C26),
                        fontSize: 14,
                        fontFamily: 'Nexa4',
                        fontWeight: FontWeight.w800),
                    controller: _operationDate,
                    autofocus: false,
                    keyboardType: TextInputType.datetime,
                    textAlign: TextAlign.center,
                    readOnly: true,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.only(top: 12)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  double moneyTypeWidth = 38.0;
  double moneyTypeHeight = 38.0;
  bool openMoneyTypeMenu = false;
  //ref.read(settingsRiverpod).prefixSymbolfinal
  Widget amountCustomButton() {
    String getSymbolForMoneyType(){
      String controller = _moneyType.text;
      if(controller == 'TRY'){
        return '₺';
      }else if (controller == 'USD'){
        return '\$';
      }
      else if (controller == 'EUR'){
        return '€';
      }
      else if (controller == 'GBP'){
        return '£';
      }
      else if (controller == 'KWD'){
        return 'د.ك';
      }
      else if (controller == 'JOD'){
        return 'د.أ';
      }
      else if (controller == 'IQD'){
        return 'د.ع';
      }
      else if (controller == 'SAR'){
        return 'ر.س';
      }
      else{
        setState(() {
          _moneyType.text = ref.read(settingsRiverpod).Prefix.toString();
        });
        return ref.read(settingsRiverpod).prefixSymbol.toString().replaceAll(' ', '');}
    }
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.92,
      child: Stack(
        children: [
          Positioned(
            top: 40,
            child: Container(
              width: size.width * 0.92,
              height: 4,
              decoration: BoxDecoration(
                  color: Theme.of(context).highlightColor,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
            ),
          ),
          Center(
            child: SizedBox(
              width: 250,
              height:80,
              child: Row(
                children: [
                  openMoneyTypeMenu == false ? SizedBox(
                    height: 38,
                    width: 207,
                    child: Stack(
                      children: [
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(40)),
                              color: Theme.of(context).highlightColor,
                            ),
                            height: 34,
                            width: 205,
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 95,
                              child: Center(
                                child: Text(translation(context).amountDetails,
                                    style: TextStyle(
                                      height: 1,
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: 'Nexa4',
                                        fontWeight: FontWeight.w800)),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                color: Color(0xffF2CB05),
                              ),
                              child: SizedBox(
                                height: 38,
                                width: 112,
                                child: TextFormField(
                                    onTap: () {
                                      //_amount.clear();
                                    },
                                    style: const TextStyle(
                                        color: Color(0xff0D1C26),
                                        fontSize: 17,
                                        fontFamily: 'Nexa4',
                                        fontWeight: FontWeight.w100),
                                    controller: _amount,
                                    autofocus: false,
                                    focusNode: amountFocusNode,
                                    keyboardType: const TextInputType.numberWithOptions(
                                        decimal: true),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d{0,5}(\.\d{0,2})?'),
                                      )
                                    ],
                                    textAlign: TextAlign.center,
                                    onEditingComplete: () {
                                      FocusScope.of(context).unfocus();
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        isDense: true,
                                        hintText: "00.00",
                                        hintStyle: TextStyle(
                                          color: renkler.koyuAraRenk,
                                        ),
                                        contentPadding: const EdgeInsets.only(top: 12))),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ) : const SizedBox(),
                  openMoneyTypeMenu == false ? const SizedBox(width: 5,): const SizedBox(),
                  InkWell(
                    onTap: () {
                      setState(() {
                        openMoneyTypeMenu == false ? openMoneyTypeMenu = true : openMoneyTypeMenu = false;
                        openMoneyTypeMenu == true ? moneyTypeWidth = 250 : moneyTypeWidth = 38;
                        openMoneyTypeMenu == true ? moneyTypeHeight = 80 : moneyTypeHeight = 38;
                      });
                    },
                    child:  Container(
                        height: moneyTypeHeight,
                        width: moneyTypeWidth,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Color(0xffF2CB05),
                        ),
                        child: openMoneyTypeMenu == false ? Center(
                          child:  Text(
                            getSymbolForMoneyType(),
                            style: const TextStyle(
                              height: 1,
                              fontFamily: 'TL',
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff0D1C26),
                            ),
                          ),
                        ) : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _moneyType.text = 'TRY';
                                      openMoneyTypeMenu = false;
                                      moneyTypeWidth = 38.0;
                                      moneyTypeHeight = 38.0;
                                    });
                                  },
                                  child: Container(
                                    width: 44,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                                      color: renkler.koyuuRenk,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "TRY", style: TextStyle(fontSize: 14,fontFamily: 'Nexa4',color: renkler.arkaRenk),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _moneyType.text = 'USD';
                                      openMoneyTypeMenu = false;
                                      moneyTypeWidth = 38.0;
                                      moneyTypeHeight = 38.0;
                                    });
                                  },
                                  child:Container(
                                    width: 44,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                                      color: renkler.koyuuRenk,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "USD", style: TextStyle(fontSize: 14,fontFamily: 'Nexa4',color: renkler.arkaRenk),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _moneyType.text = 'EUR';
                                      openMoneyTypeMenu = false;
                                      moneyTypeWidth = 38.0;
                                      moneyTypeHeight = 38.0;
                                    });
                                  },
                                  child: Container(
                                    width: 44,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                                      color: renkler.koyuuRenk,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "EUR", style: TextStyle(fontSize: 14,fontFamily: 'Nexa4',color: renkler.arkaRenk),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _moneyType.text = 'GBP';
                                      openMoneyTypeMenu = false;
                                      moneyTypeWidth = 38.0;
                                      moneyTypeHeight = 38.0;
                                    });
                                  },
                                  child: Container(
                                    width: 44,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                                      color: renkler.koyuuRenk,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "GBP", style: TextStyle(fontSize: 14,fontFamily: 'Nexa4',color: renkler.arkaRenk),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _moneyType.text = 'KWD';
                                      openMoneyTypeMenu = false;
                                      moneyTypeWidth = 38.0;
                                      moneyTypeHeight = 38.0;
                                    });
                                  },
                                  child: Container(
                                    width: 44,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                                      color: renkler.koyuuRenk,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "KWD", style: TextStyle(fontSize: 14,fontFamily: 'Nexa4',color: renkler.arkaRenk),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _moneyType.text = 'JOD';
                                      openMoneyTypeMenu = false;
                                      moneyTypeWidth = 38.0;
                                      moneyTypeHeight = 38.0;
                                    });
                                  },
                                  child: Container(
                                    width: 44,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                                      color: renkler.koyuuRenk,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "JOD", style: TextStyle(fontSize: 14,fontFamily: 'Nexa4',color: renkler.arkaRenk),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _moneyType.text = 'IQD';
                                      openMoneyTypeMenu = false;
                                      moneyTypeWidth = 38.0;
                                      moneyTypeHeight = 38.0;
                                    });
                                  },
                                  child:Container(
                                    width: 44,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                                      color: renkler.koyuuRenk,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "IQD", style: TextStyle(fontSize: 14,fontFamily: 'Nexa4',color: renkler.arkaRenk),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _moneyType.text = 'SAR';
                                      openMoneyTypeMenu = false;
                                      moneyTypeWidth = 38.0;
                                      moneyTypeHeight = 38.0;
                                    });
                                  },
                                  child: Container(
                                    width: 44,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                                      color: renkler.koyuuRenk,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "SAR", style: TextStyle(fontSize: 14,fontFamily: 'Nexa4',color: renkler.arkaRenk),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  int selectedCategory = 0;
  int initialLabelIndexTool = 0;
  Widget toolCustomButton(BuildContext context) {
    return SizedBox(
        height: 34,
        child: ToggleSwitch(
          initialLabelIndex: initialLabelIndexTool,
          totalSwitches: 3,
          dividerColor: Theme.of(context).highlightColor,
          labels:  [translation(context).cash, translation(context).card, translation(context).otherPaye],
          activeBgColor: const [Color(0xffF2CB05)],
          activeFgColor: const Color(0xff0D1C26),
          inactiveBgColor: Theme.of(context).highlightColor,
          inactiveFgColor: const Color(0xFFE9E9E9),
          minWidth: 70,
          cornerRadius: 15,
          radiusStyle: true,
          animate: true,
          curve: Curves.linearToEaseOut,
          customTextStyles: const [
            TextStyle(
                fontSize: 13, fontFamily: 'Nexa4', fontWeight: FontWeight.w800)
          ],
          onToggle: (index) {
            if (index == 0) {
              _operationTool.text = "Nakit";
            } else if (index == 1) {
              _operationTool.text = "Kart";
            } else {
              _operationTool.text = "Diğer";
            }
            initialLabelIndexTool = index!;
          },
        ));
  }

  int regss = 0;
  Widget regCustomButton(BuildContext context) {
    return SizedBox(
      height: 38,
      width: 126,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top:2),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                color: Theme.of(context).highlightColor,
              ),
              height: 34,
              width: 120,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 86,
                child: Center(
                  child: Text(translation(context).save,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Nexa4',
                          fontWeight: FontWeight.w800)),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Color(0xffF2CB05),
                ),
                child: SizedBox(
                  height: 38,
                  width: 38,
                  child: registration(regss),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget registration(int regs) {
    if (regs == 0) {
      return IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            setState(() {
              regss = 1;
              _registration.text = '1';
            });
          },
          icon: const Icon(
            Icons.bookmark_add_outlined,
            color: Colors.white,
          ));
    } else {
      return IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            setState(() {
              regss = 0;
              _registration.text = '0';
            });
          },
          icon: const Icon(
            Icons.bookmark,
            color: Color(0xff0D1C26),
          ));
    }
  }

  int maxLength = 108;
  int textLength = 0;
  Widget noteCustomButton(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.92,
      height: 125,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              height: 90,
              width: size.width * 0.92,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  border: Border.all(
                      color: Theme.of(context).highlightColor, width: 1.5),
                ),
              ),
            ),
          ),
          SizedBox(
            width: size.width * 0.9,
            height: 115,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18, top: 34,right: 18),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: translation(context).clickToAddNote,
                        hintStyle: TextStyle(
                          color: Theme.of(context).canvasColor,
                        ),
                        counterText: "",
                        border: InputBorder.none),
                    cursorRadius: const Radius.circular(10),
                    autofocus: false,
                    maxLength: maxLength,
                    maxLines: 3,
                    onChanged: (value) {
                      setState(() {
                        textLength = value.length;
                      });
                    },
                    keyboardType: TextInputType.text,
                    controller: _note,
                    //maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  ),
                ),
                Positioned(
                    bottom: 0,
                    right: 20,
                    child: Text(
                      '${textLength.toString()}/${maxLength.toString()}',
                      style: TextStyle(
                        backgroundColor: Theme.of(context).splashColor,
                        color: const Color(0xffF2CB05),
                        fontSize: 13,
                        fontFamily: 'Nexa4',
                        fontWeight: FontWeight.w800,
                      ),
                    )),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: SizedBox(
                  width: 114,
                  height: 38,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                    child: Center(
                      child: Text(
                        translation(context).addNote,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 15,
                          fontFamily: 'Nexa4',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20,left: 20),
                child: SizedBox(
                  width: 60,
                  height: 26,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Theme.of(context).shadowColor,
                    ),
                    child: TextButton(
                      onPressed: () {
                        textLength = 0;
                        setState(() {
                          _note.text = "";

                        });
                      },
                      child: Text(
                        translation(context).delete,
                        style: TextStyle(
                          height: 1,
                          color: Theme.of(context).canvasColor,
                          fontSize: 12,
                          fontFamily: 'Nexa4',
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }

  Widget operationCustomButton(BuildContext context) {
    var read = ref.read(databaseRiverpod);
    var read2 = ref.read(botomNavBarRiverpod);
    var readHome = ref.read(homeRiverpod);
    var size = MediaQuery.of(context).size;
    var readSettings = ref.read(settingsRiverpod);
    var adCounter = readSettings.adCounter;
    String alertContent = '';
    int alertOperator = 0;
    double amount = double.tryParse(_amount.text) ?? 0.0;
    void setAlertContent(BuildContext context) {
      if (amount == 0 && _category.text.isEmpty) {
        alertContent = "Lütfen bir tutar ve bir kategori giriniz!";
        alertOperator = 1;
      } else if (_category.text.isNotEmpty) {
        alertContent = translation(context).pleaseEnterAnAmount;
        alertOperator = 2;
      } else {
        alertContent = "Lütfen bir kategori giriniz!";
        alertOperator = 3;
      }
    }

    return Directionality(
      textDirection: TextDirection.ltr,
      child: SizedBox(
        width: size.width * 0.95,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 130,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Theme.of(context).shadowColor,
                    ),
                    height: 28,
                    width: 130,
                    child: TextButton(
                      onPressed: () {
                        _note.text = "";
                        _amount.text = "";
                        textLength = 0;
                        setState(() {
                          _category.text = "";
                          _customize.text = "";

                        });
                        //operationCustomButton(context);
                      },
                      child: Text(translation(context).deleteAll,
                          style: TextStyle(
                            height: 1,
                              color: Theme.of(context).canvasColor,
                              fontSize: 15,
                              fontFamily: 'Nexa4',
                              fontWeight: FontWeight.w900)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 150,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: renkler.sariRenk,
                    ),
                    height: 34,
                    width: 150,
                    child: TextButton(
                      onPressed: () {
                        setAlertContent(context);
                        double amount = double.tryParse(_amount.text) ?? 0.0;
                        if (amount != 0.0 && _category.text.isNotEmpty) {
                          if (selectedCustomizeMenu == 1 &&
                              _customize.text != "") {
                            /*
                            readUpdateData.customizeOperation(
                                _customize.text,
                                _operationDate.text,
                                _operationType.text,
                                _category.text,
                                _operationTool.text,
                                int.parse(_registration.text),
                                amount,
                                _note.text);*/
                            int installmentCount = int.parse(_customize.text);
                            amount = amount / double.parse(_customize.text);
                            _note.text =
                                "${_note.text} (1/${_customize.text} taksit işlendi)";
                            _customize.text = "1/${_customize.text}";
                          } else if (selectedCustomizeMenu == 0 &&
                              _customize.text != "") {
                            _note.text =
                                "${_note.text} (${_customize.text} olan tekrar işlendi)";
                          }
                          read.insertDataBase(
                              _operationType.text,
                              _category.text,
                              _operationTool.text,
                              int.parse(_registration.text),
                              amount,
                              _note.text,
                              _operationDate.text,
                              _moneyType.text,
                              ref.read(currencyRiverpod).calculateRealAmount(amount, _moneyType.text, ref.read(settingsRiverpod).Prefix!),
                              _customize.text,)
                              ;

                          if (adCounter == 0) {
                            _showInterstitialAd(context);

                            ///reklam
                            readSettings.resetAdCounter();

                            ///2 leme
                          } else {
                            readSettings.useAdCounter();

                            ///eksi 1
                          }
                          Navigator.of(context).pop();
                          read2.setCurrentindex(0);
                          readHome.setStatus();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Theme.of(context).highlightColor,
                              duration: const Duration(seconds: 1),
                              content: Text(
                                translation(context).activityAdded,
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
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: Theme.of(context).primaryColor,
                                  title: Text("Eksik İşlem Yaptınız",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .secondaryHeaderColor,
                                          fontSize: 22,
                                          fontFamily: 'Nexa3')),
                                  content: Text(
                                    alertContent,
                                    style: TextStyle(
                                        color: Theme.of(context).canvasColor,
                                        fontSize: 16,
                                        fontFamily: 'Nexa3'),
                                  ),
                                  shadowColor: renkler.koyuuRenk,
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        if (alertOperator == 1) {
                                          _amount.clear();
                                          _category.clear();
                                        } else if (alertOperator == 2) {
                                          _amount.clear();
                                        } else if (alertOperator == 3) {
                                          _category.clear();
                                        } else {
                                          _amount.clear();
                                          _category.clear();
                                        }
                                        Navigator.of(context).pop();
                                        //FocusScope.of(context).requestFocus(amountFocusNode);
                                      },
                                      child: Text(
                                        translation(context).ok,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .secondaryHeaderColor,
                                            fontSize: 18,
                                            height: 1,
                                            fontFamily: 'Nexa3'),
                                      ),
                                    )
                                  ],
                                );
                              });
                        }
                      },
                      child: Text(translation(context).done,
                          style: TextStyle(
                            height: 1,
                              color: renkler.koyuuRenk,
                              fontSize: 16,
                              fontFamily: 'Nexa4',
                              fontWeight: FontWeight.w900)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/*
  Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                color: Color(0xff0D1C26),
              ),
              height: 34,
              width: 130,
            ),
          ),
          Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 1200),
                curve: Curves.fastLinearToSlowEaseIn,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  color: _containerColorType,
                ),
                height: heightType2_,
                child: SizedBox(
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeColorType(0);
                          _operationType.text = "Gider";
                          selectedCategory = 0;
                          _category.text = 'Yemek';
                        });
                      },
                      child: Text("GİDER",
                          style: TextStyle(
                              color: _textColorType,
                              fontSize: 17,
                              fontFamily: 'Nexa4',
                              fontWeight: FontWeight.w800))),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 1200),
                curve: Curves.fastLinearToSlowEaseIn,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  color: _containerColorType2,
                ),
                height: heightType_,
                child: SizedBox(
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeColorType(1);
                          _operationType.text = "Gelir";
                          selectedCategory = 1;
                          _category.text = 'Harçlık';
                        });
                      },
                      child: Text("GELİR",
                          style: TextStyle(
                              color: _textColorType2,
                              fontSize: 17,
                              fontFamily: 'Nexa4',
                              fontWeight: FontWeight.w800))),
                ),
              ),
            ],
          ),
        ],
      ),
   */
/*
  Color colorContainerYemek = const Color(0xffF2CB05);
  Color colorContainerGiyim = Colors.white;
  Color colorContainerEglence = Colors.white;
  Color colorContainerEgitim = Colors.white;
  Color colorContainerAidat = Colors.white;
  Color colorContainerAlisveris = Colors.white;
  Color colorContainerOzel = Colors.white;
  Color colorContainerUlasim = Colors.white;
  Color colorContainerSaglik = Colors.white;
  Color colorContainerGunluk = Colors.white;
  Color colorContainerHobi = Colors.white;
  Color colorContainerDiger = Colors.white;

  Color colorTextYemek = Colors.white;
  Color colorTextGiyim = const Color(0xff0D1C26);
  Color colorTextEglence = const Color(0xff0D1C26);
  Color colorTextEgitim = const Color(0xff0D1C26);
  Color colorTextAidat = const Color(0xff0D1C26);
  Color colorTextAlisveris = const Color(0xff0D1C26);
  Color colorTextOzel = const Color(0xff0D1C26);
  Color colorTextUlasim = const Color(0xff0D1C26);
  Color colorTextSaglik = const Color(0xff0D1C26);
  Color colorTextGunluk = const Color(0xff0D1C26);
  Color colorTextHobi = const Color(0xff0D1C26);
  Color colorTextDiger = const Color(0xff0D1C26);
  Widget categoryCustomButton(BuildContext context) {
    void resetColor() {
      colorContainerYemek = Colors.white;
      colorContainerGiyim = Colors.white;
      colorContainerEglence = Colors.white;
      colorContainerEgitim = Colors.white;
      colorContainerAidat = Colors.white;
      colorContainerAlisveris = Colors.white;
      colorContainerOzel = Colors.white;
      colorContainerUlasim = Colors.white;
      colorContainerSaglik = Colors.white;
      colorContainerGunluk = Colors.white;
      colorContainerHobi = Colors.white;
      colorContainerDiger = Colors.white;
      colorTextYemek = const Color(0xff0D1C26);
      colorTextGiyim = const Color(0xff0D1C26);
      colorTextEglence = const Color(0xff0D1C26);
      colorTextEgitim = const Color(0xff0D1C26);
      colorTextAidat = const Color(0xff0D1C26);
      colorTextAlisveris = const Color(0xff0D1C26);
      colorTextOzel = const Color(0xff0D1C26);
      colorTextUlasim = const Color(0xff0D1C26);
      colorTextSaglik = const Color(0xff0D1C26);
      colorTextGunluk = const Color(0xff0D1C26);
      colorTextHobi = const Color(0xff0D1C26);
      colorTextDiger = const Color(0xff0D1C26);
    }

    void changeCategoryColor1(int index) {
      if (index == 1) {
        resetColor();
        colorContainerYemek = const Color(0xffF2CB05);
        colorTextYemek = Colors.white;
      } else if (index == 2) {
        resetColor();
        colorContainerGiyim = const Color(0xffF2CB05);
        colorTextGiyim = Colors.white;
      } else if (index == 3) {
        resetColor();
        colorContainerEglence = const Color(0xffF2CB05);
        colorTextEglence = Colors.white;
      } else if (index == 4) {
        resetColor();
        colorContainerEgitim = const Color(0xffF2CB05);
        colorTextEgitim = Colors.white;
      } else if (index == 5) {
        resetColor();
        colorContainerAidat = const Color(0xffF2CB05);
        colorTextAidat = Colors.white;
      } else if (index == 6) {
        resetColor();
        colorContainerAlisveris = const Color(0xffF2CB05);
        colorTextAlisveris = Colors.white;
      } else if (index == 7) {
        resetColor();
        colorContainerOzel = const Color(0xffF2CB05);
        colorTextOzel = Colors.white;
      } else if (index == 8) {
        resetColor();
        colorContainerUlasim = const Color(0xffF2CB05);
        colorTextUlasim = Colors.white;
      } else if (index == 9) {
        resetColor();
        colorContainerSaglik = const Color(0xffF2CB05);
        colorTextSaglik = Colors.white;
      } else if (index == 10) {
        resetColor();
        colorContainerGunluk = const Color(0xffF2CB05);
        colorTextGunluk = Colors.white;
      } else if (index == 11) {
        resetColor();
        colorContainerHobi = const Color(0xffF2CB05);
        colorTextHobi = Colors.white;
      } else if (index == 12) {
        resetColor();
        colorContainerDiger = const Color(0xffF2CB05);
        colorTextDiger = Colors.white;
      }
    }

    var size = MediaQuery.of(context).size;
    if (selectedCategory == 0) {
      return SizedBox(
        width: size.width * 0.9,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerYemek,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(1);
                          _category.text = 'Yemek';
                        });
                      },
                      child: Text(translation(context).food,
                          style: TextStyle(
                            height: 1,
                              color: colorTextYemek,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerGiyim,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(2);
                          _category.text = 'Giyim';
                        });
                      },
                      child: Text(translation(context).clothing,
                          style: TextStyle(
                            height: 1,
                              color: colorTextGiyim,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerEglence,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(3);
                          _category.text = 'Eğlence';
                        });
                      },
                      child: Text(translation(context).entertainment,
                          style: TextStyle(
                            height: 1,
                              color: colorTextEglence,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerEgitim,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(4);
                          _category.text = 'Eğitim';
                        });
                      },
                      child: Text(translation(context).education,
                          style: TextStyle(
                            height: 1,
                              color: colorTextEgitim,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerAidat,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(5);
                          _category.text = 'Aidat/Kira';
                        });
                      },
                      child: Text(translation(context).duesRent,
                          style: TextStyle(
                            height: 1,
                              color: colorTextAidat,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerAlisveris,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(6);
                          _category.text = 'Alışveriş';
                        });
                      },
                      child: Text(translation(context).shopping,
                          style: TextStyle(
                            height: 1,
                              color: colorTextAlisveris,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerOzel,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(7);
                          _category.text = 'Özel-';
                        });
                      },
                      child: Text(translation(context).personel,
                          style: TextStyle(
                            height: 1,
                              color: colorTextOzel,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerUlasim,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(8);
                          _category.text = 'Ulaşım';
                        });
                      },
                      child: Text(translation(context).transport,
                          style: TextStyle(
                              color: colorTextUlasim,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerSaglik,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(9);
                          _category.text = 'Sağlık';
                        });
                      },
                      child: Text(translation(context).health,
                          style: TextStyle(
                            height: 1,
                              color: colorTextSaglik,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerGunluk,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(10);
                          _category.text = 'Günlük Yaşam';
                        });
                      },
                      child: Text(translation(context).dailyExpenses,
                          style: TextStyle(
                            height: 1,
                              color: colorTextGunluk,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerHobi,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(11);
                          _category.text = 'Hobi';
                        });
                      },
                      child: Text(translation(context).hobby,
                          style: TextStyle(
                            height: 1,
                              color: colorTextHobi,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerDiger,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(12);
                          _category.text = 'Diğer-';
                        });
                      },
                      child: Text(translation(context).other,
                          style: TextStyle(
                            height: 1,
                              color: colorTextDiger,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
              ],
            )
          ],
        ),
      );
    } else {
      return SizedBox(
        width: size.width * 0.9,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerYemek,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(1);
                          _category.text = 'Harçlık';
                        });
                      },
                      child: Text("Harçlık",
                          style: TextStyle(
                              color: colorTextYemek,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerGiyim,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(2);
                          _category.text = 'Burs';
                        });
                      },
                      child: Text("Burs",
                          style: TextStyle(
                              color: colorTextGiyim,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerEglence,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(3);
                          _category.text = 'Maaş';
                        });
                      },
                      child: Text("Maaş",
                          style: TextStyle(
                              color: colorTextEglence,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerEgitim,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(4);
                          _category.text = 'Kredi';
                        });
                      },
                      child: Text("Kredi",
                          style: TextStyle(
                              color: colorTextEgitim,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerAidat,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(5);
                          _category.text = 'Özel+';
                        });
                      },
                      child: Text("Özel",
                          style: TextStyle(
                              color: colorTextAidat,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerAlisveris,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(6);
                          _category.text = 'Kira/Ödenek';
                        });
                      },
                      child: Text("Kira/Ödenek",
                          style: TextStyle(
                              color: colorTextAlisveris,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerOzel,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(7);
                          _category.text = 'Fazla Mesai';
                        });
                      },
                      child: Text("Fazla Mesai",
                          style: TextStyle(
                              color: colorTextOzel,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerUlasim,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(8);
                          _category.text = 'İş Getirisi';
                        });
                      },
                      child: Text("İş Getirisi",
                          style: TextStyle(
                              color: colorTextUlasim,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerSaglik,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(9);
                          _category.text = 'Döviz Getirisi';
                        });
                      },
                      child: Text("Döviz Getirisi",
                          style: TextStyle(
                              color: colorTextSaglik,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerGunluk,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(10);
                          _category.text = 'Yatırım Getirisi';
                        });
                      },
                      child: Text("Yatırım Getirisi",
                          style: TextStyle(
                              color: colorTextGunluk,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerHobi,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(11);
                          _category.text = 'Diğer+';
                        });
                      },
                      child: Text("Diğer",
                          style: TextStyle(
                              color: colorTextHobi,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
              ],
            )
          ],
        ),
      );
    }
  }
 */
