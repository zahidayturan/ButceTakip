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
                  child: Padding(
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

class _ButtonMenu extends ConsumerState<ButtonMenu> {
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
  final TextEditingController _operationType =
      TextEditingController(text: "Gider");
  final TextEditingController _operationTool =
      TextEditingController(text: "Nakit");
  final TextEditingController _registration = TextEditingController(text: "0");
  final TextEditingController _operationDate =
      TextEditingController(text: DateTimeManager.getCurrentDayMonthYear());
  final TextEditingController _category = TextEditingController(text: "");
  final TextEditingController _categoryEdit = TextEditingController(text: "");
  final TextEditingController _categoryController = TextEditingController(text: "");
  final TextEditingController _customize = TextEditingController(text: "");
  final TextEditingController _moneyType = TextEditingController(text: "");


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
                width: size.width * 0.95,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                width: size.width * 0.95,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  width: size.width * 0.98,
                  child: Text(
                      'DEBUG: ${_operationType.text} - ${_category.text} - ${_operationTool.text} - ${int.parse(_registration.text)} - ${_amount.text} - ${_note.text} - ${_operationDate.text} -${_customize.text} - ${selectedCustomizeMenu} - ${_moneyType.text}',
                      style: const TextStyle(
                          color: Colors.red, fontFamily: 'TL'))),
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
          minWidth: size.width > 392 ? size.width * 0.235 : 92,
          cornerRadius: 15,
          radiusStyle: true,
          animate: true,
          curve: Curves.linearToEaseOut,
          customTextStyles: const [
            TextStyle(
                fontSize: 13,
                fontFamily: 'Nexa4',
                height: 1,
                fontWeight: FontWeight.w800)
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
              categoryColorChanger = 999;
            });
            initialLabelIndex = index!;
          },
        ));
  }

  String? selectedValue;
  int selectedAddCategoryMenu = 0;
  int initialLabelIndex2 = 0;
  int sortChanger = 0;
  int editChanger = 0;
  double heightChanger = 40.0;
  int categoryColorChanger = 999;
  int categoryDeleteChanger = 0;
  int categoryDeleteChanger2 = 0;
  int categoryEditChanger = 0;
  int categoryEditChanger2 = 0;
  Widget categoryBarCustom(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size;
    var readHome = ref.read(homeRiverpod);
    return SizedBox(
      height: 38,
      width: size.width * 0.95,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2, left: 2, right: 2),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Color(0xFFF2CB05),
              ),
              height: 34,
              width: (size.width * 0.95),
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
                    style: const TextStyle(
                      height: 1,
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Nexa4',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              InkWell(
                highlightColor: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(30),
                child: SizedBox(
                  width: (size.width * 0.95) - 130,
                  child: Center(
                    child: Text(
                      _category.text == ""
                          ? "Seçmek için dokunun"
                          : _category.text,
                      style: TextStyle(
                          height: 1,
                          fontSize: 14,
                          fontFamily: 'Nexa3',
                          color: renkler.koyuuRenk),
                      maxLines: 2,
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    editChanger = 0;
                    heightChanger = 40.0;
                    //_category.clear();
                    selectedValue = null;
                  });
                  showDialog(
                    context: context,
                    builder: (context) {
                      var readUpdateDB = ref.read(updateDataRiverpod);
                      return FutureBuilder<Map<String, List<String>>>(
                        future: readUpdateDB.myCategoryLists(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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
                                categoryLists['income'] ??
                                    ['Kategori bulunamadı'];
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
                                categoryLists['expense'] ??
                                    ['Kategori bulunamadı'];

                            Set<String> mergedSetIncome = {
                              ...oldCategoryListIncome,
                              ...categoryListIncome
                            };
                            List<String> mergedIncomeList =
                            mergedSetIncome.toList();
                            Set<String> mergedSetExpens = {
                              ...oldCategoryListExpense,
                              ...categoryListExpense
                            };
                            List<String> mergedExpensList = mergedSetExpens.toList();
                            List<String> mergedSortExpenseList = List.from(mergedExpensList);
                            mergedSortExpenseList.sort();
                            List<String> mergedSortReverseExpenseList = List.from(mergedSortExpenseList);
                            mergedSortReverseExpenseList = mergedSortReverseExpenseList.reversed.toList();
                            List<String> mergedSortIncomeList = List.from(mergedIncomeList);
                            mergedSortIncomeList.sort();
                            List<String> mergedSortReverseIncomeList = List.from(mergedSortIncomeList);
                            mergedSortReverseIncomeList = mergedSortReverseIncomeList.reversed.toList();

                            List<String> getList(int type, int sortChanger){
                              if(type==0){
                                if(sortChanger == 0){
                                  return mergedExpensList;
                                }
                                else if(sortChanger == 1){
                                  return mergedSortExpenseList;
                                }
                                else if(sortChanger == 2){
                                  return mergedSortReverseExpenseList;
                                }
                                else {
                                  return mergedExpensList;
                                }
                              }
                              else{
                                if(sortChanger == 0){
                                  return mergedIncomeList;
                                }
                                else if(sortChanger == 1){
                                  return mergedSortIncomeList;
                                }
                                else if(sortChanger == 2){
                                  return mergedSortReverseIncomeList;
                                }
                                else {
                                  return mergedIncomeList;
                                }
                              }
                            }
                            return StatefulBuilder(
                              builder: (context, setState) {
                                return AlertDialog(
                                  contentPadding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  insetPadding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  backgroundColor:
                                  Theme.of(context).primaryColor,
                                  shadowColor: Colors.black54,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Visibility(
                                        visible : editChanger == 0 ,
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(15),
                                              child: Container(
                                                width: size.width * 0.95,
                                                height: (size.height * 0.3) + 20,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5)),
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
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 18, right: 18),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                      children: [
                                                        SizedBox(
                                                          width: 30,
                                                          height: 30,
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                color: renkler
                                                                    .sariRenk,
                                                                borderRadius: const BorderRadius
                                                                    .all(Radius
                                                                    .circular(
                                                                    5))),
                                                            child: IconButton(
                                                              icon: Icon(Icons
                                                                  .refresh_rounded),
                                                              padding:
                                                              EdgeInsets.zero,
                                                              alignment: Alignment
                                                                  .center,
                                                              color: renkler
                                                                  .koyuuRenk,
                                                              iconSize: 30,
                                                              onPressed: () {
                                                                setState(() {
                                                                  sortChanger = 0;
                                                                  categoryColorChanger = 999;
                                                                  _category.clear();
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: size.width * 0.6,
                                                          height: 30,
                                                          decoration: BoxDecoration(
                                                              color: Theme.of(
                                                                  context)
                                                                  .highlightColor,
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  10)),
                                                          child: editChanger == 0
                                                              ? Center(
                                                            child:
                                                            FittedBox(
                                                              child: Text(
                                                                selectedCategory ==
                                                                    0
                                                                    ? "Gider Kategorileri"
                                                                    : "Gelir Kategorileri",
                                                                style: TextStyle(
                                                                    color: renkler
                                                                        .arkaRenk,
                                                                    fontSize:
                                                                    15),
                                                                //overflow: TextOverflow.visible,
                                                              ),
                                                            ),
                                                          )
                                                              : Center(
                                                            child: SizedBox(
                                                              height: 30,
                                                              child:
                                                              TextField(
                                                                onTap: () {
                                                                  setState((){
                                                                    if (categoryColorChanger != 999) {
                                                                      categoryColorChanger = 999;
                                                                      _category.clear();
                                                                    }
                                                                  });
                                                                },
                                                                enabled:
                                                                true,
                                                                maxLength:
                                                                20,
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                    color: renkler
                                                                        .arkaRenk,
                                                                    fontSize:
                                                                    15,
                                                                    height:
                                                                    1,
                                                                    fontFamily:
                                                                    'Nexa3'),
                                                                decoration: InputDecoration(
                                                                    isDense:
                                                                    true,
                                                                    hintText: selectedCategory == 0
                                                                        ? "Gider kategorisi ekleyin"
                                                                        : "Gelir kategorisi ekleyin",
                                                                    hintStyle: TextStyle(
                                                                        color: renkler
                                                                            .arkaRenk,
                                                                        height:
                                                                        1,
                                                                        fontSize:
                                                                        15,
                                                                        fontFamily:
                                                                        'Nexa3'),
                                                                    counterText:
                                                                    '',
                                                                    border:
                                                                    InputBorder.none),
                                                                cursorRadius:
                                                                const Radius.circular(
                                                                    10),
                                                                keyboardType:
                                                                TextInputType
                                                                    .text,
                                                                textCapitalization:
                                                                TextCapitalization
                                                                    .words,
                                                                textAlign:
                                                                TextAlign
                                                                    .center,
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
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 30,
                                                          height: 30,
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                color: sortChanger == 0 ? Theme.of(context).highlightColor : renkler.sariRenk,
                                                                borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(5))),
                                                            child:
                                                            Padding(
                                                              padding: EdgeInsets.all(3),
                                                              child: GestureDetector(
                                                                onTap: () {
                                                                  setState(
                                                                          () {
                                                                        sortChanger == 1 ? sortChanger = 2 : sortChanger = 1;
                                                                        categoryColorChanger = 999;
                                                                        _category.clear();
                                                                      });
                                                                },
                                                                child: Image.asset(
                                                                  sortChanger == 1 ? "assets/icons/sort1.png" : sortChanger == 2 ? "assets/icons/sort2.png" : "assets/icons/sort1.png",
                                                                  color: sortChanger == 0 ? renkler.arkaRenk : renkler.koyuuRenk,
                                                                  fit: BoxFit.contain,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.all(
                                                        8.0),
                                                    child: SizedBox(
                                                      width: size.width * 0.81,
                                                      height:
                                                      size.height * 0.3 -
                                                          30,
                                                      child: GridView.builder(
                                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                              crossAxisCount: 3,
                                                              mainAxisExtent:
                                                              heightChanger,
                                                              //childAspectRatio:1/2,
                                                              crossAxisSpacing:
                                                              2,
                                                              mainAxisSpacing:
                                                              2),
                                                          itemCount: getList(selectedCategory, sortChanger).length,
                                                          itemBuilder:
                                                              (BuildContext
                                                          context,
                                                              index) {
                                                            return InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  _category
                                                                      .text = getList(selectedCategory, sortChanger)[
                                                                  index]
                                                                      .toString();
                                                                  categoryColorChanger =
                                                                      index;
                                                                });
                                                              },
                                                              child: Container(
                                                                alignment:
                                                                Alignment
                                                                    .center,
                                                                //height: 50,
                                                                decoration:
                                                                BoxDecoration(
                                                                  //border: Border.all(color: renkler.koyuuRenk,width: 1),
                                                                  color: editChanger == 0 ? categoryColorChanger ==
                                                                      index
                                                                      ? renkler
                                                                      .sariRenk
                                                                      : null : renkler
                                                                      .koyuAraRenk.withOpacity(0.1)
                                                                  ,
                                                                  borderRadius:
                                                                  BorderRadius.circular(5),
                                                                ),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                                  children: [
                                                                    Center(
                                                                      child:
                                                                      Text(
                                                                        getList(selectedCategory, sortChanger)[index],
                                                                        style:
                                                                        const TextStyle(
                                                                          fontSize:
                                                                          14,
                                                                          height:
                                                                          1,
                                                                        ),
                                                                        maxLines:
                                                                        2,
                                                                        overflow:
                                                                        TextOverflow.ellipsis,
                                                                        textAlign:
                                                                        TextAlign.center,
                                                                      ),
                                                                    ),
                                                                    Visibility(
                                                                      visible:
                                                                      editChanger !=
                                                                          0,
                                                                      child: (selectedCategory == 0 ? oldCategoryListExpense.contains(getList(selectedCategory, sortChanger)[index].toString()) == false : oldCategoryListIncome.contains(getList(selectedCategory, sortChanger).toString()) == false) ?
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment.spaceAround,
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                            20,
                                                                            height:
                                                                            20,
                                                                            decoration:
                                                                            BoxDecoration(color: renkler.kirmiziRenk, borderRadius: BorderRadius.all(Radius.circular(5))),
                                                                            child:
                                                                            IconButton(
                                                                              onPressed: () {
                                                                                setState((){
                                                                                  categoryDeleteChanger=0;
                                                                                });
                                                                              },
                                                                              icon: Icon(
                                                                                Icons.delete_forever_rounded,
                                                                                size: 16,
                                                                                color: renkler.arkaRenk,
                                                                              ),
                                                                              padding: EdgeInsets.zero,
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            width:
                                                                            20,
                                                                            height:
                                                                            20,
                                                                            decoration:
                                                                            BoxDecoration(color: Theme.of(context).highlightColor, borderRadius: BorderRadius.all(Radius.circular(5))),
                                                                            child:
                                                                            IconButton(
                                                                              onPressed: () {
                                                                                setState((){
                                                                                  categoryEditChanger=0;
                                                                                  categoryEditChanger2=0;
                                                                                });
                                                                              },
                                                                              icon: Icon(
                                                                                Icons.edit_rounded,
                                                                                size: 18,
                                                                                color: renkler.arkaRenk,
                                                                              ),
                                                                              padding: EdgeInsets.zero,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ) : FittedBox(
                                                                        child: Text("Sistem\nKategorisi",textAlign: TextAlign.center,style: TextStyle(
                                                                            fontSize: 12,height: 1
                                                                        ),),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          }),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                    children: [
                                                      SizedBox(
                                                        width: size.width * 0.45,
                                                        height: 30,
                                                        child: TextButton(
                                                          style: ButtonStyle(
                                                              backgroundColor: editChanger ==
                                                                  0
                                                                  ? MaterialStatePropertyAll(
                                                                  Theme.of(
                                                                      context)
                                                                      .highlightColor)
                                                                  : MaterialStatePropertyAll(
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
                                                            setState(() {
                                                              categoryColorChanger = 999;
                                                              _category.clear();
                                                              editChanger == 0
                                                                  ? editChanger =
                                                              1
                                                                  : editChanger =
                                                              0;
                                                              heightChanger ==
                                                                  40.0
                                                                  ? heightChanger =
                                                              60.0
                                                                  : heightChanger =
                                                              40.0;
                                                            });
                                                          },
                                                          child: FittedBox(
                                                            child: Text(
                                                              "Kategori Ekle / Sil",
                                                              style: TextStyle(
                                                                color: editChanger ==
                                                                    0
                                                                    ? renkler
                                                                    .arkaRenk
                                                                    : renkler
                                                                    .koyuuRenk,
                                                                fontSize: 14,
                                                                height: 1,
                                                                fontFamily:
                                                                'Nexa3',
                                                              ),
                                                              overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: size.width * 0.22,
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
                                                                        5),
                                                                  ))),
                                                          onPressed: () {
                                                            Navigator.of(context)
                                                                .pop();
                                                            readHome.setStatus();
                                                          },
                                                          child: Text(
                                                            translation(context)
                                                                .ok,
                                                            style: TextStyle(
                                                              color: renkler
                                                                  .koyuuRenk,
                                                              fontSize: 14,
                                                              height: 1,
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
                                      ),
                                      Visibility(
                                        visible : editChanger == 1,
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(15),
                                              child: Container(
                                                width: size.width * 0.95,
                                                height: (size.height * 0.3) + 20,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5)),
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
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 18, right: 18),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                      children: [
                                                        Container(
                                                          width: size.width * 0.7,
                                                          height: 30,
                                                          decoration: BoxDecoration(
                                                              color: renkler.sariRenk,
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  10)),
                                                          child: Center(
                                                            child: SizedBox(
                                                              height: 30,
                                                              child:
                                                              TextField(
                                                                onTap: () {
                                                                  setState((){
                                                                    if (categoryColorChanger != 999) {
                                                                      categoryColorChanger = 999;
                                                                      _category.clear();
                                                                    }
                                                                  });
                                                                },
                                                                enabled:
                                                                true,
                                                                maxLength:
                                                                20,
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                    color: renkler
                                                                        .koyuuRenk,
                                                                    fontSize:
                                                                    15,
                                                                    height:
                                                                    1,
                                                                    fontFamily:
                                                                    'Nexa3'),
                                                                decoration: InputDecoration(
                                                                    isDense:
                                                                    true,
                                                                    hintText: selectedCategory == 0
                                                                        ? "Gider kategorisi ekleyin"
                                                                        : "Gelir kategorisi ekleyin",
                                                                    hintStyle: TextStyle(
                                                                        color: renkler
                                                                            .koyuuRenk,
                                                                        height:
                                                                        1,
                                                                        fontSize:
                                                                        15,
                                                                        fontFamily:
                                                                        'Nexa3'),
                                                                    counterText:
                                                                    '',
                                                                    border:
                                                                    InputBorder.none),
                                                                cursorRadius:
                                                                const Radius.circular(
                                                                    10),
                                                                keyboardType:
                                                                TextInputType
                                                                    .text,
                                                                textCapitalization:
                                                                TextCapitalization
                                                                    .words,
                                                                textAlign:
                                                                TextAlign
                                                                    .center,
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
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 30,
                                                          height: 30,
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                color: renkler
                                                                    .sariRenk,
                                                                borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(5))),
                                                            child:
                                                            IconButton(
                                                              icon: Icon(Icons
                                                                  .add_rounded),
                                                              padding:
                                                              EdgeInsets
                                                                  .zero,
                                                              alignment:
                                                              Alignment
                                                                  .center,
                                                              color: renkler
                                                                  .koyuuRenk,
                                                              iconSize: 30,
                                                              onPressed:
                                                                  () {
                                                                if (_category
                                                                    .text ==
                                                                    '') {
                                                                  showDialog(
                                                                      context:
                                                                      context,
                                                                      builder:
                                                                          (context) {
                                                                        return AlertDialog(
                                                                          backgroundColor: Theme.of(context).primaryColor,
                                                                          title: Text("Eksik İşlem Yaptınız", style: TextStyle(color: Theme.of(context).secondaryHeaderColor, fontSize: 22, fontFamily: 'Nexa3')),
                                                                          content: Text(
                                                                            "Lütfen bir kategori giriniz!",
                                                                            style: TextStyle(color: Theme.of(context).canvasColor, fontSize: 16, fontFamily: 'Nexa3'),
                                                                          ),
                                                                          shadowColor: renkler.koyuuRenk,
                                                                          actions: [
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                              child: Text(
                                                                                translation(context).ok,
                                                                                style: TextStyle(color: Theme.of(context).secondaryHeaderColor, fontSize: 18, height: 1, fontFamily: 'Nexa3'),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        );
                                                                      });
                                                                } else {
                                                                  Navigator.of(
                                                                      context)
                                                                      .pop();
                                                                }

                                                                setState(
                                                                        () {});
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Visibility(
                                                    visible:
                                                    selectedAddCategoryMenu ==
                                                        0,
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets.all(
                                                          8.0),
                                                      child: SizedBox(
                                                        width: size.width * 0.81,
                                                        height:
                                                        size.height * 0.3 -
                                                            30,
                                                        child: GridView.builder(
                                                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                crossAxisCount: 3,
                                                                mainAxisExtent:
                                                                heightChanger,
                                                                //childAspectRatio:1/2,
                                                                crossAxisSpacing:
                                                                2,
                                                                mainAxisSpacing:
                                                                2),
                                                            itemCount:getList(selectedCategory, sortChanger).length,
                                                            itemBuilder:
                                                                (BuildContext
                                                            context,
                                                                index) {
                                                              return InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    _category
                                                                        .text = getList(selectedCategory, sortChanger)[
                                                                    index]
                                                                        .toString();

                                                                    categoryColorChanger =
                                                                        index;
                                                                  });
                                                                },
                                                                child: Container(
                                                                  alignment:
                                                                  Alignment
                                                                      .center,
                                                                  //height: 50,
                                                                  decoration:
                                                                  BoxDecoration(
                                                                    //border: Border.all(color: renkler.koyuuRenk,width: 1),
                                                                    color: editChanger == 0 ? categoryColorChanger ==
                                                                        index
                                                                        ? renkler
                                                                        .sariRenk
                                                                        : null : Theme.of(context).splashColor.withOpacity(0.5)
                                                                    ,
                                                                    borderRadius:
                                                                    BorderRadius.circular(5),
                                                                  ),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                    children: [
                                                                      Center(
                                                                        child:
                                                                        Text(
                                                                          getList(selectedCategory, sortChanger)[index]
                                                                          ,
                                                                          style:
                                                                          const TextStyle(
                                                                            fontSize:
                                                                            14,
                                                                            height:
                                                                            1,
                                                                          ),
                                                                          maxLines:
                                                                          2,
                                                                          overflow:
                                                                          TextOverflow.ellipsis,
                                                                          textAlign:
                                                                          TextAlign.center,
                                                                        ),
                                                                      ),
                                                                      (selectedCategory == 0 ? oldCategoryListExpense.contains(getList(selectedCategory, sortChanger)[index].toString()) == false : oldCategoryListIncome.contains(getList(selectedCategory, sortChanger)[index].toString()) == false) ?
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment.spaceAround,
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                            20,
                                                                            height:
                                                                            20,
                                                                            decoration:
                                                                            BoxDecoration(color: renkler.kirmiziRenk, borderRadius: BorderRadius.all(Radius.circular(5))),
                                                                            child:
                                                                            IconButton(
                                                                              onPressed: () {
                                                                                setState((){
                                                                                  _categoryController.text = getList(selectedCategory, sortChanger)[index];
                                                                                  editChanger = 2;
                                                                                  categoryDeleteChanger=0;
                                                                                });
                                                                              },
                                                                              icon: Icon(
                                                                                Icons.delete_forever_rounded,
                                                                                size: 16,
                                                                                color: renkler.arkaRenk,
                                                                              ),
                                                                              padding: EdgeInsets.zero,
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            width:
                                                                            20,
                                                                            height:
                                                                            20,
                                                                            decoration:
                                                                            BoxDecoration(color: Theme.of(context).secondaryHeaderColor, borderRadius: BorderRadius.all(Radius.circular(5))),
                                                                            child:
                                                                            IconButton(
                                                                              onPressed: () {
                                                                                setState((){
                                                                                  _categoryController.text = getList(selectedCategory, sortChanger)[index];
                                                                                  editChanger = 3;
                                                                                  categoryEditChanger=0;
                                                                                  categoryEditChanger2=0;
                                                                                });
                                                                              },
                                                                              icon: Icon(
                                                                                Icons.edit_rounded,
                                                                                size: 18,
                                                                                color: Theme.of(context).primaryColor,
                                                                              ),
                                                                              padding: EdgeInsets.zero,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ) : const FittedBox(
                                                                        child: Text("Sistem\nKategorisi",textAlign: TextAlign.center,style: TextStyle(
                                                                            fontSize: 11,height: 1
                                                                        ),),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            }),
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                    children: [
                                                      SizedBox(
                                                        width: size.width * 0.45,
                                                        height: 30,
                                                        child: TextButton(
                                                          style: ButtonStyle(
                                                              backgroundColor: editChanger ==
                                                                  0
                                                                  ? MaterialStatePropertyAll(
                                                                  Theme.of(
                                                                      context)
                                                                      .highlightColor)
                                                                  : MaterialStatePropertyAll(
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
                                                            setState(() {
                                                              editChanger == 0
                                                                  ? editChanger =
                                                              1
                                                                  : editChanger =
                                                              0;
                                                              heightChanger ==
                                                                  40.0
                                                                  ? heightChanger =
                                                              60.0
                                                                  : heightChanger =
                                                              40.0;
                                                            });
                                                          },
                                                          child: FittedBox(
                                                            child: Text(
                                                              "Kategori Ekle / Sil",
                                                              style: TextStyle(
                                                                color: editChanger ==
                                                                    0
                                                                    ? renkler
                                                                    .arkaRenk
                                                                    : renkler
                                                                    .koyuuRenk,
                                                                fontSize: 14,
                                                                height: 1,
                                                                fontFamily:
                                                                'Nexa3',
                                                              ),
                                                              overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: size.width * 0.22,
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
                                                                        5),
                                                                  ))),
                                                          onPressed: () {
                                                            Navigator.of(context)
                                                                .pop();
                                                          },
                                                          child: Text(
                                                            translation(context)
                                                                .ok,
                                                            style: TextStyle(
                                                              color: renkler
                                                                  .koyuuRenk,
                                                              fontSize: 14,
                                                              height: 1,
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
                                      ),
                                      Visibility(
                                        visible : editChanger == 3,
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(15),
                                              child: Container(
                                                width: size.width * 0.95,
                                                height: (size.height * 0.3) + 20,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5)),
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
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 18, right: 18),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                      children: [
                                                        SizedBox(
                                                          width: 30,
                                                          height: 30,
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                color: renkler
                                                                    .sariRenk,
                                                                borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(5))),
                                                            child:
                                                            IconButton(
                                                              icon: Icon(Icons
                                                                  .arrow_back_ios_new_rounded),
                                                              padding:
                                                              EdgeInsets
                                                                  .zero,
                                                              alignment:
                                                              Alignment
                                                                  .center,
                                                              color: renkler
                                                                  .koyuuRenk,
                                                              iconSize: 30,
                                                              onPressed:
                                                                  () {
                                                                setState(
                                                                        () {
                                                                      editChanger = 1;
                                                                    });
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: size.width * 0.7,
                                                          height: 30,
                                                          decoration: BoxDecoration(
                                                              color: Theme.of(
                                                                  context)
                                                                  .highlightColor,
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  10)),
                                                          child: SizedBox(
                                                              height: 30,
                                                              child:
                                                              Center(
                                                                child: Text(
                                                                  "Kategori Düzenleme",style: TextStyle(color: renkler.arkaRenk),
                                                                ),
                                                              )
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  FutureBuilder<int>(
                                                    future: readUpdateDB.categoryUsageCount(selectedCategory, _categoryController.text,0,''),
                                                    builder: (context, snapshot) {
                                                      if (snapshot.connectionState ==
                                                          ConnectionState.waiting) {
                                                        return const CircularProgressIndicator();
                                                      } else if (snapshot.hasError) {
                                                        return Text('Bir hata oluştu: ${snapshot.error}');
                                                      } else {
                                                            return Column(
                                                              children: <Widget>[
                                                                Center(
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.only(top: 10,bottom: 10),
                                                                    child: SizedBox(
                                                                        width: size.width * 0.81,
                                                                        height:210,
                                                                        child: Column(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(top: 10),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Text("Kategori:"),
                                                                                  Text(_categoryController.text),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(top: 10),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Text("Kayıtlı İşlem Sayısı:"),
                                                                                  Text("${snapshot.data}"),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Spacer(),
                                                                            Visibility(
                                                                              visible : categoryEditChanger == 1,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(top: 6),
                                                                                child: SizedBox(
                                                                                  width: size.width * 0.81,
                                                                                  height: 120,
                                                                                  child: Container(
                                                                                    decoration: BoxDecoration(
                                                                                        border: Border.all(
                                                                                            color: Theme.of(context).highlightColor,
                                                                                            width: 1
                                                                                        ),
                                                                                        borderRadius: BorderRadius.all(Radius.circular(5))
                                                                                    ),
                                                                                    child: Column(
                                                                                      mainAxisAlignment:
                                                                                      MainAxisAlignment
                                                                                          .spaceAround,
                                                                                      children: [
                                                                                        Row(
                                                                                          mainAxisAlignment:
                                                                                          MainAxisAlignment
                                                                                              .spaceAround,
                                                                                          children: [
                                                                                            SizedBox(
                                                                                              width: 26,
                                                                                              height: 26,
                                                                                              child: Container(
                                                                                                decoration: BoxDecoration(
                                                                                                    color: Theme.of(context).highlightColor,
                                                                                                    borderRadius:
                                                                                                    BorderRadius.all(
                                                                                                        Radius.circular(5))),
                                                                                                child:
                                                                                                IconButton(
                                                                                                  icon: Icon(Icons
                                                                                                      .arrow_back_ios_new_rounded),
                                                                                                  padding:
                                                                                                  EdgeInsets
                                                                                                      .zero,
                                                                                                  alignment:
                                                                                                  Alignment
                                                                                                      .center,
                                                                                                  color: renkler
                                                                                                      .arkaRenk,
                                                                                                  iconSize: 24,
                                                                                                  onPressed:
                                                                                                      () {
                                                                                                    setState(
                                                                                                            () {
                                                                                                          categoryEditChanger = 0;
                                                                                                        });
                                                                                                  },
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Container(
                                                                                              width: size.width * 0.65,
                                                                                              height: 26,
                                                                                              decoration: BoxDecoration(
                                                                                                  color: renkler.sariRenk,
                                                                                                  borderRadius:
                                                                                                  BorderRadius
                                                                                                      .circular(
                                                                                                      5)),
                                                                                              child: SizedBox(
                                                                                                  height: 26,
                                                                                                  child:
                                                                                                  Center(
                                                                                                    child: Text(
                                                                                                      categoryEditChanger2 == 3 ? "Sakla ve düzenle": categoryEditChanger2 == 4 ? "Değiştir ve düzenle" : "Düzenle",style: TextStyle(color: renkler.koyuuRenk),
                                                                                                    ),
                                                                                                  )
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.only(left: 4,right: 4),
                                                                                          child: Column(
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              Text('Değiştirmek istediğiniz kategoriyi yazınız',style: TextStyle(fontSize: 14,height: 1,color: Theme.of(context).canvasColor,),),
                                                                                              SizedBox(
                                                                                                width : size.width*0.32,
                                                                                                height: 24,
                                                                                                child: TextField(
                                                                                                  maxLength: 20,
                                                                                                  maxLines: 1,
                                                                                                  style:
                                                                                                  TextStyle(color: Theme.of(context).canvasColor,fontSize: 13,fontFamily: 'Nexa3'),
                                                                                                  decoration: InputDecoration(
                                                                                                      hintText: 'Kategoriyi yazınız',
                                                                                                      hintStyle: TextStyle(
                                                                                                          color: Theme.of(context).canvasColor,
                                                                                                          fontSize: 13,
                                                                                                          fontFamily: 'Nexa3'),
                                                                                                      counterText: '',
                                                                                                      border: InputBorder.none),
                                                                                                  cursorRadius: const Radius.circular(10),
                                                                                                  keyboardType: TextInputType.text,
                                                                                                  textCapitalization: TextCapitalization.words,
                                                                                                  controller: _categoryEdit,
                                                                                                  onEditingComplete: () {
                                                                                                    setState((){});
                                                                                                  },

                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height : 26,
                                                                                          child: TextButton(
                                                                                            onPressed: () {
                                                                                              if (_categoryEdit
                                                                                                  .text ==
                                                                                                  '') {
                                                                                                showDialog(
                                                                                                    context:
                                                                                                    context,
                                                                                                    builder:
                                                                                                        (context) {
                                                                                                      return AlertDialog(
                                                                                                        backgroundColor: Theme.of(context).primaryColor,
                                                                                                        title: Text("Eksik İşlem Yaptınız", style: TextStyle(color: Theme.of(context).secondaryHeaderColor, fontSize: 22, fontFamily: 'Nexa3')),
                                                                                                        content: Text(
                                                                                                          "Lütfen bir kategori giriniz!",
                                                                                                          style: TextStyle(color: Theme.of(context).canvasColor, fontSize: 16, fontFamily: 'Nexa3'),
                                                                                                        ),
                                                                                                        shadowColor: renkler.koyuuRenk,
                                                                                                        actions: [
                                                                                                          TextButton(
                                                                                                            onPressed: () {
                                                                                                              Navigator.of(context).pop();
                                                                                                            },
                                                                                                            child: Text(
                                                                                                              translation(context).ok,
                                                                                                              style: TextStyle(color: Theme.of(context).secondaryHeaderColor, fontSize: 18, height: 1, fontFamily: 'Nexa3'),
                                                                                                            ),
                                                                                                          )
                                                                                                        ],
                                                                                                      );
                                                                                                    });
                                                                                              } else {
                                                                                                readUpdateDB.categoryUsageCount(selectedCategory, _categoryController.text,categoryEditChanger2,_categoryEdit.text);
                                                                                                setState(
                                                                                                        () {
                                                                                                      _categoryEdit.clear();
                                                                                                      editChanger = 1;
                                                                                                    });
                                                                                                Navigator.of(context).pop();
                                                                                                readHome.setStatus();
                                                                                              }
                                                                                            },
                                                                                            style: ButtonStyle(
                                                                                                backgroundColor: MaterialStatePropertyAll(renkler.sariRenk),
                                                                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                                                    const RoundedRectangleBorder(
                                                                                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                                                                                    )
                                                                                                ),
                                                                                                padding: const MaterialStatePropertyAll(EdgeInsets.only(left: 4,right: 4),)
                                                                                            ),
                                                                                            child: Text(
                                                                                              _categoryEdit.text != '' ? "${_categoryEdit.text} ile değiştir" : "Tamam",
                                                                                              style: TextStyle(
                                                                                                color: renkler
                                                                                                    .koyuuRenk,
                                                                                                fontSize: 13,
                                                                                                height: 1,
                                                                                                fontFamily: 'Nexa3',
                                                                                              ),
                                                                                              textAlign: TextAlign.center,
                                                                                              maxLines: 4,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Visibility(
                                                                              visible : categoryEditChanger == 0,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(top: 6),
                                                                                child: SizedBox(
                                                                                  width: size.width * 0.81,
                                                                                  height: 60,
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
                                                                                                  5),
                                                                                            ))),
                                                                                    onPressed: () {
                                                                                      setState((){
                                                                                        selectedValue = null;
                                                                                        _categoryEdit.clear();
                                                                                        categoryEditChanger = 1;
                                                                                        categoryEditChanger2 = 3;
                                                                                      });
                                                                                    },
                                                                                    child: Text(
                                                                                      "Düzenle ve eski kayıtlarda yer alan kategorileri sakla. (Önerilen)",
                                                                                      style: TextStyle(
                                                                                        color: renkler
                                                                                            .koyuuRenk,
                                                                                        fontSize: 14,
                                                                                        height: 1,
                                                                                        fontFamily: 'Nexa3',
                                                                                      ),
                                                                                      textAlign: TextAlign.center,
                                                                                      maxLines: 4,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Visibility(
                                                                              visible : categoryEditChanger == 0,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(top: 6),
                                                                                child: SizedBox(
                                                                                  width: size.width * 0.81,
                                                                                  height: 60,
                                                                                  child: TextButton(
                                                                                    style: ButtonStyle(
                                                                                        backgroundColor:
                                                                                        MaterialStatePropertyAll(
                                                                                            Theme.of(context).highlightColor),
                                                                                        shape: MaterialStateProperty.all<
                                                                                            RoundedRectangleBorder>(
                                                                                            RoundedRectangleBorder(
                                                                                              borderRadius:
                                                                                              BorderRadius
                                                                                                  .circular(
                                                                                                  5),
                                                                                            ))),
                                                                                    onPressed: () {
                                                                                      setState((){
                                                                                        selectedValue = null;
                                                                                        _categoryEdit.clear();
                                                                                        categoryEditChanger = 1;
                                                                                        categoryEditChanger2 = 4;
                                                                                      });
                                                                                    },
                                                                                    child: Text(
                                                                                      "Düzenle ve eski kayıtlarda yer alan kategorileri de düzenlenmiş kategori ile değiştir.",
                                                                                      style: TextStyle(
                                                                                        color: renkler
                                                                                            .arkaRenk,
                                                                                        fontSize: 14,
                                                                                        height: 1,
                                                                                        fontFamily: 'Nexa3',
                                                                                      ),
                                                                                      textAlign: TextAlign.center,
                                                                                      maxLines: 4,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        )),
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                      }
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                        visible : editChanger == 2,
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(15),
                                              child: Container(
                                                width: size.width * 0.95,
                                                height: (size.height * 0.3) + 20,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5)),
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
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 18, right: 18),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                      children: [
                                                        SizedBox(
                                                          width: 30,
                                                          height: 30,
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                color: renkler
                                                                    .sariRenk,
                                                                borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(5))),
                                                            child:
                                                            IconButton(
                                                              icon: Icon(Icons
                                                                  .arrow_back_ios_new_rounded),
                                                              padding:
                                                              EdgeInsets
                                                                  .zero,
                                                              alignment:
                                                              Alignment
                                                                  .center,
                                                              color: renkler
                                                                  .koyuuRenk,
                                                              iconSize: 30,
                                                              onPressed:
                                                                  () {
                                                                setState(
                                                                        () {
                                                                      editChanger = 1;
                                                                    });
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: size.width * 0.7,
                                                          height: 30,
                                                          decoration: BoxDecoration(
                                                              color: Theme.of(
                                                                  context)
                                                                  .highlightColor,
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  10)),
                                                          child: SizedBox(
                                                              height: 30,
                                                              child:
                                                              Center(
                                                                child: Text(
                                                                  "Kategori Silme",style: TextStyle(color: renkler.arkaRenk),
                                                                ),
                                                              )
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  FutureBuilder<int>(
                                                      future: readUpdateDB.categoryUsageCount(selectedCategory, _categoryController.text,0,''),
                                                      builder: (context, snapshot) {
                                                        if (snapshot.connectionState ==
                                                            ConnectionState.waiting) {
                                                          return const CircularProgressIndicator();
                                                        } else if (snapshot.hasError) {
                                                          return Text('Bir hata oluştu: ${snapshot.error}');
                                                        } else {
                                                          return Column(
                                                            children: <Widget>[
                                                              Center(
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(top: 10,bottom: 10),
                                                                  child: SizedBox(
                                                                      width: size.width * 0.81,
                                                                      height:210,
                                                                      child: Column(
                                                                        children: [
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(top: 10),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Text("Kategori:"),
                                                                                Text(_categoryController.text),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(top: 10),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Text("Kayıtlı İşlem Sayısı:"),
                                                                                Text("${snapshot.data}"),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Spacer(),
                                                                          Visibility(
                                                                            visible : categoryDeleteChanger == 0,
                                                                            child: Padding(
                                                                              padding: const EdgeInsets.only(top: 6),
                                                                              child: SizedBox(
                                                                                width: size.width * 0.81,
                                                                                height: 60,
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
                                                                                                5),
                                                                                          ))),
                                                                                  onPressed: () {
                                                                                    setState((){
                                                                                      selectedValue = null;
                                                                                      _categoryEdit.clear();
                                                                                      categoryDeleteChanger =1;
                                                                                      categoryDeleteChanger2 = 0;});
                                                                                  },
                                                                                  child: Text(
                                                                                    'Sil ve eski kayıtlarda yer alan kategorileri sakla. (Önerilen)',
                                                                                    style: TextStyle(
                                                                                      color: renkler
                                                                                          .koyuuRenk,
                                                                                      fontSize: 14,
                                                                                      height: 1,
                                                                                      fontFamily: 'Nexa3',
                                                                                    ),
                                                                                    textAlign: TextAlign.center,
                                                                                    maxLines: 4,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Visibility(
                                                                            visible : categoryDeleteChanger == 0,
                                                                            child: Padding(
                                                                              padding: const EdgeInsets.only(top: 6),
                                                                              child: SizedBox(
                                                                                width: size.width * 0.81,
                                                                                height: 60,
                                                                                child: TextButton(
                                                                                  style: ButtonStyle(
                                                                                      backgroundColor:
                                                                                      MaterialStatePropertyAll(
                                                                                          Theme.of(context).highlightColor),
                                                                                      shape: MaterialStateProperty.all<
                                                                                          RoundedRectangleBorder>(
                                                                                          RoundedRectangleBorder(
                                                                                            borderRadius:
                                                                                            BorderRadius
                                                                                                .circular(
                                                                                                5),
                                                                                          ))),
                                                                                  onPressed: () {
                                                                                    setState((){
                                                                                      selectedValue = null;
                                                                                      _categoryEdit.clear();
                                                                                      categoryDeleteChanger = 1 ;
                                                                                      categoryDeleteChanger2 = 1 ;
                                                                                    });
                                                                                  },
                                                                                  child: Text(
                                                                                    "Sil ve eski kayıtlarda yer alan kategorileri başka bir kategori ile değiştir.",
                                                                                    style: TextStyle(
                                                                                      color: renkler
                                                                                          .arkaRenk,
                                                                                      fontSize: 14,
                                                                                      height: 1,
                                                                                      fontFamily: 'Nexa3',
                                                                                    ),
                                                                                    textAlign: TextAlign.center,
                                                                                    maxLines: 4,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Visibility(
                                                                            visible : categoryDeleteChanger == 1,
                                                                            child: Column(
                                                                              children: [
                                                                                Visibility(
                                                                                  visible : categoryDeleteChanger2 == 0,
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.only(top: 6),
                                                                                    child: SizedBox(
                                                                                      width: size.width * 0.81,
                                                                                      height: 120,
                                                                                      child: Container(
                                                                                        decoration: BoxDecoration(
                                                                                            border: Border.all(
                                                                                                color: Theme.of(context).highlightColor,
                                                                                                width: 1
                                                                                            ),
                                                                                            borderRadius: BorderRadius.all(Radius.circular(5))
                                                                                        ),
                                                                                        child: Column(
                                                                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                          children: [
                                                                                            Row(
                                                                                              mainAxisAlignment:
                                                                                              MainAxisAlignment
                                                                                                  .spaceAround,
                                                                                              children: [
                                                                                                SizedBox(
                                                                                                  width: 26,
                                                                                                  height: 26,
                                                                                                  child: Container(
                                                                                                    decoration: BoxDecoration(
                                                                                                        color: Theme.of(context).highlightColor,
                                                                                                        borderRadius:
                                                                                                        BorderRadius.all(
                                                                                                            Radius.circular(5))),
                                                                                                    child:
                                                                                                    IconButton(
                                                                                                      icon: Icon(Icons
                                                                                                          .arrow_back_ios_new_rounded),
                                                                                                      padding:
                                                                                                      EdgeInsets
                                                                                                          .zero,
                                                                                                      alignment:
                                                                                                      Alignment
                                                                                                          .center,
                                                                                                      color: renkler
                                                                                                          .arkaRenk,
                                                                                                      iconSize: 20,
                                                                                                      onPressed:
                                                                                                          () {
                                                                                                        setState(
                                                                                                                () {
                                                                                                              categoryDeleteChanger = 0;
                                                                                                            });
                                                                                                      },
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Container(
                                                                                                  width: size.width * 0.65,
                                                                                                  height: 26,
                                                                                                  decoration: BoxDecoration(
                                                                                                      color: renkler.sariRenk,
                                                                                                      borderRadius:
                                                                                                      BorderRadius
                                                                                                          .circular(
                                                                                                          5)),
                                                                                                  child: Center(
                                                                                                    child: Text(
                                                                                                      "Sakla ve sil",style: TextStyle(color: renkler.koyuuRenk),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                            const Text("Seçtiğiniz kategori silenecek ve eski kayıtlarda bir değişiklik olmayacak.",textAlign: TextAlign.center,maxLines: 3,style: TextStyle(fontSize: 14),),
                                                                                            InkWell(
                                                                                              child: Container(
                                                                                                width: 90,
                                                                                                height: 26,
                                                                                                decoration: BoxDecoration(
                                                                                                    color: renkler.sariRenk,
                                                                                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                                                                                ),
                                                                                                child: Center(
                                                                                                  child: Text(
                                                                                                    "Tamam",
                                                                                                    style: TextStyle(
                                                                                                      color: renkler
                                                                                                          .koyuuRenk,
                                                                                                      fontSize: 14,
                                                                                                      height: 1,
                                                                                                      fontFamily: 'Nexa3',
                                                                                                    ),
                                                                                                    textAlign: TextAlign.center,
                                                                                                    maxLines: 4,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              onTap: () {
                                                                                                ///user cateory == seçili category, olanları bul ve bu listenin userCategorysini '' yap
                                                                                                readUpdateDB.categoryUsageCount(selectedCategory, _categoryController.text,1,'');
                                                                                                Navigator.of(context).pop();
                                                                                                readHome.setStatus();
                                                                                                setState((){});
                                                                                              },
                                                                                            ),
                                                                                          ],

                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Visibility(
                                                                                  visible : categoryDeleteChanger2 == 1,
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.only(top: 6),
                                                                                    child: SizedBox(
                                                                                      width: size.width * 0.81,
                                                                                      height: 120,
                                                                                      child: Container(
                                                                                        decoration: BoxDecoration(
                                                                                            border: Border.all(
                                                                                                color: Theme.of(context).highlightColor,
                                                                                                width: 1
                                                                                            ),
                                                                                            borderRadius: BorderRadius.all(Radius.circular(5))
                                                                                        ),
                                                                                        child: Column(
                                                                                          mainAxisAlignment:
                                                                                          MainAxisAlignment
                                                                                              .spaceAround,
                                                                                          children: [
                                                                                            Row(
                                                                                              mainAxisAlignment:
                                                                                              MainAxisAlignment
                                                                                                  .spaceAround,
                                                                                              children: [
                                                                                                SizedBox(
                                                                                                  width: 26,
                                                                                                  height: 26,
                                                                                                  child: Container(
                                                                                                    decoration: BoxDecoration(
                                                                                                        color: Theme.of(context).highlightColor,
                                                                                                        borderRadius:
                                                                                                        BorderRadius.all(
                                                                                                            Radius.circular(5))),
                                                                                                    child:
                                                                                                    IconButton(
                                                                                                      icon: Icon(Icons
                                                                                                          .arrow_back_ios_new_rounded),
                                                                                                      padding:
                                                                                                      EdgeInsets
                                                                                                          .zero,
                                                                                                      alignment:
                                                                                                      Alignment
                                                                                                          .center,
                                                                                                      color: renkler
                                                                                                          .arkaRenk,
                                                                                                      iconSize: 24,
                                                                                                      onPressed:
                                                                                                          () {
                                                                                                        setState(
                                                                                                                () {
                                                                                                              categoryDeleteChanger = 0;
                                                                                                            });
                                                                                                      },
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Container(
                                                                                                  width: size.width * 0.65,
                                                                                                  height: 26,
                                                                                                  decoration: BoxDecoration(
                                                                                                      color: renkler.sariRenk,
                                                                                                      borderRadius:
                                                                                                      BorderRadius
                                                                                                          .circular(
                                                                                                          5)),
                                                                                                  child: SizedBox(
                                                                                                      height: 26,
                                                                                                      child:
                                                                                                      Center(
                                                                                                        child: Text(
                                                                                                          "Değiştir ve sil",style: TextStyle(color: renkler.koyuuRenk),
                                                                                                        ),
                                                                                                      )
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                            Padding(
                                                                                              padding: const EdgeInsets.only(left: 4,right: 4),
                                                                                              child: Column(
                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                children: [
                                                                                                  Text('Değiştirmek istediğiniz kategoriyi seçiniz',style: TextStyle(fontSize: 14,height: 1,color: Theme.of(context).canvasColor,),),
                                                                                                  DropdownButtonHideUnderline(
                                                                                                    child: DropdownButton2<String>(
                                                                                                      isExpanded: true,
                                                                                                      hint: Text(
                                                                                                        'Kategori seçiniz',
                                                                                                        style: TextStyle(
                                                                                                          fontSize: 13,
                                                                                                          fontFamily: 'Nexa3',
                                                                                                          color:
                                                                                                          Theme.of(context).canvasColor,
                                                                                                        ),
                                                                                                        //textAlign: TextAlign.center,
                                                                                                      ),
                                                                                                      items: selectedCategory == 0
                                                                                                          ? mergedExpensList
                                                                                                          .map((item) =>
                                                                                                          DropdownMenuItem(
                                                                                                            value: item,
                                                                                                            child: Text(
                                                                                                              item,
                                                                                                              //textAlign: TextAlign.center,
                                                                                                              style: TextStyle(
                                                                                                                  fontSize: 13,
                                                                                                                  height: 1,
                                                                                                                  fontFamily:
                                                                                                                  'Nexa3',
                                                                                                                  color: Theme.of(
                                                                                                                      context)
                                                                                                                      .canvasColor),
                                                                                                            ),
                                                                                                          ))
                                                                                                          .toList()
                                                                                                          : mergedIncomeList
                                                                                                          .map((item) =>
                                                                                                          DropdownMenuItem(
                                                                                                            value: item,
                                                                                                            child: Text(
                                                                                                              item,
                                                                                                              style: TextStyle(
                                                                                                                  fontSize: 13,
                                                                                                                  fontFamily:
                                                                                                                  'Nexa3',
                                                                                                                  color: Theme.of(
                                                                                                                      context)
                                                                                                                      .canvasColor),
                                                                                                            ),
                                                                                                          ))
                                                                                                          .toList(),
                                                                                                      value: selectedValue,
                                                                                                      onChanged: (value) {
                                                                                                        setState(() {
                                                                                                          selectedValue = value;
                                                                                                          _categoryEdit.text = value.toString();
                                                                                                          this.setState(() {});
                                                                                                        });
                                                                                                      },
                                                                                                      barrierColor: renkler.koyuAraRenk
                                                                                                          .withOpacity(0.8),
                                                                                                      buttonStyleData: ButtonStyleData(
                                                                                                        overlayColor:
                                                                                                        MaterialStatePropertyAll(renkler
                                                                                                            .koyuAraRenk), // BAŞLANGIÇ BASILMA RENGİ
                                                                                                        height: 30,
                                                                                                        width: size.width*0.30,
                                                                                                      ),
                                                                                                      dropdownStyleData: DropdownStyleData(
                                                                                                          maxHeight: 200,
                                                                                                          width: size.width*0.30,
                                                                                                          decoration: BoxDecoration(
                                                                                                            color: Theme.of(context)
                                                                                                                .primaryColor,
                                                                                                          ),
                                                                                                          scrollbarTheme: ScrollbarThemeData(
                                                                                                              radius:
                                                                                                              const Radius.circular(15),
                                                                                                              thumbColor:
                                                                                                              MaterialStatePropertyAll(
                                                                                                                  renkler.sariRenk))),
                                                                                                      menuItemStyleData: MenuItemStyleData(
                                                                                                        overlayColor:
                                                                                                        MaterialStatePropertyAll(renkler
                                                                                                            .koyuAraRenk), // MENÜ BASILMA RENGİ
                                                                                                        height: 30,
                                                                                                      ),
                                                                                                      iconStyleData: IconStyleData(
                                                                                                        icon: const Icon(
                                                                                                          Icons.arrow_drop_down,
                                                                                                        ),
                                                                                                        iconSize: 16,
                                                                                                        iconEnabledColor: Theme.of(context)
                                                                                                            .secondaryHeaderColor,
                                                                                                        iconDisabledColor: Theme.of(context)
                                                                                                            .secondaryHeaderColor,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ],

                                                                                              ),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              height : 26,
                                                                                              child: TextButton(
                                                                                                onPressed: () {
                                                                                                  if (_categoryEdit
                                                                                                      .text ==
                                                                                                      '') {
                                                                                                    showDialog(
                                                                                                        context:
                                                                                                        context,
                                                                                                        builder:
                                                                                                            (context) {
                                                                                                          return AlertDialog(
                                                                                                            backgroundColor: Theme.of(context).primaryColor,
                                                                                                            title: Text("Eksik İşlem Yaptınız", style: TextStyle(color: Theme.of(context).secondaryHeaderColor, fontSize: 22, fontFamily: 'Nexa3')),
                                                                                                            content: Text(
                                                                                                              "Lütfen bir kategori giriniz!",
                                                                                                              style: TextStyle(color: Theme.of(context).canvasColor, fontSize: 16, fontFamily: 'Nexa3'),
                                                                                                            ),
                                                                                                            shadowColor: renkler.koyuuRenk,
                                                                                                            actions: [
                                                                                                              TextButton(
                                                                                                                onPressed: () {
                                                                                                                  Navigator.of(context).pop();
                                                                                                                },
                                                                                                                child: Text(
                                                                                                                  translation(context).ok,
                                                                                                                  style: TextStyle(color: Theme.of(context).secondaryHeaderColor, fontSize: 18, height: 1, fontFamily: 'Nexa3'),
                                                                                                                ),
                                                                                                              )
                                                                                                            ],
                                                                                                          );
                                                                                                        });
                                                                                                  } else {
                                                                                                    readUpdateDB.categoryUsageCount(selectedCategory, _categoryController.text,2,_categoryEdit.text);
                                                                                                    setState(
                                                                                                            () {
                                                                                                          _categoryEdit.clear();
                                                                                                          editChanger = 1;
                                                                                                        });
                                                                                                    Navigator.of(context).pop();
                                                                                                    readHome.setStatus();
                                                                                                  }
                                                                                                },
                                                                                                style: ButtonStyle(
                                                                                                    backgroundColor: MaterialStatePropertyAll(renkler.sariRenk),
                                                                                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                                                        const RoundedRectangleBorder(
                                                                                                          borderRadius: BorderRadius.all(Radius.circular(5)),
                                                                                                        )
                                                                                                    ),
                                                                                                    padding: const MaterialStatePropertyAll(EdgeInsets.only(left: 4,right: 4),)
                                                                                                ),
                                                                                                child: Text(
                                                                                                  _categoryEdit.text != '' ? "${_categoryEdit.text} ile değiştir" : "Tamam",
                                                                                                  style: TextStyle(
                                                                                                    color: renkler
                                                                                                        .koyuuRenk,
                                                                                                    fontSize: 13,
                                                                                                    height: 1,
                                                                                                    fontFamily: 'Nexa3',
                                                                                                  ),
                                                                                                  textAlign: TextAlign.center,
                                                                                                  maxLines: 4,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )),
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        }
                                                      }
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "Debug:${_category.text}",
                                        style:
                                        const TextStyle(color: Colors.red),
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          }
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
      width: size.width * 0.95,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2, left: 2, right: 2),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Color(0xFFF2CB05),
              ),
              height: 34,
              width: size.width * 0.95,
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
                highlightColor: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(30),
                child: SizedBox(
                  width: size.width * 0.95 - 130,
                  child: Center(
                    child: Text(
                      _customize.text == ""
                          ? "Özelleştirmek için dokunun"
                          : selectedCustomizeMenu == 0
                              ? '${_customize.text} Tekrar'
                              : '${_customize.text} Ay Taksit',
                      maxLines: 2,
                      style: TextStyle(
                          height: 1,
                          fontSize: 14,
                          fontFamily: 'Nexa3',
                          color: renkler.koyuuRenk),
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
                                      padding: const EdgeInsets.only(top: 15),
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
                                              inactiveBgColor: Theme.of(context)
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
                                                    fontWeight: FontWeight.w800)
                                              ],
                                              onToggle: (index) {
                                                setState(() {
                                                  if (index == 0) {
                                                    selectedCustomizeMenu = 0;
                                                    _customize.clear();
                                                  } else {
                                                    selectedCustomizeMenu = 1;
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
                                                        child: DropdownButton2<
                                                            String>(
                                                          isExpanded: true,
                                                          hint: Text(
                                                            'Seçiniz',
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              fontFamily:
                                                                  'Nexa3',
                                                              color: Theme.of(
                                                                      context)
                                                                  .canvasColor,
                                                            ),
                                                          ),
                                                          items: repetitiveList
                                                              .map((item) =>
                                                                  DropdownMenuItem(
                                                                    value: item,
                                                                    child: Text(
                                                                      item,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18,
                                                                          fontFamily:
                                                                              'Nexa3',
                                                                          color:
                                                                              Theme.of(context).canvasColor),
                                                                    ),
                                                                  ))
                                                              .toList(),
                                                          value:
                                                              selectedValueCustomize,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              selectedValueCustomize =
                                                                  value;
                                                              _customize.text =
                                                                  value
                                                                      .toString();
                                                              this.setState(
                                                                  () {});
                                                            });
                                                          },
                                                          barrierColor: renkler
                                                              .koyuAraRenk
                                                              .withOpacity(0.8),
                                                          buttonStyleData:
                                                              ButtonStyleData(
                                                            overlayColor:
                                                                MaterialStatePropertyAll(
                                                                    renkler
                                                                        .koyuAraRenk), // BAŞLANGIÇ BASILMA RENGİ
                                                            padding:
                                                                const EdgeInsets
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
                                                                  width: 200,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColor,
                                                                  ),
                                                                  scrollbarTheme: ScrollbarThemeData(
                                                                      radius:
                                                                          const Radius.circular(
                                                                              15),
                                                                      thumbColor:
                                                                          MaterialStatePropertyAll(
                                                                              renkler.sariRenk))),
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
                                                            icon: const Icon(
                                                              Icons
                                                                  .arrow_drop_down,
                                                            ),
                                                            iconSize: 30,
                                                            iconEnabledColor: Theme
                                                                    .of(context)
                                                                .secondaryHeaderColor,
                                                            iconDisabledColor:
                                                                Theme.of(
                                                                        context)
                                                                    .secondaryHeaderColor,
                                                            openMenuIcon: Icon(
                                                              Icons.arrow_right,
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
                                                                    color: Theme.of(
                                                                            context)
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
                                                                  fontSize: 16,
                                                                  fontFamily:
                                                                      'Nexa3',
                                                                ),
                                                                counterText: '',
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
                                                                signed: false,
                                                                decimal: false),
                                                        controller: _customize,
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
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              initialLabelIndexCustomize == 1
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
                                                            fontFamily: 'Nexa4',
                                                            fontWeight:
                                                                FontWeight.w800,
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
                                                                    Theme.of(
                                                                            context)
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
                                                            _customize.text =
                                                                "";
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
                                                            fontFamily: 'Nexa3',
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
                                                              renkler.sariRenk),
                                                      shape: MaterialStateProperty.all<
                                                              RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ))),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                    translation(context).ok,
                                                    style: TextStyle(
                                                      color: renkler.koyuuRenk,
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
          _operationDate.text =
              intl.DateFormat('dd.MM.yyyy').format(_selectedDate!);
        });
      }
    }

    return SizedBox(
      height: 38,
      width: 158,
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
              width: 156,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 58,
                child: Center(
                  child: Text(translation(context).date,
                      style: const TextStyle(
                        height: 1,
                        color: Colors.white,
                        fontSize: 13,
                        fontFamily: 'Nexa4',
                        fontWeight: FontWeight.w800,
                      )),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  color: Color(0xffF2CB05),
                ),
                child: SizedBox(
                  height: 38,
                  width: 100,
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
                        fontSize: 13,
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
  Widget amountCustomButton() {
    String getSymbolForMoneyType() {
      String controller = _moneyType.text;
      if (controller == 'TRY') {
        return '₺';
      } else if (controller == 'USD') {
        return '\$';
      } else if (controller == 'EUR') {
        return '€';
      } else if (controller == 'GBP') {
        return '£';
      } else if (controller == 'KWD') {
        return 'د.ك';
      } else if (controller == 'JOD') {
        return 'د.أ';
      } else if (controller == 'IQD') {
        return 'د.ع';
      } else if (controller == 'SAR') {
        return 'ر.س';
      } else {
        setState(() {
          _moneyType.text = ref.read(settingsRiverpod).Prefix.toString();
        });
        return ref
            .read(settingsRiverpod)
            .prefixSymbol
            .toString()
            .replaceAll(' ', '');
      }
    }

    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.95,
      child: Stack(
        children: [
          Positioned(
            top: 40,
            child: Container(
              width: size.width * 0.95,
              height: 4,
              decoration: BoxDecoration(
                  color: Theme.of(context).highlightColor,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
            ),
          ),
          Center(
            child: SizedBox(
              width: 250,
              height: 80,
              child: Row(
                children: [
                  openMoneyTypeMenu == false
                      ? SizedBox(
                          height: 38,
                          width: 207,
                          child: Stack(
                            children: [
                              Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(40)),
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
                                      child: Text(
                                          translation(context).amountDetails,
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
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
                                          keyboardType: const TextInputType
                                              .numberWithOptions(decimal: true),
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                              RegExp(r'^\d{0,6}(\.\d{0,2})?'),
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
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      top: 12))),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                  openMoneyTypeMenu == false
                      ? const SizedBox(
                          width: 5,
                        )
                      : const SizedBox(),
                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      setState(() {
                        openMoneyTypeMenu == false
                            ? openMoneyTypeMenu = true
                            : openMoneyTypeMenu = false;
                        openMoneyTypeMenu == true
                            ? moneyTypeWidth = 250
                            : moneyTypeWidth = 38;
                        openMoneyTypeMenu == true
                            ? moneyTypeHeight = 80
                            : moneyTypeHeight = 38;
                      });
                    },
                    child: Container(
                      height: moneyTypeHeight,
                      width: moneyTypeWidth,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Color(0xffF2CB05),
                      ),
                      child: openMoneyTypeMenu == false
                          ? Center(
                              child: Text(
                                getSymbolForMoneyType(),
                                style: const TextStyle(
                                  height: 1,
                                  fontFamily: 'TL',
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff0D1C26),
                                ),
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(15)),
                                          color: renkler.koyuuRenk,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "TRY",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Nexa4',
                                                color: renkler.arkaRenk),
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
                                      child: Container(
                                        width: 44,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(15)),
                                          color: renkler.koyuuRenk,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "USD",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Nexa4',
                                                color: renkler.arkaRenk),
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
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(15)),
                                          color: renkler.koyuuRenk,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "EUR",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Nexa4',
                                                color: renkler.arkaRenk),
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
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(15)),
                                          color: renkler.koyuuRenk,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "GBP",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Nexa4',
                                                color: renkler.arkaRenk),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(15)),
                                          color: renkler.koyuuRenk,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "KWD",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Nexa4',
                                                color: renkler.arkaRenk),
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
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(15)),
                                          color: renkler.koyuuRenk,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "JOD",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Nexa4',
                                                color: renkler.arkaRenk),
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
                                      child: Container(
                                        width: 44,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(15)),
                                          color: renkler.koyuuRenk,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "IQD",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Nexa4',
                                                color: renkler.arkaRenk),
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
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(15)),
                                          color: renkler.koyuuRenk,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "SAR",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Nexa4',
                                                color: renkler.arkaRenk),
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
    var size = MediaQuery.of(context).size;
    return SizedBox(
        height: 34,
        child: ToggleSwitch(
          initialLabelIndex: initialLabelIndexTool,
          totalSwitches: 3,
          dividerColor: Theme.of(context).highlightColor,
          labels: [
            translation(context).cash,
            translation(context).card,
            translation(context).otherPaye
          ],
          activeBgColor: const [Color(0xffF2CB05)],
          activeFgColor: const Color(0xff0D1C26),
          inactiveBgColor: Theme.of(context).highlightColor,
          inactiveFgColor: const Color(0xFFE9E9E9),
          minWidth: size.width > 392 ? size.width * 0.18 : 70,
          cornerRadius: 15,
          radiusStyle: true,
          animate: true,
          curve: Curves.linearToEaseOut,
          customTextStyles: const [
            TextStyle(
                fontSize: 13,
                fontFamily: 'Nexa4',
                height: 1,
                fontWeight: FontWeight.w800)
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
      width: 120,
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
              width: 114,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 80,
                child: Center(
                  child: Text(translation(context).save,
                      style: TextStyle(
                          color: Colors.white,
                          height: 1,
                          fontSize: 13,
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
      return GestureDetector(
          onTap: () {
            setState(() {
              regss = 1;
              _registration.text = '1';
            });
          },
          child: Center(
            child: const Icon(
              Icons.bookmark_add_outlined,
              color: Colors.white,
            ),
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
      width: size.width * 0.95,
      height: 125,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              height: 90,
              width: size.width * 0.95,
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
            width: size.width * 0.94,
            height: 115,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18, top: 34, right: 18),
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
                      '${_note.text.length}/${maxLength.toString()}',
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
                padding: const EdgeInsets.only(left: 20, right: 20),
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
                          height: 1,
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
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: SizedBox(
                  width: 60,
                  height: 26,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Theme.of(context).shadowColor,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        textLength = 0;
                        setState(() {
                          _note.text = "";
                        });
                      },
                      child: Center(
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
              ),
            ],
          ),
        ],
      ),
    );
  }

  String systemMessage = "";

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
              width: size.width > 392 ? size.width * 0.34 : 130,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      _note.text = "";
                      _amount.text = "";
                      textLength = 0;
                      setState(() {
                        _category.text = "";
                        _customize.text = "";
                      });
                      //operationCustomButton(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Theme.of(context).shadowColor,
                      ),
                      height: 32,
                      width: size.width > 392 ? size.width * 0.34 : 130,
                      child: Center(
                        child: Text(translation(context).deleteAll,
                            style: TextStyle(
                                height: 1,
                                color: Theme.of(context).canvasColor,
                                fontSize: 15,
                                fontFamily: 'Nexa4',
                                fontWeight: FontWeight.w900)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: size.width > 392 ? size.width * 0.39 : 150,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      setAlertContent(context);
                      double amount = double.tryParse(_amount.text) ?? 0.0;
                      if (amount != 0.0 && _category.text.isNotEmpty) {
                        if (selectedCustomizeMenu == 1 &&
                            _customize.text != "") {
                          amount = double.parse(
                              (amount / double.parse(_customize.text))
                                  .toStringAsFixed(2));
                          systemMessage =
                          "1/${_customize.text} taksit işlendi";
                          _customize.text = "1/${_customize.text}";
                        } else if (selectedCustomizeMenu == 0 &&
                            _customize.text != "") {
                          systemMessage = "${_customize.text} tekrar işlendi";
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
                          ref.read(currencyRiverpod).calculateRealAmount(
                              amount,
                              _moneyType.text,
                              ref.read(settingsRiverpod).Prefix!),
                          _customize.text,
                          _category.text,
                          systemMessage,
                        );

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
                                backgroundColor:
                                Theme.of(context).primaryColor,
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
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: renkler.sariRenk,
                      ),
                      height: 34,
                      width: size.width > 392 ? size.width * 0.39 : 150,
                      child: Center(
                        child: Text(translation(context).done,
                            style: TextStyle(
                                height: 1,
                                color: renkler.koyuuRenk,
                                fontSize: 16,
                                fontFamily: 'Nexa4',
                                fontWeight: FontWeight.w900)),
                      ),
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