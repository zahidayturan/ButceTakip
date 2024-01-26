import 'package:butcekontrol/classes/language.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:butcekontrol/utils/textConverter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class CategoryMenu extends ConsumerStatefulWidget {
  const CategoryMenu({Key? key}) : super(key: key);
  @override
  ConsumerState<CategoryMenu> createState() => _CategoryMenu();
}

class _CategoryMenu extends ConsumerState<CategoryMenu> {


  CustomColors renkler = CustomColors();
  Widget build(BuildContext context){
    var readUpdateDB = ref.read(updateDataRiverpod);
    var size = MediaQuery.of(context).size;
    var readHome = ref.read(homeRiverpod);
    var readAdd = ref.read(addDataRiverpod);
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
                      visible : readAdd.editChanger == 0 ,
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
                                            icon: const Icon(Icons
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
                                                readAdd.sortChanger = 0;
                                                readAdd.categoryColorChanger = 999;
                                                readAdd.category.clear();
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
                                        child: readAdd.editChanger == 0
                                            ? Center(
                                          child:
                                          FittedBox(
                                            child: Text(
                                              readAdd.selectedCategory ==
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
                                        )
                                            : Center(
                                          child: SizedBox(
                                            height: 30,
                                            child:
                                            TextField(
                                              onTap: () {
                                                setState((){
                                                  if (readAdd.categoryColorChanger != 999) {
                                                    readAdd.categoryColorChanger = 999;
                                                    readAdd.category.clear();
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
                                                  hintText: readAdd.selectedCategory == 0
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
                                              readAdd.category,
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
                                              color: readAdd.sortChanger == 0 ? Theme.of(context).highlightColor : Theme.of(context).disabledColor,
                                              borderRadius:
                                              const BorderRadius.all(
                                                  Radius.circular(5))),
                                          child:
                                          Padding(
                                            padding: const EdgeInsets.all(3),
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(
                                                        () {
                                                      readAdd.sortChanger == 1 ? readAdd.sortChanger = 2 : readAdd.sortChanger = 1;
                                                      readAdd.categoryColorChanger = 999;
                                                      readAdd.category.clear();
                                                    });
                                              },
                                              child: Image.asset(
                                                readAdd.sortChanger == 1 ? ref.read(settingsRiverpod).Language == "العربية" ? "assets/icons/sort1ar.png" : "assets/icons/sort1.png" : readAdd.sortChanger == 2 ? ref.read(settingsRiverpod).Language == "العربية" ? "assets/icons/sort2ar.png" :"assets/icons/sort2.png" : ref.read(settingsRiverpod).Language == "العربية" ? "assets/icons/sort1ar.png" : "assets/icons/sort1.png",
                                                color: readAdd.sortChanger == 0 ? renkler.arkaRenk : renkler.koyuuRenk,
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
                                            readAdd.heightChanger,
                                            //childAspectRatio:1/2,
                                            crossAxisSpacing:
                                            2,
                                            mainAxisSpacing:
                                            2),
                                        itemCount: getList(readAdd.selectedCategory, readAdd.sortChanger).length,
                                        itemBuilder:
                                            (BuildContext
                                        context,
                                            index) {
                                          return InkWell(
                                            onTap: () {
                                              setState(() {
                                                readAdd.category.text = getList(readAdd.selectedCategory, readAdd.sortChanger)[
                                                index]
                                                    .toString();
                                                readAdd.categoryColorChanger =
                                                    index;
                                                readAdd.convertedCategory = Converter().textConverterToDB(readAdd.category.text, context, 0);
                                                readAdd.userCategoryController = (oldCategoryListExpense.contains(Converter().textCategoryConverter(readAdd.category.text, context)) == false || oldCategoryListIncome.contains(Converter().textCategoryConverter(readAdd.category.text, context)) == false) ? Converter().textCategoryConverter(readAdd.category.text, context) : "";
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
                                                color: readAdd.editChanger == 0 ? readAdd.categoryColorChanger ==
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
                                                      getList(readAdd.selectedCategory, readAdd.sortChanger)[index],
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
                                            backgroundColor: readAdd.editChanger ==
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
                                            readAdd.isAdded = 1;
                                            readAdd.categoryColorChanger = 999;
                                            readAdd.category.clear();
                                            readAdd.editChanger == 0
                                                ? readAdd.editChanger =
                                            1
                                                : readAdd.editChanger =
                                            0;
                                            readAdd.heightChanger ==
                                                40.0
                                                ? readAdd.heightChanger =
                                            60.0
                                                : readAdd.heightChanger =
                                            40.0;
                                          });
                                        },
                                        child: FittedBox(
                                          child: Text(
                                            translation(context).addDeleteCategory,
                                            style: TextStyle(
                                              color: readAdd.editChanger ==
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
                      visible : readAdd.editChanger == 1,
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
                                                  readAdd.isAdded = 1;
                                                  if (readAdd.categoryColorChanger != 999) {
                                                    readAdd.categoryColorChanger = 999;
                                                    readAdd.category.clear();
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
                                                  hintText: readAdd.selectedCategory == 0
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
                                              readAdd.category,
                                              onChanged:
                                                  (value) {
                                                setState(
                                                        () {
                                                      readAdd.convertedCategory = readAdd.category.text;
                                                      readAdd.userCategoryController = readAdd.category.text;
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
                                              const BorderRadius.all(
                                                  Radius.circular(5))),
                                          child:
                                          IconButton(
                                            icon: const Icon(Icons
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
                                              if (readAdd.category
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

                                              }

                                              setState(
                                                      () {
                                                    readAdd.userCategoryController = (oldCategoryListExpense.contains(Converter().textCategoryConverter(readAdd.category.text, context)) == false || oldCategoryListIncome.contains(Converter().textCategoryConverter(readAdd.category.text, context)) == false) ? Converter().textCategoryConverter(readAdd.category.text, context) : "";
                                                    readAdd.convertedCategory = readAdd.category.text;
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
                                  readAdd.selectedAddCategoryMenu ==
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
                                              readAdd.heightChanger,
                                              //childAspectRatio:1/2,
                                              crossAxisSpacing:
                                              2,
                                              mainAxisSpacing:
                                              2),
                                          itemCount:getList(readAdd.selectedCategory, readAdd.sortChanger).length,
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
                                                color: readAdd.editChanger == 0 ? readAdd.categoryColorChanger ==
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
                                                      getList(readAdd.selectedCategory, readAdd.sortChanger)[index]
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
                                                  (readAdd.selectedCategory == 0 ? oldCategoryListExpense.contains(getList(readAdd.selectedCategory, readAdd.sortChanger)[index].toString()) == false : oldCategoryListIncome.contains(getList(readAdd.selectedCategory, readAdd.sortChanger)[index].toString()) == false) ?
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
                                                        BoxDecoration(color: renkler.kirmiziRenk, borderRadius: const BorderRadius.all(Radius.circular(5))),
                                                        child:
                                                        IconButton(
                                                          onPressed: () {
                                                            setState((){
                                                              readAdd.categoryController.text = getList(readAdd.selectedCategory, readAdd.sortChanger)[index];
                                                              readAdd.editChanger = 2;
                                                              readAdd.categoryDeleteChanger=0;
                                                              readAdd.category.clear();
                                                              readAdd.isAdded = 0;
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
                                                        BoxDecoration(color: Theme.of(context).secondaryHeaderColor, borderRadius: const BorderRadius.all(Radius.circular(5))),
                                                        child:
                                                        IconButton(
                                                          onPressed: () {
                                                            setState((){
                                                              readAdd.categoryController.text = getList(readAdd.selectedCategory, readAdd.sortChanger)[index];
                                                              readAdd.editChanger = 3;
                                                              readAdd.categoryEditChanger=0;
                                                              readAdd.categoryDeleteChanger2=0;
                                                              readAdd.category.clear();
                                                              readAdd.isAdded = 0;
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
                                            backgroundColor: readAdd.editChanger ==
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
                                            readAdd.isAdded = 0;
                                            readAdd.editChanger == 0
                                                ? readAdd.editChanger =
                                            1
                                                : readAdd.editChanger =
                                            0;
                                            readAdd.heightChanger ==
                                                40.0
                                                ? readAdd.heightChanger =
                                            60.0
                                                : readAdd.heightChanger =
                                            40.0;
                                          });
                                        },
                                        child: FittedBox(
                                          child: Text(
                                            translation(context).addDeleteCategory,
                                            style: TextStyle(
                                              color: readAdd.editChanger ==
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
                                        visible : readAdd.isAdded == 0,
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
                      visible : readAdd.editChanger == 3,
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
                                              const BorderRadius.all(
                                                  Radius.circular(5))),
                                          child:
                                          IconButton(
                                            icon: const Icon(Icons
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
                                                    readAdd.editChanger = 1;
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
                                  future: readUpdateDB.categoryUsageCount(readAdd.selectedCategory, readAdd.categoryController.text,0,''),
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
                                                            Text(readAdd.categoryController.text),
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
                                                        visible : readAdd.categoryEditChanger == 1,
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
                                                                  borderRadius: const BorderRadius.all(Radius.circular(5))
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
                                                                              const BorderRadius.all(
                                                                                  Radius.circular(5))),
                                                                          child:
                                                                          IconButton(
                                                                            icon: const Icon(Icons
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
                                                                                    readAdd.categoryEditChanger = 0;
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
                                                                                readAdd.categoryEditChanger2 == 3 ? translation(context).keepAndEdit: readAdd.categoryEditChanger2 == 4 ? translation(context).replaceAndEdit : "Düzenle",style: TextStyle(color: renkler.koyuuRenk),
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
                                                                        Text(translation(context).replaceCategoryQuestion,style: TextStyle(fontSize: 14,height: 1,color: Theme.of(context).canvasColor,), textAlign: TextAlign.center,),
                                                                        SizedBox(
                                                                          width : size.width*0.38,
                                                                          height: 24,
                                                                          child: TextFormField(
                                                                            maxLength: 20,
                                                                            maxLines: 1,
                                                                            style:
                                                                            TextStyle(color: Theme.of(context).canvasColor,fontSize: 13,fontFamily: 'Nexa3',height: 1),
                                                                            decoration: InputDecoration(
                                                                                hintText: translation(context).enterCategory,
                                                                                hintStyle: TextStyle(
                                                                                    color: Theme.of(context).canvasColor,
                                                                                    fontSize: 13,
                                                                                    fontFamily: 'Nexa3'),
                                                                                counterText: '',
                                                                                border: InputBorder.none,
                                                                                isDense: true),
                                                                            cursorRadius: const Radius.circular(10),
                                                                            keyboardType: TextInputType.text,
                                                                            textCapitalization: TextCapitalization.words,
                                                                            controller: readAdd.categoryEdit,
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
                                                                        if (readAdd.categoryEdit
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
                                                                          readUpdateDB.categoryUsageCount(readAdd.selectedCategory, readAdd.categoryController.text,readAdd.categoryEditChanger2,readAdd.categoryEdit.text);
                                                                          setState(
                                                                                  () {
                                                                                readAdd.categoryEdit.clear();
                                                                                readAdd.editChanger = 1;
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
                                                                        readAdd.categoryEdit.text != '' ? "${translation(context).replaceWithExceptTurkish} ${readAdd.categoryEdit.text} ${translation(context).replaceWithOnlyTurkish}" : translation(context).doneSmall,
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
                                                        visible : readAdd.categoryEditChanger == 0,
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
                                                                  readAdd.selectedValue = null;
                                                                  readAdd.categoryEdit.clear();
                                                                  readAdd.categoryEditChanger = 1;
                                                                  readAdd.categoryEditChanger2 = 3;
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
                                                        visible : readAdd.categoryEditChanger == 0,
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
                                                                  readAdd.selectedValue = null;
                                                                  readAdd.categoryEdit.clear();
                                                                  readAdd.categoryEditChanger = 1;
                                                                  readAdd.categoryEditChanger2 = 4;
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
                      visible : readAdd.editChanger == 2,
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
                                              const BorderRadius.all(
                                                  Radius.circular(5))),
                                          child:
                                          IconButton(
                                            icon: const Icon(Icons
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
                                                    readAdd.editChanger = 1;
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
                                    future: readUpdateDB.categoryUsageCount(readAdd.selectedCategory, readAdd.categoryController.text,0,''),
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
                                                              Text(readAdd.categoryController.text),
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
                                                          visible : readAdd.categoryDeleteChanger == 0,
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
                                                                    readAdd.selectedValue = null;
                                                                    readAdd.categoryEdit.clear();
                                                                    readAdd.categoryDeleteChanger =1;
                                                                    readAdd.categoryDeleteChanger2 = 0;});
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
                                                          visible : readAdd.categoryDeleteChanger == 0,
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
                                                                    readAdd.selectedValue = null;
                                                                    readAdd.categoryEdit.clear();
                                                                    readAdd.categoryDeleteChanger = 1 ;
                                                                    readAdd.categoryDeleteChanger2 = 1 ;
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
                                                          visible : readAdd.categoryDeleteChanger == 1,
                                                          child: Column(
                                                            children: [
                                                              Visibility(
                                                                visible : readAdd.categoryDeleteChanger2 == 0,
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
                                                                          borderRadius: const BorderRadius.all(Radius.circular(5))
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
                                                                                      const BorderRadius.all(
                                                                                          Radius.circular(5))),
                                                                                  child:
                                                                                  IconButton(
                                                                                    icon: const Icon(Icons
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
                                                                                            readAdd.categoryDeleteChanger = 0;
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
                                                                          Text(translation(context).categoryWillBeDeletedOldRecordsWillNotBeChanged,textAlign: TextAlign.center,maxLines: 3,style: const TextStyle(fontSize: 14),),
                                                                          InkWell(
                                                                            child: Container(
                                                                              width: 90,
                                                                              height: 26,
                                                                              decoration: BoxDecoration(
                                                                                  color: Theme.of(context).disabledColor,
                                                                                  borderRadius: const BorderRadius.all(Radius.circular(5))
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
                                                                              readUpdateDB.categoryUsageCount(readAdd.selectedCategory, readAdd.categoryController.text,1,'');
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
                                                                visible : readAdd.categoryDeleteChanger2 == 1,
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
                                                                          borderRadius: const BorderRadius.all(Radius.circular(5))
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
                                                                                      const BorderRadius.all(
                                                                                          Radius.circular(5))),
                                                                                  child:
                                                                                  IconButton(
                                                                                    icon: const Icon(Icons
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
                                                                                            readAdd.categoryDeleteChanger = 0;
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
                                                                                    Text(translation(context).replaceCategoryOldRecords,style: TextStyle(fontSize: 14,height: 1,color: Theme.of(context).canvasColor,), textAlign: TextAlign.center,),
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
                                                                                              height: 1
                                                                                          ),
                                                                                          //textAlign: TextAlign.center,
                                                                                        ),
                                                                                        items: readAdd.selectedCategory == 0
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
                                                                                        value: readAdd.selectedValue,
                                                                                        onChanged: (value) {
                                                                                          setState(() {
                                                                                            readAdd.selectedValue = value;
                                                                                            readAdd.categoryEdit.text = value.toString();
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
                                                                                if (readAdd.categoryEdit
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
                                                                                  readUpdateDB.categoryUsageCount(readAdd.selectedCategory, readAdd.categoryController.text,2,readAdd.categoryEdit.text);
                                                                                  setState(
                                                                                          () {
                                                                                        readAdd.categoryEdit.clear();
                                                                                        readAdd.editChanger = 1;
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
                                                                                readAdd.categoryEdit.text != '' ? "${translation(context).replaceWithExceptTurkish} ${readAdd.categoryEdit.text} ${translation(context).replaceWithOnlyTurkish}" : translation(context).doneSmall,
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
                                        "Debug:${readAdd.category.text} - ${readAdd.convertedCategory} - ${readAdd.userCategoryController}",
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
  }

}
