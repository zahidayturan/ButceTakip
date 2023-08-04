import 'package:butcekontrol/constans/material_color.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' as intl;
import 'package:intl/intl.dart';
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
                      translation(context).editTitle,
                        height: 1,
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
                child: const Padding(
                  padding: EdgeInsets.only(left: 20, top: 20),
                  child: Text(
                    'İŞLEM DÜZENLEME',
                    style: TextStyle(
                      fontFamily: 'Nexa4',
                      fontSize: 22,
                      color: Colors.white,
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
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: SizedBox(
        height: size.height*0.85,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [typeCustomButton(context), dateCustomButton(context)],
            ),
            const SizedBox(
              height: 15,
            ),
            categoryBarCustom(context,ref),
            /*
            categoryBarCustomButton(context),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const SizedBox(width: 15,),
                Expanded(
                    child: categoryCustomButton(context)),
                const SizedBox(width: 15,),
              ],
            ),*/
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                toolCustomButton(context),
                regCustomButton(context),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            noteCustomButton(context),
            const SizedBox(
              height: 5,
            ),
            customizeBarCustom(context,ref),
            const SizedBox(
              //height: 15,
              height : 5,
            ),
            amountCustomButton(context),
            SizedBox(
                width: size.width*0.9,
                child: Text('DEBUG: ${operationType.text} - ${category.text} - ${operationTool.text} - ${int.parse(registration.text)} - ${amount.text} - ${note.text} - ${customize.text} -${operationDate.text}',style: const TextStyle(color: Colors.red))),
            const SizedBox(
              height: 5,
            ),
            operationCustomButton(context),
          ],
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

    return SizedBox(
        height: 40,
        child: ToggleSwitch(
          initialLabelIndex: initialLabelIndex,
          totalSwitches: 2,
          labels: const ['GİDER', 'GELİR'],
          activeBgColor: const [Color(0xffF2CB05)],
          activeFgColor: const Color(0xff0D1C26),
          inactiveBgColor: Theme.of(context).highlightColor,
          inactiveFgColor: const Color(0xFFE9E9E9),
          minWidth: 80,
          cornerRadius: 20,
          radiusStyle: true,
          animate: true,
          curve: Curves.linearToEaseOut,
          customTextStyles: const [
            TextStyle(
                fontSize: 17, fontFamily: 'Nexa4', fontWeight: FontWeight.w800)
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
  Widget categoryBarCustom(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size;
    var readUpdateDB = ref.read(updateDataRiverpod);
    final category = readUpdateDB.getCategory();
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
          ] ;
          final categoryListIncome = categoryLists['income'] ?? ['Kategori bulunamadı'];
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
          ] ;
          final categoryListExpense = categoryLists['expense'] ?? ['Kategori bulunamadı'];

          Set<String> mergedSetIncome = {...oldCategoryListIncome, ...categoryListIncome};
          List<String> mergedIncomeList = mergedSetIncome.toList();
          Set<String> mergedSetExpens = {...oldCategoryListExpense, ...categoryListExpense};
          List<String> mergedExpensList = mergedSetExpens.toList();
          return SizedBox(
            height: 40,
            width: size.width * 0.9,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      color: Color(0xFFF2CB05),
                    ),
                    height: 34,
                    width: size.width * 0.9,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 130,
                        ),
                        InkWell(
                          child: SizedBox(
                            width: size.width * 0.9 - 135,
                            child: Center(
                              child: Text(
                                category.text == ""
                                    ? "Seçmek için dokunun"
                                    : "${category.text}",
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Nexa3',
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              category.clear();
                              selectedValue = null;
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
                                          borderRadius: BorderRadius.all(Radius.circular(15))),
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
                                                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                                                      border: Border.all(width: 1.5,color: Theme.of(context).secondaryHeaderColor,)
                                                  ),
                                                ),
                                              ),
                                              Center(
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      width: 221,
                                                      height : 30,
                                                      child: ToggleSwitch(
                                                        initialLabelIndex: initialLabelIndex2,
                                                        totalSwitches: 2,
                                                        labels: const ['SEÇ', 'EKLE'],
                                                        activeBgColor: const [Color(0xffF2CB05)],
                                                        activeFgColor: const Color(0xff0D1C26),
                                                        inactiveBgColor: Theme.of(context).highlightColor,
                                                        inactiveFgColor: const Color(0xFFE9E9E9),
                                                        minWidth: 110,
                                                        cornerRadius: 20,
                                                        radiusStyle: true,
                                                        animate: true,
                                                        curve: Curves.linearToEaseOut,
                                                        customTextStyles: const [
                                                          TextStyle(
                                                              fontSize: 18, fontFamily: 'Nexa4', fontWeight: FontWeight.w800)
                                                        ],
                                                        onToggle: (index) {
                                                          setState(() {
                                                            if (index == 0) {
                                                              selectedAddCategoryMenu = 0;
                                                              category.clear();

                                                            } else {
                                                              selectedAddCategoryMenu = 1;
                                                              category.clear();
                                                            }
                                                            initialLabelIndex2 = index!;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                    selectedAddCategoryMenu == 0 ?  SizedBox(
                                                      width: 200,
                                                      height: 60,
                                                      child: Column(
                                                        children: [
                                                          const SizedBox(height: 10,),
                                                          DropdownButtonHideUnderline(
                                                            child: DropdownButton2<String>(
                                                              isExpanded: true,
                                                              hint: Text(
                                                                'Seçiniz',
                                                                style: TextStyle(
                                                                  fontSize: 18,
                                                                  fontFamily: 'Nexa3',
                                                                  color: Theme.of(context).canvasColor,
                                                                ),
                                                              ),
                                                              items: selectedCategory == 0 ? mergedExpensList
                                                                  .map((item) => DropdownMenuItem(
                                                                value: item,
                                                                child: Text(
                                                                  item,
                                                                  style: TextStyle(
                                                                      fontSize: 18,
                                                                      fontFamily: 'Nexa3',
                                                                      color: Theme.of(context).canvasColor),
                                                                ),
                                                              ))
                                                                  .toList() : mergedIncomeList
                                                                  .map((item) => DropdownMenuItem(
                                                                value: item,
                                                                child: Text(
                                                                  item,
                                                                  style: TextStyle(
                                                                      fontSize: 18,
                                                                      fontFamily: 'Nexa3',
                                                                      color: Theme.of(context).canvasColor),
                                                                ),
                                                              ))
                                                                  .toList(),
                                                              value: selectedValue,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  selectedValue = value;
                                                                  category.text = value.toString();
                                                                  this.setState(() {});
                                                                });
                                                              },
                                                              barrierColor: renkler.koyuAraRenk.withOpacity(0.8),
                                                              buttonStyleData:
                                                              ButtonStyleData(
                                                                overlayColor: MaterialStatePropertyAll(renkler.koyuAraRenk), // BAŞLANGIÇ BASILMA RENGİ
                                                                padding: const EdgeInsets.symmetric(
                                                                    horizontal: 16),
                                                                height: 40,
                                                                width: 200,
                                                              ),
                                                              dropdownStyleData:
                                                              DropdownStyleData(
                                                                  maxHeight: 250, width: 200,
                                                                  decoration: BoxDecoration(
                                                                    color: Theme.of(context).primaryColor,
                                                                  ),
                                                                  scrollbarTheme: ScrollbarThemeData(
                                                                      radius: const Radius.circular(15),
                                                                      thumbColor: MaterialStatePropertyAll(renkler.sariRenk)
                                                                  )),
                                                              menuItemStyleData:
                                                              MenuItemStyleData(
                                                                overlayColor: MaterialStatePropertyAll(renkler.koyuAraRenk), // MENÜ BASILMA RENGİ
                                                                height: 40,
                                                              ),
                                                              iconStyleData: IconStyleData(
                                                                icon: const Icon(
                                                                  Icons.arrow_drop_down,
                                                                ),
                                                                iconSize: 30,
                                                                iconEnabledColor: Theme.of(context).secondaryHeaderColor,
                                                                iconDisabledColor: Theme.of(context).secondaryHeaderColor,
                                                                openMenuIcon: Icon(
                                                                  Icons.arrow_right,
                                                                  color: Theme.of(context).canvasColor,
                                                                  size: 24,
                                                                ),
                                                              ),
                                                              dropdownSearchData:
                                                              DropdownSearchData(
                                                                searchController: category,
                                                                searchInnerWidgetHeight: 50,
                                                                searchInnerWidget: Container(
                                                                  height: 50,
                                                                  padding: const EdgeInsets.only(
                                                                    top: 8,
                                                                    bottom: 4,
                                                                    right: 8,
                                                                    left: 8,
                                                                  ),

                                                                  child: TextField(
                                                                    textCapitalization: TextCapitalization.words,
                                                                    expands: true,
                                                                    maxLines: null,
                                                                    style: TextStyle(
                                                                      color: Theme.of(context).canvasColor,
                                                                    ),
                                                                    controller:
                                                                    category,
                                                                    decoration: InputDecoration(
                                                                      isDense: true,
                                                                      contentPadding:
                                                                      const EdgeInsets
                                                                          .symmetric(
                                                                        horizontal: 10,
                                                                        vertical: 8,
                                                                      ),
                                                                      hintText: 'Kategori Arayın',
                                                                      hintStyle: TextStyle(
                                                                          fontSize: 18,
                                                                          color:
                                                                          Theme.of(context).secondaryHeaderColor),
                                                                      border: OutlineInputBorder(
                                                                        borderRadius:
                                                                        BorderRadius.circular(
                                                                            8),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                searchMatchFn:
                                                                    (item, searchValue) {
                                                                  return item.value
                                                                      .toString()
                                                                      .contains(searchValue);
                                                                },
                                                              ),
                                                              //This to clear the search value when you close the menu
                                                              onMenuStateChange: (isOpen) {
                                                                if (!isOpen) {
                                                                  category.clear();
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ) : const SizedBox(),
                                                    selectedAddCategoryMenu == 1 ? SizedBox(
                                                      width: 220,
                                                      height: 60,
                                                      child: Column(
                                                        children: [
                                                          const SizedBox(height: 10,),
                                                          TextField(
                                                            maxLength: 20,
                                                            maxLines: 1,
                                                            style:
                                                            TextStyle(color: Theme.of(context).canvasColor,fontSize: 17,fontFamily: 'Nexa3'),
                                                            decoration: InputDecoration(
                                                                hintText: 'Kategoriyi yazınız',
                                                                hintStyle: TextStyle(
                                                                    color: Theme.of(context).canvasColor,
                                                                    fontSize: 18,
                                                                    fontFamily: 'Nexa3'),
                                                                counterText: '',
                                                                border: InputBorder.none),
                                                            cursorRadius: const Radius.circular(10),
                                                            keyboardType: TextInputType.text,
                                                            textCapitalization: TextCapitalization.words,
                                                            controller: category,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                this.setState(() {});
                                                              });
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ): const SizedBox(),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      children: [
                                                        initialLabelIndex2 == 1 ? SizedBox(
                                                          width: 80,
                                                          height: 30,
                                                          child: Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Text(
                                                              '${category.text.length.toString()}/20',
                                                              style: TextStyle(
                                                                backgroundColor: Theme.of(context).primaryColor,
                                                                color: const Color(0xffF2CB05),
                                                                fontSize: 13,
                                                                fontFamily: 'Nexa4',
                                                                fontWeight: FontWeight.w800,
                                                              ),
                                                            ),
                                                          ),
                                                        ): const SizedBox(width: 80,),
                                                        SizedBox(
                                                          width: 80,
                                                          height: 30,
                                                          child: TextButton(
                                                            style: ButtonStyle(
                                                                backgroundColor: MaterialStatePropertyAll(renkler.sariRenk),
                                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                    RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.circular(20),
                                                                    )
                                                                )
                                                            ),
                                                            onPressed: () {
                                                              Navigator.of(context).pop();
                                                            },
                                                            child: Text("Tamam",style: TextStyle(
                                                              color: renkler.koyuuRenk,
                                                              fontSize: 16, fontFamily: 'Nexa3',
                                                            ),),
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
                                            "Debug:${category.text}",
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
                  ),
                ),
                      child: Text(translation(context).expenses,
                            height: 1,
                Container(
                  width: 130,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(context).highlightColor,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: const Center(
                    child: Text(
                      "KATEGORİ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Nexa4',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  DateTime? _selectedDate;
  Widget dateCustomButton(BuildContext context) {
    var readUpdateData = ref.read(updateDataRiverpod);
    final operationDate = readUpdateData.getOperationDate();
    Future<void> selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        locale: const Locale("tr"),
        context: context,
        initialDate: _selectedDate ?? DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2030),
        builder: (context, child) {
          FocusScope.of(context).unfocus();
          return Theme(
            data: Theme.of(context).copyWith(
              textTheme: const TextTheme(
                  headlineLarge: TextStyle(
                      fontFamily: 'Nexa4', fontWeight: FontWeight.w900)),
              colorScheme: const ColorScheme(
                brightness: Brightness.light,
                primary: Color(0xff0D1C26), // üst taraf arkaplan rengi
                onPrimary: Colors.white,
                secondary: Color(0xff0D1C26),
                onSecondary: Color(0xFF1A8E58),
                error: Color(0xFFD91A2A),
                onError: Color(0xFFD91A2A),
                background: Color(0xffF2CB05),
                onBackground: Color(0xffF2CB05),
                surface: Color(0xffF2CB05),
                onSurface: Color(0xff0D1C26), //günlerin rengi
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

    return SizedBox(
      height: 40,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(40)),
                color: Theme.of(context).highlightColor,
              ),
              height: 34,
              width: 205,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Row(
              children: [
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text(translation(context).date,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontFamily: 'Nexa4',
                            fontWeight: FontWeight.w800)),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    color: Color(0xffF2CB05),
                  ),
                  child: SizedBox(
                    height: 40,
                    width: 130,
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
                          fontSize: 17,
                          fontFamily: 'Nexa4',
                          fontWeight: FontWeight.w800),
                      controller: operationDate,
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
          ),
        ],
      ),
    );
  }

  Widget amountCustomButton(BuildContext context) {
    var readUpdateData = ref.read(updateDataRiverpod);
    final amount = readUpdateData.getAmount();
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: 40,
      width: size.width * 0.9,
      child: Stack(
        children: [
          Positioned(
            top: 18,
            child: Container(
              width: size.width * 0.9,
              height: 4,
              decoration: BoxDecoration(
                  color: Theme.of(context).highlightColor,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 39),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(40)),
                  color: Theme.of(context).highlightColor,
                ),
                height: 34,
                width: 185,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
                    child: Text(translation(context).amountDetails,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontFamily: 'Nexa4',
                            fontWeight: FontWeight.w800)),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    color: Color(0xffF2CB05),
                  ),
                  child: SizedBox(
                    height: 40,
                    width: 110,
                    child: TextFormField(
                        onTap: () {
                          //amount.clear();
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
                            RegExp(r'^\d{0,5}(\.\d{0,2})?'),),
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
                              color: Theme.of(context).splashColor,
                            ),
                            contentPadding: const EdgeInsets.only(top: 12))),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  height: 34,
                  width: 34,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color(0xffF2CB05),
                  ),
                  child: const Center(
                    child: Text(
                      '₺',
                      style: TextStyle(
                        fontFamily: 'TL',
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff0D1C26),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  int selectedCategory = 0;
  int initialLabelIndexTool = 0;
  Widget toolCustomButton(BuildContext context) {
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
        height: 40,
        child: ToggleSwitch(
          initialLabelIndex: initialLabelIndexTool,
          totalSwitches: 3,
          dividerColor: Theme.of(context).highlightColor,
          labels: const ['NAKİT', 'KART', 'DİĞER'],
          activeBgColor: const [Color(0xffF2CB05)],
          activeFgColor: const Color(0xff0D1C26),
          inactiveBgColor: Theme.of(context).highlightColor,
          inactiveFgColor: const Color(0xFFE9E9E9),
          minWidth: 80,
          cornerRadius: 20,
          radiusStyle: true,
          animate: true,
          curve: Curves.linearToEaseOut,
          customTextStyles: const [
            TextStyle(
                fontSize: 17, fontFamily: 'Nexa4', fontWeight: FontWeight.w800)
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
                operationTool.text = "Diger";
              });
            }
            initialLabelIndexTool = index!;
          },
        ));
  }



  int regss = 0;
  Widget regCustomButton(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(40)),
                color: Theme.of(context).highlightColor,
              ),
              height: 34,
              width: 130,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Row(
              children: [
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text(translation(context).save,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
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
                    height: 40,
                    width: 40,
                    child: registration(regss),
                  ),
                ),
              ],
            ),
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
          icon: const Icon(
            Icons.bookmark_add_outlined,
            color: Colors.white,
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
      width: size.width * 0.9,
      height: 125,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              height: 90,
              width: size.width * 0.9,
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
            width: size.width * 0.88,
            height: 115,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18, right: 18, top: 34),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "Not eklemek için tıklayınız",
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
                        color: const Color(0xffF2CB05),
                        fontSize: 13,
                        fontFamily: 'Nexa4',
                        fontWeight: FontWeight.w800,
                      ),
                    )),
              ],
            ),
          ),
          Positioned(
            left: 20,
            child: SizedBox(
              width: 130,
              height: 40,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: Theme.of(context).secondaryHeaderColor,
                ),
                child:  Padding(
                  padding: const EdgeInsets.only(left: 10, top: 12),
                  child: Text(
                    "NOT EKLE",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                      fontFamily: 'Nexa4',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 20,
            top: 8,
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
                    "Temizle",
                    style: TextStyle(
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
    );
  }

  String? selectedValueCustomize;
  int initialLabelIndexCustomize = 0;
  int selectedCustomizeMenu = 0;
  Widget customizeBarCustom(BuildContext context, WidgetRef ref) {
    var readUpdateData = ref.read(updateDataRiverpod);
    final _customize = readUpdateData.getProcessOnce();
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
      height: 40,
      width: size.width * 0.9,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                color: Color(0xFFF2CB05),
              ),
              height: 34,
              width: size.width * 0.9,
              child: Row(
                children: [
                  const SizedBox(
                    width: 135,
                  ),
                  InkWell(
                    child: SizedBox(
                      width: size.width * 0.9 - 135,
                      child: Center(
                        child: Text(
                          _customize.text == ""
                              ? "Özelleştirmek için dokunun"
                              : selectedCustomizeMenu == 0
                              ? '${_customize.text} Tekrar'
                              : '${_customize.text} Ay Taksit',
                          style: const TextStyle(
                            fontSize: 15,
                            fontFamily: 'Nexa3',
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
                                                          _customize.text,
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
                                                        "Tamam",
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
            ),
          ),
          Container(
            width: 140,
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: const Center(
              child: Text(
                "ÖZELLEŞTİR",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Nexa4',
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget operationCustomButton(BuildContext context) {
    var readUpdateData = ref.read(updateDataRiverpod);
    var read = ref.read(databaseRiverpod);
    var readHome = ref.read(homeRiverpod);
    final id = readUpdateData.getId();
    final operationType = readUpdateData.getType();
    final note = readUpdateData.getNote();
    final amount0 = readUpdateData.getAmount();
    final category = readUpdateData.getCategory();
    final operationTool = readUpdateData.getOperationTool();
    final operationDate = readUpdateData.getOperationDate();
    final registration = readUpdateData.getRegistration();
    final customize = readUpdateData.getProcessOnce();
    var size = MediaQuery.of(context).size;
    String alertContent = '';
    int alertOperator = 0;
    double amount = double.tryParse(amount0.text) ?? 0.0;
    void setAlertContent() {
      if (amount == 0 && category.text.isEmpty) {
        alertContent = "Lütfen bir tutar ve bir kategori giriniz!";
        alertOperator = 1;
      } else if (category.text.isNotEmpty) {
        alertContent = "Lütfen bir tutar giriniz!";
        alertOperator = 2;
      } else {
        alertContent = "Lütfen bir kategori giriniz!";
        alertOperator = 3;
      }
    }
    return SizedBox(
      width: size.width * 0.9,
      height: 70,
      child: Center(
        child: SizedBox(
          width: 140,
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color(0xffF2CB05),
                ),
                height: 40,
                width: 140,
                child: TextButton(
                  onPressed: () {
                    setAlertContent();
                    double amount = double.tryParse(amount0.text) ?? 0.0;
                    if (amount != 0.0 && category.text.isNotEmpty) {
                          readUpdateData.updateDataBase(
                          int.parse(id),
                          operationType.text,
                          category.text,
                          operationTool.text,
                          int.parse(registration.text),
                          amount,
                          note.text,
                          operationDate.text,
                          customize.text);
                          read.update();
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      readHome.setStatus();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor:
                          const Color(0xff0D1C26),
                          duration: const Duration(seconds: 1),
                          content: Text(
                            translation(context).activityUpdated,
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
                              title: Text("Eksik İşlem Yaptınız",style: TextStyle(color: Theme.of(context).secondaryHeaderColor,fontSize: 22,fontFamily: 'Nexa3')),
                              content: Text(alertContent,style: TextStyle(color: Theme.of(context).canvasColor,fontSize: 16,fontFamily: 'Nexa3'),),
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
                  child: Text(translation(context).updateDone,
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
      ),
    );
  }
}
