import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/models/spend_info.dart';
import 'package:butcekontrol/utils/interstitial_ads.dart';
import 'package:butcekontrol/utils/textConverter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' as intl;
import 'package:toggle_switch/toggle_switch.dart';
import '../riverpod_management.dart';
import 'package:butcekontrol/classes/language.dart';

class UpdateData extends StatefulWidget {
  const UpdateData({Key? key}) : super(key: key);
  @override
  State<UpdateData> createState() => _AddDataState();
}

class _AddDataState extends State<UpdateData> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      bottom: false,
      child: Scaffold(
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
    CustomColors renkler = CustomColors();
    int menuController = ref.read(updateDataRiverpod).getMenuController();
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
                  child:  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Image.asset(
                          "assets/icons/pencil.png",
                          height: 18,
                          width: 18,
                          color: renkler.yaziRenk,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20,right: 20,top: 6),
                        child: Text(
                          menuController == 0 ? translation(context).editTitle : translation(context).addAgainTitle,
                          style: TextStyle(
                            height: 1,
                            fontFamily: 'Nexa4',
                            fontSize: 20,
                            color: renkler.yaziRenk,
                          ),
                        ),
                      ),
                    ],
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
                  decoration: BoxDecoration(
                      color: Theme.of(context).disabledColor,
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
                      color: renkler.yaziRenk,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      read.setCurrentindex(0);
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
    } else {
    }
    super.initState();
  }
  void _showInterstitialAd(BuildContext context) {
    _interstitialAdManager.showInterstitialAd(context);
  }

  FocusNode amountFocusNode = FocusNode();
  FocusNode dateFocusNode = FocusNode();
  CustomColors renkler = CustomColors();
  @override
  Widget build(BuildContext context) {
    var readUpdateData = ref.read(updateDataRiverpod);
    final operationType = readUpdateData.getType();
    final category = readUpdateData.getCategory();
    final operationDate = readUpdateData.getOperationDate();
    final amount = readUpdateData.getAmount();
    final operationTool = readUpdateData.getOperationTool();
    final registration = readUpdateData.getRegistration();
    final note = readUpdateData.getNote();
    final customize = readUpdateData.getProcessOnce();
    final moneyType = readUpdateData.getMoneyType();
    final realAmount0 = readUpdateData.getRealAmount();
    final userCategory = readUpdateData.getUserCategory();
    final systemMessage = readUpdateData.getSystemMessage();
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: SizedBox(
        height: size.height*0.85,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [typeCustomButton(context), dateCustomButton(context)],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              categoryBarCustom(context,ref),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: size.width*0.95,
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
              customizeBarCustom(context,ref),
              const SizedBox(
                //height: 15,
                height : 5,
              ),
              amountCustomButton(),
              /*
              SizedBox(
                  width: size.width*0.95,
                  child: Text('DEBUG: ${operationType.text} -${operationDate.text} - ${category.text} - ${operationTool.text} - ${int.parse(registration.text)} - ${note.text} - ${customize.text} - $convertedCustomize - ${amount.text} - ${moneyType.text} - ${realAmount0.text} - ${userCategoryController != "" ? userCategoryController : category.text == userCategory.text ? userCategory.text : ""} - ${systemMessage.text} - ${moneyTypeSymbol.text}',style: const TextStyle(color: Colors.red,fontFamily: 'TL'))),
             */
              const SizedBox(
                height: 5,
              ),
              operationCustomButton(context),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }



  Widget typeCustomButton(BuildContext context) {

    var readUpdateData = ref.read(updateDataRiverpod);
    final operationType = readUpdateData.getType();
    final category = readUpdateData.getCategory();
    int initialLabelIndex ;
    operationType.text == 'Gider' ? initialLabelIndex = 0: initialLabelIndex =1;
    var size = MediaQuery.of(context).size;
    return SizedBox(
        height: 34,
        child: ToggleSwitch(
          initialLabelIndex: initialLabelIndex,
          totalSwitches: 2,
          labels: [translation(context).expenses, translation(context).income],
          activeBgColor: [Theme.of(context).disabledColor],
          activeFgColor: const Color(0xff0D1C26),
          inactiveBgColor: Theme.of(context).highlightColor,
          inactiveFgColor: const Color(0xFFE9E9E9),
          minWidth: size.width > 392.6 ? size.width*0.235 : 92,
          cornerRadius: 15,
          radiusStyle: true,
          animate: true,
          curve: Curves.linearToEaseOut,
          customTextStyles: const [
            TextStyle(
                fontSize: 13, fontFamily: 'Nexa4',height: 1, fontWeight: FontWeight.w800)
          ],
          onToggle: (index) {
            if (index == 0) {
              setState(() {
                operationType.text = "Gider";
                selectedCategory = 0;
                category.clear();
                selectedValue = null;
              });
            } else {
              setState(() {
                operationType.text = "Gelir";
                selectedCategory = 1;
                category.clear();
                selectedValue = null;
              });
            }
            initialLabelIndex = index!;
          },
        ));
  }
  String? selectedValue;
  int initialLabelIndex2 = 0;
  int selectedAddCategoryMenu = 0;
  int sortChanger = 0;
  int editChanger = 0;
  double heightChanger = 40.0;
  int categoryColorChanger = 999;
  int categoryDeleteChanger = 0;
  int categoryDeleteChanger2 = 0;
  int categoryEditChanger = 0;
  int categoryEditChanger2 = 0;
  String convertedCategory = "";
  String convertedCustomize = "";
  String userCategoryController = "";
  int isAdded = 0;
  final TextEditingController _categoryEdit = TextEditingController(text: "");
  final TextEditingController _categoryController = TextEditingController(text: "");
  Widget categoryBarCustom(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size;
    var readHome = ref.read(homeRiverpod);
    var readUpdateDB = ref.read(updateDataRiverpod);
    final category = readUpdateDB.getCategory();
    convertedCategory = Converter().textConverterToDB(category.text, context, 0);
    return SizedBox(
      height: 38,
      width: size.width * 0.95,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 2, left: 2, right: 2),
            child: Container(
              decoration:  BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Theme.of(context).disabledColor,
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
                    style: TextStyle(
                      height: 1,
                      color: renkler.yaziRenk,
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
                      category.text == ""
                          ? translation(context).tapToSelect
                          : category.text,
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
                        future: readUpdateDB.myCategoryLists(context),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('${translation(context).somethingWentWrong} ${snapshot.error}');
                          } else {
                            final categoryLists = snapshot.data!;
                            List<String> oldCategoryListIncome = [
                              translation(context).pocketMoneyIncome,
                              translation(context).grantIncome,
                              translation(context).salaryIncome,
                              translation(context).creditIncome,
                              translation(context).personalIncome,
                              translation(context).duesRentIncome,
                              translation(context).overtimeIncome,
                              translation(context).freelanceIncome,
                              translation(context).incomeViaCurrencyIncome,
                              translation(context).investmentIncome,
                              translation(context).otherIncome,
                            ];
                            final categoryListIncome =
                                categoryLists['income'] ??
                                    ['Kategori bulunamadı'];
                            List<String> oldCategoryListExpense = [
                              translation(context).foodExpense,
                              translation(context).clothingExpense,
                              translation(context).entertainmentExpense,
                              translation(context).educationExpense,
                              translation(context).duesRentExpense,
                              translation(context).shoppingExpense,
                              translation(context).personelExpense,
                              translation(context).transportExpense,
                              translation(context).healthExpense,
                              translation(context).dailyExpenses,
                              translation(context).hobbyExpense,
                              translation(context).otherExpense,
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
                                                                  category.clear();
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
                                                          child:  Center(
                                                            child:
                                                            FittedBox(
                                                              child: Text(
                                                                selectedCategory ==
                                                                    0
                                                                    ? translation(context).expenseCategories
                                                                    : translation(context).incomeCategories,
                                                                style: TextStyle(
                                                                    color: renkler
                                                                        .arkaRenk,
                                                                    fontSize:
                                                                    15),
                                                                //overflow: TextOverflow.visible,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 30,
                                                          height: 30,
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                color: sortChanger == 0 ? Theme.of(context).highlightColor : Theme.of(context).disabledColor,
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
                                                                        category.clear();
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
                                                                  category
                                                                      .text = getList(selectedCategory, sortChanger)[
                                                                  index]
                                                                      .toString();
                                                                  categoryColorChanger =
                                                                      index;
                                                                  convertedCategory = Converter().textConverterToDB(category.text, context, 0);
                                                                  userCategoryController = (oldCategoryListExpense.contains(Converter().textCategoryConverter(category.text, context)) == false || oldCategoryListIncome.contains(Converter().textCategoryConverter(category.text, context)) == false) ? Converter().textCategoryConverter(category.text, context) : "";
                                                                });
                                                              },
                                                              highlightColor: Theme.of(context).primaryColor,
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
                                                              isAdded = 1;
                                                              categoryColorChanger = 999;
                                                              category.clear();
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
                                                              translation(context).addDeleteCategory,
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
                                                                .doneCategory,
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
                                                              color: Theme.of(context).disabledColor,
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
                                                                    isAdded = 1;
                                                                    if (categoryColorChanger != 999) {
                                                                      categoryColorChanger = 999;
                                                                      category.clear();
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
                                                                        ? translation(context).addExpenseCategory
                                                                        : translation(context).addIncomeCategory,
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
                                                                category,
                                                                onChanged:
                                                                    (value) {
                                                                  setState(
                                                                          () {
                                                                            convertedCategory = category.text;
                                                                            userCategoryController = category.text;
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
                                                                if (category
                                                                    .text ==
                                                                    '') {
                                                                  showDialog(
                                                                      context:
                                                                      context,
                                                                      builder:
                                                                          (context) {
                                                                        return AlertDialog(
                                                                          backgroundColor: Theme.of(context).primaryColor,
                                                                          title: Text(translation(context).missingEntry, style: TextStyle(color: Theme.of(context).secondaryHeaderColor, fontSize: 22, fontFamily: 'Nexa3')),
                                                                          content: Text(
                                                                            translation(context).enterCategoryWarning,
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
                                                                  isAdded = 0;
                                                                }

                                                                setState(
                                                                        () {
                                                                      userCategoryController = (oldCategoryListExpense.contains(Converter().textCategoryConverter(category.text, context)) == false || oldCategoryListIncome.contains(Converter().textCategoryConverter(category.text, context)) == false) ? Converter().textCategoryConverter(category.text, context) : "";
                                                                      convertedCategory = category.text;
                                                                    });
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
                                                              return Container(
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
                                                                                isAdded = 0;
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
                                                                                isAdded = 0;
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
                                                                    ) : FittedBox(
                                                                      child: Text(translation(context).systemCategory,textAlign: TextAlign.center,style: const TextStyle(
                                                                          fontSize: 11,height: 1
                                                                      ),),
                                                                    )
                                                                  ],
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
                                                              isAdded = 0;
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
                                                              translation(context).addDeleteCategory,
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
                                                        child: Visibility(
                                                          visible: isAdded == 0,
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
                                                                  .doneCategory,
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
                                                                  translation(context).editCategory,style: TextStyle(color: renkler.arkaRenk),
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
                                                                              Text(translation(context).categoryWithTwoDots),
                                                                              Text(_categoryController.text),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(top: 10),
                                                                          child: Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text(translation(context).numberOfActivities),
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
                                                                                              color: Theme.of(context).disabledColor,
                                                                                              borderRadius:
                                                                                              BorderRadius
                                                                                                  .circular(
                                                                                                  5)),
                                                                                          child: SizedBox(
                                                                                              height: 26,
                                                                                              child:
                                                                                              Center(
                                                                                                child: Text(
                                                                                                  categoryEditChanger2 == 3 ? translation(context).keepAndEdit: categoryEditChanger2 == 4 ? translation(context).replaceAndEdit : "Düzenle",style: TextStyle(color: renkler.koyuuRenk),
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
                                                                                          Text(translation(context).replaceCategoryQuestion,style: TextStyle(fontSize: 14,height: 1,color: Theme.of(context).canvasColor,),textAlign: TextAlign.center),
                                                                                          SizedBox(
                                                                                            width : size.width*0.32,
                                                                                            height: 24,
                                                                                            child: TextField(
                                                                                              maxLength: 20,
                                                                                              maxLines: 1,
                                                                                              style:
                                                                                              TextStyle(color: Theme.of(context).canvasColor,fontSize: 13,fontFamily: 'Nexa3'),
                                                                                              decoration: InputDecoration(
                                                                                                  hintText: translation(context).enterCategory,
                                                                                                  hintStyle: TextStyle(
                                                                                                      color: Theme.of(context).canvasColor,
                                                                                                      fontSize: 13,
                                                                                                      fontFamily: 'Nexa3',
                                                                                                      height: 1
                                                                                                  ),
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
                                                                                                    title: Text(translation(context).missingEntry, style: TextStyle(color: Theme.of(context).secondaryHeaderColor, fontSize: 22, fontFamily: 'Nexa3', height: 1)),
                                                                                                    content: Text(
                                                                                                      translation(context).enterCategoryWarning,
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
                                                                                            backgroundColor: MaterialStatePropertyAll(Theme.of(context).disabledColor),
                                                                                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                                                const RoundedRectangleBorder(
                                                                                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                                                                                )
                                                                                            ),
                                                                                            padding: const MaterialStatePropertyAll(EdgeInsets.only(left: 4,right: 4),)
                                                                                        ),
                                                                                        child: Text(
                                                                                          _categoryEdit.text != '' ? "${translation(context).replaceWithExceptTurkish} ${_categoryEdit.text} ${translation(context).replaceWithOnlyTurkish}" : translation(context).doneSmall,
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
                                                                                  translation(context).editAndKeep,
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
                                                                                  translation(context).editAndReplace,
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
                                                                  translation(context).deleteCategory,style: TextStyle(color: renkler.arkaRenk),
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
                                                                                Text(translation(context).categoryWithTwoDots),
                                                                                Text(_categoryController.text),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(top: 10),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Text(translation(context).numberOfActivities),
                                                                                Text("${snapshot.data}"),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          const Spacer(),
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
                                                                                    translation(context).deleteAndKeep,
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
                                                                                    translation(context).deleteAndReplace,
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
                                                                                      height: 140,
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
                                                                                                      color: Theme.of(context).disabledColor,
                                                                                                      borderRadius:
                                                                                                      BorderRadius
                                                                                                          .circular(
                                                                                                          5)),
                                                                                                  child: Center(
                                                                                                    child: Text(
                                                                                                      translation(context).keepAndDelete,style: TextStyle(color: renkler.koyuuRenk),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                            Text(translation(context).categoryWillBeDeletedOldRecordsWillNotBeChanged,textAlign: TextAlign.center,maxLines: 3,style: TextStyle(fontSize: 14),),
                                                                                            InkWell(
                                                                                              child: Container(
                                                                                                width: 90,
                                                                                                height: 26,
                                                                                                decoration: BoxDecoration(
                                                                                                    color: Theme.of(context).disabledColor,
                                                                                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                                                                                ),
                                                                                                child: Center(
                                                                                                  child: Text(
                                                                                                    translation(context).ok,
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
                                                                                                      color: Theme.of(context).disabledColor,
                                                                                                      borderRadius:
                                                                                                      BorderRadius
                                                                                                          .circular(
                                                                                                          5)),
                                                                                                  child: SizedBox(
                                                                                                      height: 26,
                                                                                                      child:
                                                                                                      Center(
                                                                                                        child: Text(
                                                                                                          translation(context).replaceAndDelete,style: TextStyle(color: renkler.koyuuRenk),
                                                                                                        ),
                                                                                                      )
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                            Padding(
                                                                                              padding: const EdgeInsets.only(left: 4,right: 4),
                                                                                              child: Row(
                                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                                children: [
                                                                                                  Column(
                                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                    children: [
                                                                                                      Text(translation(context).replaceCategoryOldRecords,style: TextStyle(fontSize: 14,height: 1,color: Theme.of(context).canvasColor,),textAlign: TextAlign.center),
                                                                                                      DropdownButtonHideUnderline(
                                                                                                        child: DropdownButton2<String>(
                                                                                                          isExpanded: true,
                                                                                                          hint: Text(
                                                                                                            translation(context).selectCategory,
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
                                                                                                                      Theme.of(context).disabledColor))),
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
                                                                                                            title: Text(translation(context).missingEntry, style: TextStyle(color: Theme.of(context).secondaryHeaderColor, fontSize: 22, fontFamily: 'Nexa3', height: 1)),
                                                                                                            content: Text(
                                                                                                              translation(context).enterCategoryWarning,
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
                                                                                                    backgroundColor: MaterialStatePropertyAll(Theme.of(context).disabledColor),
                                                                                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                                                        const RoundedRectangleBorder(
                                                                                                          borderRadius: BorderRadius.all(Radius.circular(5)),
                                                                                                        )
                                                                                                    ),
                                                                                                    padding: const MaterialStatePropertyAll(EdgeInsets.only(left: 4,right: 4),)
                                                                                                ),
                                                                                                child: Text(
                                                                                                  _categoryEdit.text != '' ? "${translation(context).replaceWithExceptTurkish} ${_categoryEdit.text} ${translation(context).replaceWithOnlyTurkish}" : translation(context).doneSmall,
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
                                      /*
                                      Text(
                                        "Debug:${category.text} - ${convertedCategory} - ${userCategoryController}",
                                        style:
                                        const TextStyle(color: Colors.red),
                                      )
                                       */
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

  DateTime? _selectedDate;
  Widget dateCustomButton(BuildContext context) {
    var readUpdateData = ref.read(updateDataRiverpod);
    var readSettings = ref.read(settingsRiverpod);
    final operationDate = readUpdateData.getOperationDate();
    List <String> parts = operationDate.text.split(".");
    int parseDay = int.parse(parts[0]);
    int parseMonth = int.parse(parts[1]);
    int parseYear = int.parse(parts[2]);
    DateTime itemDate = DateTime(parseYear,parseMonth,parseDay);
    _selectedDate = itemDate;
    Future<void> selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate ?? DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2030),
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        initialDatePickerMode: DatePickerMode.day,
        keyboardType: TextInputType.number,
        builder: (context, child) {
          FocusScope.of(context).unfocus();
          return Theme(
            data: Theme.of(context).copyWith(
              dialogTheme: DialogTheme(
                  shadowColor: Colors.black54,
                  backgroundColor: Theme.of(context).indicatorColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)))),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder( borderRadius: BorderRadius.all(Radius.circular(10))),
                    foregroundColor: Theme.of(context).canvasColor,
                    textStyle: TextStyle(fontFamily: "Nexa3",height: 1,fontSize: 15)// button text color
                ),
              ),
              dividerTheme: DividerThemeData(
                  color: Theme.of(context).canvasColor,
                  indent: 10,
                  endIndent: 10,
                  thickness: 1.5
              ),
              datePickerTheme: DatePickerThemeData(
                dayStyle: TextStyle(fontFamily: "Nexa3",height: 1,fontSize: 15),
                todayForegroundColor: MaterialStatePropertyAll(Theme.of(context).disabledColor),
                dayOverlayColor: MaterialStatePropertyAll(Theme.of(context).disabledColor),
                headerForegroundColor: renkler.yaziRenk,
                weekdayStyle: TextStyle(fontFamily: "Nexa4",height: 1,fontSize: 15,color: Theme.of(context).secondaryHeaderColor),
                yearForegroundColor: MaterialStatePropertyAll(Theme.of(context).canvasColor),
                yearOverlayColor: MaterialStatePropertyAll(Theme.of(context).disabledColor),
                yearBackgroundColor: MaterialStatePropertyAll(Theme.of(context).primaryColor),
                headerBackgroundColor: renkler.koyuuRenk,
              ),
              textTheme: TextTheme(
                labelSmall: const TextStyle(
                  ///tarih seçiniz
                    fontSize: 16,
                    fontFamily: 'Nexa4'),
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
                bodyLarge: TextStyle(
                  ///alt YILLAR
                    fontSize: 16,
                    fontFamily: 'Nexa3',
                    color: Theme.of(context).disabledColor),
              ),
              colorScheme: ColorScheme(
                brightness: Brightness.light,
                primary: renkler.koyuuRenk, // üst taraf arkaplan rengi
                onPrimary: renkler.arkaRenk, //üst taraf yazı rengi
                secondary: renkler.kirmiziRenk,
                onSecondary: renkler.arkaRenk,
                primaryContainer: renkler.kirmiziRenk,
                error: const Color(0xFFD91A2A),
                onError: const Color(0xFFD91A2A),
                background: renkler.kirmiziRenk,
                onBackground: renkler.yesilRenk,
                surface: Theme.of(context).disabledColor, //ÜST TARAF RENK
                onPrimaryContainer: renkler.yesilRenk,
                onSurface: Theme.of(context).canvasColor, //alt günlerin rengi
              ),
            ),
            child: child!,
          );
        },
      );

      if (picked != null) {
        setState(() {
          _selectedDate = picked;
          operationDate.text = intl.DateFormat('dd.MM.yyyy').format(_selectedDate!);
        });
      }
    }


    String getFormattedDate(String date){
      List <String> parts = date.split(".");
      int parseDay = int.parse(parts[0]);
      int parseMonth = int.parse(parts[1]);
      int parseYear = int.parse(parts[2]);
      String formattedDate = readSettings.dateFormat == "yyyy.MM.dd" ? "$parseYear.$parseMonth.$parseDay" : readSettings.dateFormat == "MM.dd.yyyy" ? "$parseMonth.$parseDay.$parseYear" : "$parseDay.$parseMonth.$parseYear";
      return formattedDate;
    }

    return SizedBox(
      height: 38,
      width: 134,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(40)),
                color: Theme.of(context).highlightColor,
              ),
              height: 34,
              width: 132,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 34,
                child: Center(
                    child: Icon(
                      Icons.edit_calendar_rounded,
                      color: renkler.yaziRenk,
                      size: 22,
                    )
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  color: Theme.of(context).disabledColor,
                ),
                child: SizedBox(
                  height: 38,
                  width: 100,
                  child: InkWell(
                    onTap: () {
                      selectDate(context);
                    },
                    child: Center(
                        child: Text(
                          getFormattedDate(operationDate.text),
                          style: TextStyle(
                              color: renkler.koyuuRenk,
                              height: 1,
                              fontSize: 13,
                              fontFamily: 'Nexa4'),
                        )),
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
  final TextEditingController moneyTypeSymbol =  TextEditingController(text: "₺");
  Widget amountCustomButton() {
    var readUpdateData = ref.read(updateDataRiverpod);
    final amount = readUpdateData.getAmount();
    final moneyType = readUpdateData.getMoneyType();
    final operationType = readUpdateData.getType();
    String moneyActivate = operationType.text == "Gider" ? "" : "1";

    String getSymbolForMoneyType(){
      String controller = moneyType.text;
      if(controller == 'TRY$moneyActivate'|| controller == 'TRY'){
        moneyType.text = 'TRY$moneyActivate';
        return '₺';
      }else if (controller == 'USD$moneyActivate'|| controller == 'USD'){
        moneyType.text = 'USD$moneyActivate';
        return '\$';
      }
      else if (controller == 'EUR$moneyActivate' || controller == 'EUR'){
        moneyType.text = 'EUR$moneyActivate';
        return '€';
      }
      else if (controller == 'GBP$moneyActivate'|| controller == 'GBP'){
        moneyType.text = 'GBP$moneyActivate';
        return '£';
      }
      else if (controller == 'KWD$moneyActivate'|| controller == 'KWD'){
        moneyType.text = 'KWD$moneyActivate';
        return 'د.ك';
      }
      else if (controller == 'JOD$moneyActivate'|| controller == 'JOD'){
        moneyType.text = 'JOD$moneyActivate';
        return 'د.أ';
      }
      else if (controller == 'IQD$moneyActivate'|| controller == 'IQD'){
        moneyType.text = 'IQD$moneyActivate';
        return 'د.ع';
      }
      else if (controller == 'SAR$moneyActivate'|| controller == 'SAR'){
        moneyType.text = 'SAR$moneyActivate';
        return 'ر.س';
      }
      else{
        setState(() {
        moneyType.text = "${controller.substring(0,3)}$moneyActivate";
      });
      return getSymbolForMoneyType();
      }
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
                                        color: renkler.yaziRenk,
                                        fontSize: 15,
                                        fontFamily: 'Nexa4',
                                        fontWeight: FontWeight.w800)),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                color: Theme.of(context).disabledColor,
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
                                    controller: amount,
                                    autofocus: false,
                                    focusNode: amountFocusNode,
                                    keyboardType: const TextInputType.numberWithOptions(
                                        decimal: true),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d{0,7}(\.\d{0,2})?'),
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
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Theme.of(context).disabledColor,
                      ),
                      child: openMoneyTypeMenu == false ? Center(
                        child:  Text(
                          getSymbolForMoneyType(),
                          style: const TextStyle(
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
                                    moneyType.text = 'TRY$moneyActivate';
                                    moneyTypeSymbol.text = "₺";
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
                                    moneyType.text = 'USD$moneyActivate';
                                    moneyTypeSymbol.text = "\$";
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
                                    moneyType.text = 'EUR$moneyActivate';
                                    moneyTypeSymbol.text = "€";
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
                                    moneyType.text = 'GBP$moneyActivate';
                                    moneyTypeSymbol.text = "£";
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
                                    moneyType.text = 'KWD$moneyActivate';
                                    moneyTypeSymbol.text = "د.ك";
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
                                    moneyType.text = 'JOD$moneyActivate';
                                    moneyTypeSymbol.text = "د.أ";
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
                                    moneyType.text = 'IQD$moneyActivate';
                                    moneyTypeSymbol.text = "د.ع";
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
                                    moneyType.text = 'SAR$moneyActivate';
                                    moneyTypeSymbol.text = "ر.س";
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
    var size = MediaQuery.of(context).size;
    var readUpdateData = ref.read(updateDataRiverpod);
    final operationTool = readUpdateData.getOperationTool();
    if(operationTool.text == 'Nakit'){
      initialLabelIndexTool =0;
    }
    else if(operationTool.text == 'Kart'){
      initialLabelIndexTool =1;
    }
    else{
      initialLabelIndexTool =2;
    }
    return SizedBox(
        height: 34,
        child: ToggleSwitch(
          initialLabelIndex: initialLabelIndexTool,
          totalSwitches: 3,
          dividerColor: Theme.of(context).highlightColor,
          labels:  [translation(context).cash, translation(context).card, translation(context).otherPaye],
          activeBgColor: [Theme.of(context).disabledColor],
          activeFgColor: const Color(0xff0D1C26),
          inactiveBgColor: Theme.of(context).highlightColor,
          inactiveFgColor: const Color(0xFFE9E9E9),
          minWidth: size.width > 392 ? size.width*0.18 : 70,
          cornerRadius: 15,
          radiusStyle: true,
          animate: true,
          curve: Curves.linearToEaseOut,
          customTextStyles: const [
            TextStyle(
                fontSize: 13, fontFamily: 'Nexa4', height: 1,fontWeight: FontWeight.w800)
          ],
          onToggle: (index) {
            if (index == 0) {
              setState(() {
                operationTool.text = "Nakit";
              });
            } else if(index == 1 ) {
              setState(() {
                operationTool.text = "Kart";
              });
            }
            else{
              setState(() {
                operationTool.text = "Diğer";
              });
            }
            initialLabelIndexTool = index!;
          },
        ));
  }

  int regss = 0;
  Widget regCustomButton(BuildContext context) {
    return SizedBox(
      height: 38,
      width: 110,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(40)),
                color: Theme.of(context).highlightColor,
              ),
              height: 34,
              width: 104,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 70,
                child: Center(
                  child: Text(translation(context).save,
                      style:  TextStyle(
                          color: renkler.yaziRenk,
                          height: 1,
                          fontSize: 13,
                          fontFamily: 'Nexa4',
                          fontWeight: FontWeight.w800)),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Theme.of(context).disabledColor,
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
    var readUpdateData = ref.read(updateDataRiverpod);
    final registration = readUpdateData.getRegistration();
    if(registration.text== '0'){
      return IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            setState(() {
              regss = 1;
              registration.text = '1';
            });
          },
          icon: Icon(
            Icons.bookmark_add_outlined,
            color: renkler.yaziRenk,
          ));
    }
    else{
      return IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            setState(() {
              regss = 0;
              registration.text = '0';
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
    var readUpdateData = ref.read(updateDataRiverpod);
    final note = readUpdateData.getNote();
    var size = MediaQuery.of(context).size;
    var readSettings = ref.read(settingsRiverpod);
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
                  padding: const EdgeInsets.only(left: 18, right: 18, top: 34),
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
                    controller: note,
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
                        color: Theme.of(context).disabledColor,
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
                  height: 34,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                    child:  Center(
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
                padding: const EdgeInsets.only(right: 20,left: 20),
                child: SizedBox(
                  width: 60,
                  height: 26,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Theme.of(context).shadowColor,
                    ),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          note.text = "";
                        });
                      },
                      child: Text(
                        translation(context).delete,
                        style: TextStyle(
                          color: Theme.of(context).canvasColor,
                          height: 1,
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

  String? selectedValueCustomize;
  int initialLabelIndexCustomize = 0;
  //int selectedCustomizeMenu = 0;
  bool _isProcessOnceValidNumber(String processOnce) {
     return processOnce.contains(RegExp(r'\d'));
     }

  Widget customizeBarCustom(BuildContext context, WidgetRef ref) {
    var readUpdateData = ref.read(updateDataRiverpod);
    final _customize = readUpdateData.getProcessOnce();
  bool menuController = _isProcessOnceValidNumber(_customize.text);
    ///RAKAM İÇERİRSE TRUE
    var size = MediaQuery.of(context).size;
    List<String> repetitiveList = [
      translation(context).dailyAddData,
      translation(context).weeklyAddData,
      translation(context).biweekly,
      translation(context).monthlyAddData,
      translation(context).bimonthly,
      translation(context).everyThreeMonths,
      translation(context).everyFourMonths,
      translation(context).everySixMonths,
      translation(context).yearlyAddData,
    ];
    return SizedBox(
      height: 38,
      width: size.width * 0.95,
      child: Stack(
        children: [
          Padding(
            padding:  EdgeInsets.only(top: 2,left: 2,right: 2),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Theme.of(context).disabledColor,
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
                child: Center(
                  child: Text(
                    translation(context).customize,
                    style: TextStyle(
                      color: renkler.yaziRenk,
                      fontSize: 15,
                      fontFamily: 'Nexa4',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              InkWell(
                child: SizedBox(
                  width: size.width * 0.95 - 130,
                  child: Center(
                    child: Text(
                      _customize.text == ""
                          ? translation(context).tapToCustomize
                          :  menuController == false
                          ? '${translation(context).tekrarTurkEmpty} ${_customize.text} ${translation(context).turkTekrarOnly}'
                          : '${translation(context).taksitArabicOnly} ${_customize.text} ${translation(context).ayTaksitArapcaEpty} ${translation(context).taksitDevamArabicOnly}',
                      style: TextStyle(
                        height: 1,
                        fontSize: 14,
                        fontFamily: 'Nexa3',
                          color: renkler.koyuuRenk
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    //_customize.clear();
                    //selectedValueCustomize = null;
                  });
                  showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return AlertDialog(
                            backgroundColor: Theme.of(context).primaryColor,
                            shadowColor: Colors.black54,
                            contentPadding: const EdgeInsets.only(
                                top: 10, bottom: 10),
                            insetPadding: const EdgeInsets.symmetric(
                                horizontal: 15),
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
                                      const EdgeInsets.all(15),
                                      child: Container(
                                        width: size.width * 0.95,
                                        height: 92,
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
                                            width: 281,
                                            height: 30,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Theme.of(context).highlightColor,
                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  menuController == true ? translation(context).installment : translation(context).repeat, style: TextStyle(
                                                    color: renkler.arkaRenk,fontSize: 18, fontFamily: 'Nexa4', height: 1,fontWeight: FontWeight.w800
                                                ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible : menuController == false,
                                                child: SizedBox(
                                            width: 280,
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
                                                        _customize.text != "" ? _customize.text : translation(context).select,
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
                                                            Center(
                                                              child: Text(
                                                                item,
                                                                style: TextStyle(fontSize: 18, fontFamily: 'Nexa3', color: Theme.of(context).canvasColor),
                                                              ),
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
                                                          convertedCustomize = Converter().textConverterToDB(_customize.text,context,1);
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
                                                        width: 280,
                                                      ),
                                                      dropdownStyleData:
                                                      DropdownStyleData(
                                                          maxHeight:
                                                          250,
                                                          width:
                                                          280,
                                                          decoration:
                                                          BoxDecoration(
                                                            color: Theme.of(context)
                                                                .primaryColor,
                                                          ),
                                                          scrollbarTheme: ScrollbarThemeData(
                                                              radius: const Radius.circular(
                                                                  15),
                                                              thumbColor:
                                                              MaterialStatePropertyAll(Theme.of(context).disabledColor))),
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
                                          ),
                                              ),
                                          Visibility(
                                            visible : menuController == true,
                                                child: SizedBox(
                                            width: 280,
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
                                                        translation(context).enterMonths,
                                                        hintStyle: TextStyle(
                                                            color: Theme.of(context)
                                                                .canvasColor,
                                                            fontSize:
                                                            15,
                                                            fontFamily:
                                                            'Nexa3'),
                                                        suffixText:
                                                        translation(context).month,
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
                                          ),
                                              ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceAround,
                                            children: [
                                              menuController ==
                                                  true
                                                  ? SizedBox(
                                                width: 140,
                                                height: 30,
                                                child: Align(
                                                  alignment: Alignment
                                                      .centerLeft,
                                                  child: FittedBox(
                                                    child: Text(
                                                      translation(context).monthlyInstallment,
                                                      style: TextStyle(
                                                        backgroundColor:
                                                        Theme.of(
                                                            context)
                                                            .primaryColor,
                                                        color: Theme.of(context).canvasColor,
                                                        fontSize: 13,
                                                        height: 1,
                                                        fontFamily:
                                                        'Nexa4',
                                                        fontWeight:
                                                        FontWeight
                                                            .w800,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                                  : SizedBox(
                                                width: 110,
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
                                                                5),
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
                                                    translation(context).remove,
                                                    style: TextStyle(
                                                      color: renkler
                                                          .arkaRenk,
                                                      fontSize: 12,
                                                      fontFamily:
                                                      'Nexa3',
                                                      height: 1
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
                                                                10),
                                                          ))),
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop();
                                                  },
                                                  child: Text(
                                                    translation(context).doneCategory,
                                                    style: TextStyle(
                                                      color:
                                                      renkler.koyuuRenk,
                                                      fontSize: 16,
                                                      fontFamily: 'Nexa3',
                                                      height: 1
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
                                /*
                                Text(
                                  "Debug:${_customize.text}",
                                  style: const TextStyle(color: Colors.red),
                                )
                               */
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

  Widget operationCustomButton(BuildContext context) {
    var readUpdateData = ref.read(updateDataRiverpod);
    var read = ref.read(databaseRiverpod);
    var readHome = ref.read(homeRiverpod);
    var readDailyInfo = ref.read(dailyInfoRiverpod);
    final id = readUpdateData.getId();
    final operationType = readUpdateData.getType();
    final note = readUpdateData.getNote();
    final amount0 = readUpdateData.getAmount();
    final category = readUpdateData.getCategory();
    final operationTool = readUpdateData.getOperationTool();
    final operationDate = readUpdateData.getOperationDate();
    final registration = readUpdateData.getRegistration();
    final customize = readUpdateData.getProcessOnce();
    final moneyType = readUpdateData.getMoneyType();
    final realAmount0 = readUpdateData.getRealAmount();
    final userCategory = readUpdateData.getUserCategory();
    var systemMessage = readUpdateData.getSystemMessage();
    var menuController = readUpdateData.getMenuController();
    var size = MediaQuery.of(context).size;
    String alertContent = '';
    int alertOperator = 0;
    double amount = double.tryParse(amount0.text) ?? 0.0;
    var readSettings = ref.read(settingsRiverpod);
    var adCounter = readSettings.adCounter;
    void setAlertContent(BuildContext context) {
      if (amount == 0 && category.text.isEmpty) {
        alertContent = translation(context).enterAmountAndCategory;
        alertOperator = 1;
      } else if (category.text.isNotEmpty) {
        alertContent = translation(context).pleaseEnterAnAmount;
        alertOperator = 2;
      } else {
        alertContent = translation(context).enterCategoryWarning;
        alertOperator = 3;
      }
    }
    return SizedBox(
      width: size.width * 0.9,
      height: 50,
      child: Center(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Theme.of(context).disabledColor,
              ),
              height: 40,
              width: size.width*0.4,
              child: TextButton(
                onPressed: ()  {
                  setAlertContent(context);
                  double amount = double.tryParse(amount0.text) ?? 0.0;
                  if (amount != 0.0 && category.text.isNotEmpty) {
                    if (_isProcessOnceValidNumber(customize.text) == true &&
                        customize.text != "") {
                      List <String> parts = customize.text.split("/");
                      customize.text = parts.length == 2 ?  parts[1] : parts[0];
                      amount = double.parse((amount / double.parse(customize.text)).toStringAsFixed(2));
                      systemMessage.text = "1/${customize.text}";
                      convertedCustomize = "1/${customize.text}";
                      customize.text = "1/${customize.text}";
                    } else if (_isProcessOnceValidNumber(customize.text) == false &&
                        customize.text != "") {
                      systemMessage = convertedCustomize != "" ? convertedCustomize : Converter().textConverterToDB(customize.text,context,1);
                    }
                        if(menuController == 0){
                          readUpdateData.updateDataBase(
                            int.parse(id),
                            operationType.text,
                            convertedCategory,
                            operationTool.text,
                            int.parse(registration.text),
                            amount,
                            note.text,
                            operationDate.text,
                            moneyType.text,
                            convertedCustomize != "" ? convertedCustomize : Converter().textConverterToDB(customize.text,context,1),
                            ref.read(currencyRiverpod).calculateRealAmount(amount, moneyType.text, ref.read(settingsRiverpod).Prefix!),
                            userCategoryController != "" ? userCategoryController : category.text == userCategory.text ? userCategory.text : "",
                            customize.text != "" ? systemMessage.toString() : "");
                        read.update();}
                        else{
                          read.insertDataBase(
                            operationType.text,
                            convertedCategory,
                            operationTool.text,
                            int.parse(registration.text),
                            amount,
                            note.text,
                            operationDate.text,
                            moneyType.text,
                            ref.read(currencyRiverpod).calculateRealAmount(amount, moneyType.text, ref.read(settingsRiverpod).Prefix!),
                            convertedCustomize != "" ? convertedCustomize : Converter().textConverterToDB(customize.text,context,1),
                            userCategoryController != "" ? userCategoryController : category.text == userCategory.text ? userCategory.text : "",
                            customize.text != "" ? systemMessage.toString() : "",
                          );
                        }
                    read.searchText != "" ? read.searchItem(read.searchText) : null;
                    readHome.setStatus();
                    readDailyInfo.setSpendDetailItemWithId(int.parse(id));
                    if (adCounter == 0) {
                      _showInterstitialAd(context);
                      readSettings.resetAdCounter();
                    } else {
                      readSettings.useAdCounter();
                    }
                    if(menuController == 1){
                      Navigator.of(context).pop();
                    }
                    Navigator.of(context).pop();
                    //Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor:
                        const Color(0xff0D1C26),
                        duration: const Duration(seconds: 1),
                        content: Text(
                          menuController == 0 ? translation(context).activityUpdated : translation(context).activityAdded,
                          style: TextStyle(
                            color: renkler.yaziRenk,
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
                            title: Text(translation(context).missingEntry,style: TextStyle(color: Theme.of(context).secondaryHeaderColor,fontSize: 22,height: 1,fontFamily: 'Nexa3')),
                            content: Text(alertContent,style: TextStyle(color: Theme.of(context).canvasColor,fontSize: 16,height: 1,fontFamily: 'Nexa3'),),
                            shadowColor: renkler.koyuuRenk,
                            actions: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    if (alertOperator == 1) {
                                      amount0.clear();
                                      category.clear();
                                    } else if (alertOperator == 2) {
                                      amount0.clear();
                                      category.clear();
                                    } else if(alertOperator == 3){
                                      category.clear();
                                    }
                                    else{
                                      amount0.clear();
                                      category.clear();
                                    }
                                  });
                                  Navigator.of(context).pop();
                                  //FocusScope.of(context).requestFocus(amountFocusNode);
                                },
                                child: Text("Tamam",style: TextStyle(color: Theme.of(context).secondaryHeaderColor,fontSize: 18,fontFamily: 'Nexa3'),),
                              )
                            ],
                          );
                        });
                  }
                },
                child: Text(menuController == 0 ? translation(context).updateDone : translation(context).done,
                    style: const TextStyle(
                        color: Color(0xff0D1C26),
                        fontSize: 17,
                        fontFamily: 'Nexa4',
                        fontWeight: FontWeight.w900)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
